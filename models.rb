require 'active_record'
require 'open-uri'
require 'hpricot'

ActiveRecord::Base.establish_connection(
    :adapter => 'sqlite3',
    :database => './development.sqlite3'
)

class ExerciseMuscles < ActiveRecord::Base
  belongs_to :muscle
  belongs_to :exercise
end

class Synergist < ExerciseMuscles; end

class Stabilizer < ExerciseMuscles; end

class DynamicStabilizer < ExerciseMuscles; end

class Target < ExerciseMuscles; end

class Exercise < ActiveRecord::Base
  has_many :synergists_joins, class_name: 'Synergist', dependent: :destroy
  has_many :synergists, through: :synergists_joins, source: :muscle


  has_many :dynamic_stabilizer_joins, class_name: 'DynamicStabilizer', dependent: :destroy
  has_many :dynamic_stabilizers, through: :dynamic_stabilizer_joins, source: :muscle

  has_many :target_joins, class_name: 'Target', dependent: :destroy
  has_many :targets, through: :target_joins, source: :muscle

  has_many :stabilizer_joins, class_name: 'Stabilizer', dependent: :destroy
  has_many :stabilizers, through: :stabilizer_joins, source: :muscle

end

class Muscle < ActiveRecord::Base
  has_many :synergists_joins, class_name: 'Synergist', dependent: :destroy
  has_many :synergist_exercises, through: :synergists_joins, source: :exercise


  has_many :dynamic_stabilizer_joins, class_name: 'DynamicStabilizer', dependent: :destroy
  has_many :dynamic_stabilizing_exercises, through: :dynamic_stabilizer_joins, source: :exercise

  has_many :target_joins, class_name: 'Target', dependent: :destroy
  has_many :target_exercises, through: :target_joins, source: :exercise

  has_many :stabilizer_joins, class_name: 'Stabilizer', dependent: :destroy
  has_many :stabilizer_exercises, through: :stabilizer_joins, source: :exercise
end



