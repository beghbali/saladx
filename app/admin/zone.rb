ActiveAdmin.register Zone do
  # permit_params do
  #   [:latitude, :longitude, :city, :neighborhood, :name, :boundaries]
  #   params

  controller do

    def edit
      resource.boundaries = resource.boundaries.map{|b| b.to_a}.to_s
      super
    end

    def create
      resource = Zone.create!(zone_params)
      redirect_to resource_path(resource)
    end

    def update
      resource.update!(zone_params)
      redirect_to resource_path(resource)
    end

    def zone_params
      params.require(:zone).permit!
      params[:zone][:boundaries] = Points.new(eval(params[:zone][:boundaries]))
      params[:zone]
    end
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end


end
