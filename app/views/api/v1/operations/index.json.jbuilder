json.data do
  json.user do |json|
    json.extract! @user, :id, :name
  end

  json.operations do |json|
    json.array! @operations, :id, :operation_type, :operated_at, :created_at
  end
end
