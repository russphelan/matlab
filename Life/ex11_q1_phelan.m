%Game of Life Simulation (John Conway). Makes a life board with randomly
%chosen starting cells, runs an iteration each click. 

%By: Russell J Phelan 12/6/14 UMass Amherst for Computational Physics 281

clear all

%Initializing life board
N=70;
colormap(bone); 
Y=randn(N,N); 
board=(Y>0);

%Setting buffer in edges to prevent clipping of cells
board(1,:) = 0;
board(:,1) = 0;
board(:,N) = 0;
board(N,:) = 0;

%draws original, randomized board
imagesc(~board); 

%tick algorithm 
for k=1:100 % waits for click to iterate further
    w = waitforbuttonpress;
    nextBoard = zeros(N,N);
    for j=2:N-1
        for i=2:N-1 %counts number of cells surrounding each board spot
            
            liveCells = 0; 
 
            if(board(i-1,j-1)==1) 
                liveCells = liveCells+1;
            end
            if(board(i,j-1)==1) 
                liveCells = liveCells+1;
            end
            if(board(i+1,j-1)==1) 
                liveCells = liveCells+1;
            end
            if(board(i-1,j)==1) 
                liveCells = liveCells+1;
            end
            if(board(i+1,j)==1) 
                liveCells = liveCells+1;
            end
            if(board(i-1,j+1)==1) 
                liveCells = liveCells+1;
            end
            if(board(i,j+1)==1) 
                liveCells = liveCells+1;
            end
            if(board(i+1,j+1)==1) 
                liveCells = liveCells+1;
            end
            
            %deciding which cells to kill, leave, and make
            if(board(i,j) == 1)
                if(liveCells == 2)
                    nextBoard(i,j) = 1;
                elseif(liveCells == 3)
                    nextBoard(i,j) = 1;
                else
                    nextBoard(i,j) = 0;
                end
            elseif(board(i,j) == 0)
                if(liveCells == 3)
                    nextBoard(i,j) = 1;
                else
                    nextBoard(i,j) = 0;
                end
            else
                nextBoard(i,j) = 0;
            end
        end
    end
    board = nextBoard;
    %draws new board
    imagesc(~board);
end