class PlayerSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :wins, :mm_points
end
