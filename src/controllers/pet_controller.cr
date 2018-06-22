class PetController < ApplicationController
  def index
    pets = Pet.all
    context.response.content_type = "application/json"
    # render("index.ecr")
    pets.to_json
  end

  def show
    if pet = Pet.find params["id"]
      render("show.ecr")
    else
      flash["warning"] = "Pet with ID #{params["id"]} Not Found"
      redirect_to "/pets"
    end
  end

  def new
    pet = Pet.new
    render("new.ecr")
  end

  def create
    pet = Pet.new(pet_params.validate!)

    if pet.valid? && pet.save
      flash["success"] = "Created Pet successfully."
      redirect_to "/pets"
    else
      flash["danger"] = "Could not create Pet!"
      render("new.ecr")
    end
  end

  def edit
    if pet = Pet.find params["id"]
      render("edit.ecr")
    else
      flash["warning"] = "Pet with ID #{params["id"]} Not Found"
      redirect_to "/pets"
    end
  end

  def update
    if pet = Pet.find(params["id"])
      pet.set_attributes(pet_params.validate!)
      if pet.valid? && pet.save
        flash["success"] = "Updated Pet successfully."
        redirect_to "/pets"
      else
        flash["danger"] = "Could not update Pet!"
        render("edit.ecr")
      end
    else
      flash["warning"] = "Pet with ID #{params["id"]} Not Found"
      redirect_to "/pets"
    end
  end

  def destroy
    if pet = Pet.find params["id"]
      pet.destroy
    else
      flash["warning"] = "Pet with ID #{params["id"]} Not Found"
    end
    redirect_to "/pets"
  end

  def pet_params
    params.validation do
      required(:name) { |f| !f.nil? }
      required(:breed) { |f| !f.nil? }
      required(:age) { |f| !f.nil? }
    end
  end
end
