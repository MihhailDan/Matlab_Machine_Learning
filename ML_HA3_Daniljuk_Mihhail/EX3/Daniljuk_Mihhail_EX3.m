% Exercise 3 - I decided to try very new type of CNN for me, which is
% generative adversarial network (GAN)


% =========================================================================
% Downloading the dataset for training
url = "http://download.tensorflow.org/example_images/flower_photos.tgz";
downloadFolder = tempdir;
filename = fullfile(downloadFolder,"flower_dataset.tgz");

imageFolder = fullfile(downloadFolder,"flower_photos");
if ~exist(imageFolder,"dir")
    disp("Downloading Flowers data set (218 MB)...")
    websave(filename,url);
    untar(filename,downloadFolder)
end
datasetFolder = fullfile(imageFolder);
imds = imageDatastore(datasetFolder,IncludeSubfolders=true);

% =========================================================================
% Creating data augmenter
augmenter = imageDataAugmenter(RandXReflection=true);
augimds = augmentedImageDatastore([64 64],imds,DataAugmentation=augmenter);


% =========================================================================
% Defining Generator Network
filterSize = 5;
numFilters = 64;
numLatentInputs = 100;

projectionSize = [4 4 512];

layersGenerator = [
    featureInputLayer(numLatentInputs)
    fullyConnectedLayer(prod(projectionSize))
    functionLayer(@(X) feature2image(X,projectionSize),Formattable=true)
    transposedConv2dLayer(filterSize,4*numFilters)
    batchNormalizationLayer
    reluLayer
    transposedConv2dLayer(filterSize,2*numFilters,Stride=2,Cropping="same")
    batchNormalizationLayer
    reluLayer
    transposedConv2dLayer(filterSize,numFilters,Stride=2,Cropping="same")
    batchNormalizationLayer
    reluLayer
    transposedConv2dLayer(filterSize,3,Stride=2,Cropping="same")
    tanhLayer];

lgraphGenerator = layerGraph(layersGenerator);
dlnetGenerator = dlnetwork(lgraphGenerator);


% =========================================================================
% Defining Discriminator Network
dropoutProb = 0.5;
numFilters = 64;
scale = 0.2;

inputSize = [64 64 3];
filterSize = 5;

layersDiscriminator = [
    imageInputLayer(inputSize,Normalization="none")
    dropoutLayer(dropoutProb)
    convolution2dLayer(filterSize,numFilters,Stride=2,Padding="same")
    leakyReluLayer(scale)
    convolution2dLayer(filterSize,2*numFilters,Stride=2,Padding="same")
    batchNormalizationLayer
    leakyReluLayer(scale)
    convolution2dLayer(filterSize,4*numFilters,Stride=2,Padding="same")
    batchNormalizationLayer
    leakyReluLayer(scale)
    convolution2dLayer(filterSize,8*numFilters,Stride=2,Padding="same")
    batchNormalizationLayer
    leakyReluLayer(scale)
    convolution2dLayer(4,1)];
lgraphDiscriminator = layerGraph(layersDiscriminator);
dlnetDiscriminator = dlnetwork(lgraphDiscriminator);



% =========================================================================
% Defining all needed parameters to train the model
numEpochs = 500;
miniBatchSize = 128;
learnRate = 0.0002;
gradientDecayFactor = 0.5;
squaredGradientDecayFactor = 0.999;
flipFactor = 0.3;
validationFrequency = 100;

% Setting parameters 
augimds.MiniBatchSize = miniBatchSize;
executionEnvironment = "auto";
mbq = minibatchqueue(augimds,...
    MiniBatchSize=miniBatchSize,...
    PartialMiniBatch="discard",...
    MiniBatchFcn=@preprocessMiniBatch,...
    MiniBatchFormat="SSCB",...
    OutputEnvironment=executionEnvironment);

% Parameters for Adam
trailingAvgGenerator = [];
trailingAvgSqGenerator = [];
trailingAvgDiscriminator = [];
trailingAvgSqDiscriminator = [];

numValidationImages = 25;
ZValidation = randn(numLatentInputs,numValidationImages,"single");
dlZValidation = dlarray(ZValidation,"CB");

if (executionEnvironment == "auto" && canUseGPU) || executionEnvironment == "gpu"
    dlZValidation = gpuArray(dlZValidation);
end

% Creating initial canvas for plotting the state of training
f = figure;
f.Position(3) = 2*f.Position(3);
imageAxes = subplot(1,2,1);
scoreAxes = subplot(1,2,2);
lineScoreGenerator = animatedline(scoreAxes,Color=[0 0.447 0.741]);
lineScoreDiscriminator = animatedline(scoreAxes,Color=[0.85 0.325 0.098]);
legend("Generator","Discriminator");
ylim([0 1])
xlabel("Iteration")
ylabel("Score")
grid on


% =========================================================================
% Training
iteration = 0;
start = tic;
% Loop over epochs. Iterative training process
for epoch = 1:numEpochs
    
    % Reset and shuffle datastore.
    shuffle(mbq);
    
    % Loop over mini-batches.
    while hasdata(mbq)
        iteration = iteration + 1;
        
        % Read mini-batch of data.
        dlX = next(mbq);
        
        % Generate latent inputs for the generator network. Convert to
        % dlarray and specify the dimension labels "CB" (channel, batch).
        % If training on a GPU, then convert latent inputs to gpuArray.
        Z = randn(numLatentInputs,miniBatchSize,"single");
        dlZ = dlarray(Z,"CB");        
        
        if (executionEnvironment == "auto" && canUseGPU) || executionEnvironment == "gpu"
            dlZ = gpuArray(dlZ);
        end
        
        % Evaluate the model gradients and the generator state using
        % dlfeval and the modelGradients function listed at the end of the
        % example.
        [gradientsGenerator, gradientsDiscriminator, stateGenerator, scoreGenerator, scoreDiscriminator] = ...
            dlfeval(@modelGradients, dlnetGenerator, dlnetDiscriminator, dlX, dlZ, flipFactor);
        dlnetGenerator.State = stateGenerator;
        
        % Update the discriminator network parameters.
        [dlnetDiscriminator,trailingAvgDiscriminator,trailingAvgSqDiscriminator] = ...
            adamupdate(dlnetDiscriminator, gradientsDiscriminator, ...
            trailingAvgDiscriminator, trailingAvgSqDiscriminator, iteration, ...
            learnRate, gradientDecayFactor, squaredGradientDecayFactor);
        
        % Update the generator network parameters.
        [dlnetGenerator,trailingAvgGenerator,trailingAvgSqGenerator] = ...
            adamupdate(dlnetGenerator, gradientsGenerator, ...
            trailingAvgGenerator, trailingAvgSqGenerator, iteration, ...
            learnRate, gradientDecayFactor, squaredGradientDecayFactor);
        
        % Every validationFrequency iterations, display batch of generated images using the
        % held-out generator input.
        if mod(iteration,validationFrequency) == 0 || iteration == 1
            % Generate images using the held-out generator input.
            dlXGeneratedValidation = predict(dlnetGenerator,dlZValidation);
            
            % Tile and rescale the images in the range [0 1].
            I = imtile(extractdata(dlXGeneratedValidation));
            I = rescale(I);
            
            % Display the images.
            subplot(1,2,1);
            image(imageAxes,I)
            xticklabels([]);
            yticklabels([]);
            title("Generated Images");
        end
        
        % Update the scores plot.
        subplot(1,2,2)
        addpoints(lineScoreGenerator,iteration,...
            double(gather(extractdata(scoreGenerator))));
        
        addpoints(lineScoreDiscriminator,iteration,...
            double(gather(extractdata(scoreDiscriminator))));
        
        % Update the title with training progress information.
        D = duration(0,0,toc(start),Format="hh:mm:ss");
        title(...
            "Epoch: " + epoch + ", " + ...
            "Iteration: " + iteration + ", " + ...
            "Elapsed: " + string(D))
        
        drawnow
    end
end


% Generate new images after training 
numObservations = 25;
ZNew = randn(numLatentInputs,numObservations,"single");
dlZNew = dlarray(ZNew,"CB");

if (executionEnvironment == "auto" && canUseGPU) || executionEnvironment == "gpu"
    dlZNew = gpuArray(dlZNew);
end
dlXGeneratedNew = predict(dlnetGenerator,dlZNew);
I = imtile(extractdata(dlXGeneratedNew));
I = rescale(I);
figure
image(I)
axis off
title("Generated Images")


% =========================================================================
% Gradient function definition
function [gradientsGenerator, gradientsDiscriminator, stateGenerator, scoreGenerator, scoreDiscriminator] = ...
    modelGradients(dlnetGenerator, dlnetDiscriminator, dlX, dlZ, flipFactor)

    % Calculate the predictions for real data with the discriminator network.
    dlYPred = forward(dlnetDiscriminator, dlX);
    
    % Calculate the predictions for generated data with the discriminator network.
    [dlXGenerated,stateGenerator] = forward(dlnetGenerator,dlZ);
    dlYPredGenerated = forward(dlnetDiscriminator, dlXGenerated);
    
    % Convert the discriminator outputs to probabilities.
    probGenerated = sigmoid(dlYPredGenerated);
    probReal = sigmoid(dlYPred);
    
    % Calculate the score of the discriminator.
    scoreDiscriminator = (mean(probReal) + mean(1-probGenerated)) / 2;
    
    % Calculate the score of the generator.
    scoreGenerator = mean(probGenerated);
    
    % Randomly flip a fraction of the labels of the real images.
    numObservations = size(probReal,4);
    idx = randperm(numObservations,floor(flipFactor * numObservations));
    
    % Flip the labels.
    probReal(:,:,:,idx) = 1 - probReal(:,:,:,idx);
    
    % Calculate the GAN loss.
    [lossGenerator, lossDiscriminator] = ganLoss(probReal,probGenerated);
    
    % For each network, calculate the gradients with respect to the loss.
    gradientsGenerator = dlgradient(lossGenerator, dlnetGenerator.Learnables,RetainData=true);
    gradientsDiscriminator = dlgradient(lossDiscriminator, dlnetDiscriminator.Learnables);

end


% =========================================================================
% GAN Lossfunction
function [lossGenerator, lossDiscriminator] = ganLoss(probReal,probGenerated)

    % Calculate the loss for the discriminator network.
    lossDiscriminator = -mean(log(probReal)) - mean(log(1-probGenerated));
    
    % Calculate the loss for the generator network.
    lossGenerator = -mean(log(probGenerated));

end


% =========================================================================
% Mini-batch preproccessing function
function X = preprocessMiniBatch(data)

    % Concatenate mini-batch
    X = cat(4,data{:});
    
    % Rescale the images in the range [-1 1].
    X = rescale(X,-1,1,InputMin=0,InputMax=255);

end