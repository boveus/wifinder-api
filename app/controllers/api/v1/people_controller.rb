class Api::V1::PeopleController < ApplicationController
  def index
    render json: people.paginate(page: page)
  end

  def show
    render json: person
  end

  def ssids
    render json: person.ssids
  end

  def activetimes
    render json: person.activetimes
  end

  private

  def page
    params[:page] || 1
  end

  def people
    Person.all
  end

  def person
    Person.find(params[:id])
  end
end
