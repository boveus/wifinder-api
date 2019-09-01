class Api::V1::PeopleController < ApplicationController
  def index
    render json: people
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

  def people
    Person.all
  end

  def person
    Person.find(params[:id])
  end
end