class PolyTreeNode

    attr_reader :value, :parent, :children

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    # WORKING VERSION
    # Make sure you understand this method because #add_child and #remove_child depend on it.
    def parent=(new_parent)
        if new_parent == nil
            @parent.children.delete(self) if self.parent != nil # remove self as a child from its parent
            @parent = nil
            return
        end

        if self.parent != nil # If self already has a parent
            @parent.children.delete(self)
        end
            
        @parent = new_parent
        @parent.children << self
    end

    def add_child(child)
        child.parent=(self) # How does #parent= take care of logic for us?
    end

    def remove_child(child)
        raise "That ain't my kid!!!" if !self.children.include?(child)
        child.parent=(nil) # parent= takes care of logic for us
    end

    def dfs(target) #("a", "g")
        return self if self.value == target # base case

        self.children.each do |child|
            search_result = child.dfs(target)
            return search_result if search_result != nil
        end
        
        return nil
    end
    
    def bfs(target)
        queue = [self]

        until queue.empty? # [d, e, f, g]
            current_node = queue.shift # b

            if current_node.value == target # fails
                return current_node
            else
                current_node.children.each do |child| # add d and e
                    queue << child
                end
            end
        end

        nil
    end

end