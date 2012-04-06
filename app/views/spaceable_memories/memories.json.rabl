collection @memories, :object_root => false

attribute :id
attribute :component_id => :item_id
node(:due) { |m| m.due? }
node :quizzes do |m|
  m.component.quizzes.map{|q| q.id }
end
