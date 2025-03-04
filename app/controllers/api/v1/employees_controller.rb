module Api::V1
  class EmployeesController < ApplicationController
    before_action :set_employee, only: [:show, :update, :destroy]

    # GET /employees
    def index
      employees = Employee.all
      render json: employees
    end

    # POST /employees
    def create
      employee = Employee.new(employee_params)
      if employee.save
        render json: employee, status: :created
      else
        render json: employee.errors, status: :unprocessable_entity
      end
    end

    # GET /employees/:id
    def show
      render json: @employee
    end

    # PATCH/PUT /employees/:id
    def update
      if @employee.update(employee_params)
        render json: @employee
      else
        render json: @employee.errors, status: :unprocessable_entity
      end
    end

    # DELETE /employees/:id
    def destroy
      @employee.destroy
    end

    private

    def set_employee
      @employee = Employee.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Employee not found" }, status: :not_found
    end

    def employee_params
      params.require(:employee).permit(:name, :email, :position)
    end
  end
end
