class Api::SodukuController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
        grid = params[:data]
        ans = false
        if (solve(grid))
            ans= true
        end
        if !ans
            render json: { status: "Solution not found for this" }
        end
    end

   def mongo
    p 11111111111111111111111111111111111111111111111111111111
     tes = Testmongo.find_or_initialize_by(title: "test",body: "test2")
     p 22222222222222222222222222222222222222222222222222222222222222
     render json: { status: tes }
   end
    

    private

    def solve(grid)
        rc = findUnassigned(grid)
        if (rc==0)
            render json: { solution: grid }
            return true
        end
        col = (rc%10)-1
        row = (rc/10)-1
       for k in 1..9 do
        if isSafe(grid,row,col,k)
            grid[row][col]=k
            if (solve(grid))
                return true
            end
            grid[row][col]=0
       end
      end
       return false 
    end

    def findUnassigned(grid)
        for i in 0..8 do
            for j in 0..8 do
                if grid[i][j]==0
                    return (((i+1)*10) + (j+1))
                end
            end
        end
        return 0
    end

    def findcol(grid,col,num)
        for i in 0..8 do
            if grid[i][col]==num
             return true
            end
        end
        return false
    end

    def findrow(grid,row,num)
        for j in 0..8 do
            if grid[row][j] == num
                return true
            end
        end
        return false
    end

    def findbox(grid , boxrow, boxcol, num)
        for i in 0..2 do
            for j in 0..2 do
                if (grid[i + boxrow][j+boxcol]==num)
                    return true
                end
            end
        end 
        return false
    end

    def isSafe(grid,row,col,num)
        return (!findcol(grid,col,num) && !findrow(grid,row,num) && !findbox(grid,row-(row%3), (col-(col%3)),num) && grid[row][col]==0)
    end


end