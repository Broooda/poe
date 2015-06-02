class DualTasksController < ApplicationController
  def data; end

  def calculation
    @params = params
    hash = FourSimplex.uzupelnij(params)
    sympleks_tab=[[],[],[],[],[],[],[], [], [], []]
    numerator = []
    denominator = []
    sympleks_tab = hash[:sympleks_tab]
    numerator = hash[:numerator]
    denominator = hash[:denominator]
    sympleks_tab = hash[:sympleks_tab]
    @start_tab = [hash[:sympleks_tab][0].clone, hash[:sympleks_tab][1].clone,hash[:sympleks_tab][2].clone,hash[:sympleks_tab][3].clone,hash[:sympleks_tab][4].clone,hash[:sympleks_tab][5].clone,hash[:sympleks_tab][6].clone,hash[:sympleks_tab][7].clone,hash[:sympleks_tab][8].clone,hash[:sympleks_tab][9].clone]

    @success=true
    begin
      result_hash = FourSimplex.first_phase(sympleks_tab)
      sympleks_tab = result_hash[:sympleks_tab]
      @step_by_step = result_hash[:step_by_step]
      result_hash = FourSimplex.second_phase(@step_by_step.last, numerator, denominator)
      rescue StandardError => e
        binding.pry
        @success = false
    end
    @success = result_hash[:success]
    render :result
  end

  # def second_calculation(sympleks_tab)
  #   @params = params
  #   hash = FourSimplex.uzupelnij(params)
  #   #sympleks_tab=[[],[],[],[],[],[],[], [], [], []]
  #   numerator = []
  #   denominator = []
  #   sympleks_tab = hash[:sympleks_tab]
  #   numerator = hash[:numerator]
  #   denominator = hash[:denominator]
  #   @start_tab = [hash[:sympleks_tab][0].clone, hash[:sympleks_tab][1].clone,hash[:sympleks_tab][2].clone,hash[:sympleks_tab][3].clone,hash[:sympleks_tab][4].clone,hash[:sympleks_tab][5].clone,hash[:sympleks_tab][6].clone,hash[:sympleks_tab][7].clone,hash[:sympleks_tab][8].clone,hash[:sympleks_tab][9].clone]

  #   @success=true
  #   begin
  #     result_hash = FourSimplex.second_phase(sympleks_tab, numerator, denominator)
  #     sympleks_tab = result_hash[:sympleks_tab]
  #     @step_by_step = result_hash[:step_by_step]
  #     rescue StandardError => e
  #       @success = false
  #   end
  #   @success = result_hash[:success]
  #   render :result
  # end

  def result; end
end