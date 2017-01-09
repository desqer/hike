module CommonScopes
  def newer(size = 1)
    order(created_at: :desc).limit(size)
  end

  def older(size = 1)
    order(:created_at).limit(size)
  end
end
