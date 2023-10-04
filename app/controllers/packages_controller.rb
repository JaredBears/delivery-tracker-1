class PackagesController < ApplicationController
  def index
    if(!current_user)
      redirect_to("/users/sign_in")
    else
      @missing_packages = current_user.missing_packages.order({ :created_at => :asc })
      @delivered_packages = current_user.delivered_packages.order({ :created_at => :asc })
      render({ :template => "packages/index" })
    end
  end

  def show
    the_id = params.fetch("path_id")

    matching_packages = Package.where({ :id => the_id })

    @the_package = matching_packages.at(0)

    render({ :template => "packages/show" })
  end

  def create
    the_package = Package.new
    the_package.desc = params.fetch("query_desc")
    the_package.expected = params.fetch("query_expected")
    the_package.delivered = params.fetch("query_delivered", false)
    the_package.owner_id = params.fetch("query_owner_id")
    the_package.notes = params.fetch("query_notes")

    if the_package.valid?
      the_package.save
      redirect_to("/packages", { :notice => "Package created successfully." })
    else
      redirect_to("/packages", { :alert => the_package.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_package = Package.where({ :id => the_id }).at(0)

    the_package.desc = params.fetch("query_desc")
    the_package.expected = params.fetch("query_expected")
    the_package.delivered = params.fetch("query_delivered", false)
    the_package.owner_id = params.fetch("query_owner_id")
    the_package.notes = params.fetch("query_notes")

    if the_package.valid?
      the_package.save
      redirect_to("/packages/#{the_package.id}", { :notice => "Package updated successfully."} )
    else
      redirect_to("/packages/#{the_package.id}", { :alert => the_package.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_package = Package.where({ :id => the_id }).at(0)

    the_package.destroy

    redirect_to("/packages", { :notice => "Package deleted successfully."} )
  end
end
