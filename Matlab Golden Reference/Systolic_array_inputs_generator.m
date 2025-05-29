clc; clear; 


%   This code is used to generate lowered matrix ready to be used with the
%   systolic.

% NOTE: the script assumes square shape of both image and kernel

%% Initialize

% Define Dimensions
image_size = 3;
kernel_size = 2;
channels = 1;
padding = 0;
stride = 1;

% Random values range
min_random_value = 0;
max_random_value = 100;

% Compute Number and the depths of FIFOs of inputs to the Systolic (From the image input
% side)(aka Lowered Matrix Rows)
Lowered_matrix_rows = (((image_size + (2*padding) - kernel_size)/stride)+1)^2;
Lowered_matrix_columns = kernel_size * kernel_size * channels;
Lowered_matrix_columns_with_zeros = Lowered_matrix_columns - 1;

%% Generate Random matrix for image & kernel
image = (max_random_value-min_random_value).*rand(image_size,image_size,channels) + min_random_value;
kernel = (max_random_value-min_random_value).*rand(kernel_size,kernel_size,channels) + min_random_value;

%% Lower the matrix
Lowered_image = zeros(Lowered_matrix_columns, Lowered_matrix_rows);

for convs = 1:1:Lowered_matrix_rows
    for ch = 1:1:channels
        for elements_y = 1: image_size : kernel_size/2
            for elements_x = 1:1:kernel_size/2
                Lowered_image(ch + element_y + elements_x ,convs) = image();
            end
        end
    end
end

%% Write the lowered matrix and flattenned kernel into text file

% Write the image matrix
image_file = fopen('lowered_image.txt','wt');
for y = 1:1:Lowered_matrix_rows
    for x = 1:1:Lowered_matrix_columns
        if (x > y)  fprintf(image_file, '%x', dec2hex(Lowered_image(x-y,y));
        else        fprintf(image_file, '%x', 0); 
                    fprintf(image_file, '%c', " ");
    end
end
fclose(image_file);
















