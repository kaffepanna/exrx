require 'active_record'

ActiveRecord::Base.establish_connection(
    :adapter => 'sqlite3',
    :database => './development.sqlite3'

)

module STIHasMany
  module ClassMethods
    def has_many_through_sti name, args ={}
      source = args[:source]
      class_name = args[:class_name]

      has_many "#{name}_joins".to_sym, class_name: class_name, dependent: :destroy
      has_many name, through: "#{name}_joins".to_sym, source: source, dependent: :destroy
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
  end
end

class ExerciseMuscles < ActiveRecord::Base
  belongs_to :muscle
  belongs_to :exercise
end

class Synergist < ExerciseMuscles; end

class Stabilizer < ExerciseMuscles; end

class DynamicStabilizer < ExerciseMuscles; end

class Target < ExerciseMuscles; end


class Group < ActiveRecord::Base
  has_many :exercises
  has_many :muscles
end

class Exercise < ActiveRecord::Base
  include STIHasMany
  belongs_to :group
  has_many_through_sti :synergists, source: :muscle, class_name: "Synergist"
  has_many_through_sti :dynamic_stabilizers, source: :muscle, class_name: "DynamicStabilizer"
  has_many_through_sti :targets, source: :muscle, class_name: "Target"
  has_many_through_sti :stabilizers, source: :muscle, class_name: 'Stabilizer'
end

class Muscle < ActiveRecord::Base
  include STIHasMany
  belongs_to :group
  has_many_through_sti :synergist_exercises, source: :exercise, class_name: "Synergist"
  has_many_through_sti :dynamic_stabilizing_exercises, source: :exercise, class_name: "DynamicStabilizer"
  has_many_through_sti :target_exercises, source: :exercise, class_name: "Target"
  has_many_through_sti :stabilizing_exercises, source: :exercise, class_name: 'Stabilizer'
end



