class DualTasksController < ApplicationController
  def data; end

  def calculation
    @params = params
    hash = FourSimplex.uzupelnij(params)
    sympleks_tab=[[],[],[],[],[],[],[], [], [], []]
    sympleks_tab = hash[:sympleks_tab]
    @start_tab = [hash[:sympleks_tab][0].clone, hash[:sympleks_tab][1].clone,hash[:sympleks_tab][2].clone,hash[:sympleks_tab][3].clone,hash[:sympleks_tab][4].clone,hash[:sympleks_tab][5].clone,hash[:sympleks_tab][6].clone]
    # puts @sympleks_tab.inspect
    # FourSimplex.transformation_to_one_in_cell(@sympleks_tab)
    # puts @sympleks_tab.inspect
    # FourSimplex.transformation_other_to_zero(@sympleks_tab)
    # puts @sympleks_tab.inspect
    @success=true
    begin
      result_hash = FourSimplex.all_in(sympleks_tab)
      sympleks_tab = result_hash[:sympleks_tab]
      @step_by_step = result_hash[:step_by_step]
      rescue StandardError
      @success = false
    end
      #@success = result_hash[:success]
    render :result
  end

  def result; end
end
