require_relative "00_tree_node.rb"

class KnightPathFinder
    KNIGHT_MOVES = [[1,2], [2,1], [2,-1], [1,-2], [-1,-2], [-2,-1], [-2,1], [-1,2]]

    def self.valid_moves(pos)
        valid_moves = []
        KNIGHT_MOVES.each do |move|
            final_pos = [pos[0] + move[0], pos[1] + move[1]]
            valid_moves << final_pos if final_pos.all? {|coord| coord.between?(0, 7) }
        end
        valid_moves
    end

    attr_reader :root_node, :considered_positions, :start_pos

    def intialize(pos)
        @root_node = PolyTreeNode.new(pos)
        @considered_positions = [pos]
        @start_pos = pos #might not be necessary
    end

    def new_move_positions(pos)
        possible_moves = KnightPathFind.valid_moves(pos)
        new_valid_moves = possible_moves.reject {|possible_move| self.considered_positions.include?(possible_move) }
        self.considered_positions += new_valid_moves
        new_valid_moves
    end

    ### OK!

    def build_move_tree
        queue = [self.root_node]

        until queue.empty?
            current_node = queue.shift
            current_pos = current_node.value # necessary?

            moves_from_here = new_move_positions(current_pos)

            moves_from_here.each do |move|
                new_node = PolyTreeNode.new(move)
                new_node.parent = current_node
                queue << new_node
            end
        end

    end
end

p KnightPathFinder.valid_moves([0, 7])
