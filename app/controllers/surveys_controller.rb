class SurveysController < ApplicationController

  # before_action :set_survey, only: [:result]

  def index
  end

  def result
    puts "I am in result controller method. My @user_survey is: ", @user_survey 
    # empty
    puts "I am in result controller method. My params are: ", params
    # {"controller"=>"surveys", "action"=>"result", "id"=>"34"}
    puts "I am in result controller method. My params[:survey] is: ", params[:survey]
    # empty
    puts "The surveys_result_path(@user_survey) is: ", surveys_result_path(@user_survey)
    # /surveys/result
    puts "The surveys_result_path(params[:survey]) is: ", surveys_result_path(params[:survey])
    # /surveys/result
    #For view to recognize @user_survey variable, need to uncomment below. Passing in value from params, 
    # if params[:survey] or params[:id] exists??
    # @user_survey=params[:survey]  (or params[:id])
    if params[:id]
      @user_survey= Survey.find(params[:id])
    else
      @user_survey= Survey.new
    end
  end

  def create
    puts "In create method, printing what's in params: ", request.params
    # {"authenticity_token"=>"z/qMR40rUIguMRAqbNZJnl1dWRutw18wbq0WLMPrtytEtrXPGeeqxAZyLJDyA0okMWk19f3RBZD1wN0eI3z0AA==", 
    #"survey"=>{"your_name"=>"hello", "dojo_loc"=>"sj", "fave_lang"=>"Py", "comment"=>"today"}, 
    #"controller"=>"surveys", "action"=>"create"}
    puts "Printing from request parameters: ", params[:survey] #same as request.params[:survey]
    # {"your_name"=>"hello", "dojo_loc"=>"sj", "fave_lang"=>"Py", "comment"=>"today"}
    # :survey is a hash created in VIEW, which' includes your_name,dojo_loc, fave_lang, and comment keys.
   
    # 1 WAY:
    # user=User.create(first_name: params[:first_name], last_name: params[:last_name], email: params[:email])
    
    # 2 WAY: 
    # @user=User.create(params[:user]) # this redirect only applies for when the user was successfully
    # created! You'll have to modify this code with an if statement (to RENDER the new view IF there
    # are errors, ELSE REDIRECT to the users view, if there weren't errors).

    survey_create_attributes=params.require(:survey).permit(:your_name, :dojo_loc, :fave_lang, :comment)
    puts "survey_create_attributes used to create new object are: ", survey_create_attributes
    # {"your_name"=>"hello", "dojo_loc"=>"sj", "fave_lang"=>"Py", "comment"=>"today"}

    # @user_survey= Survey.create(survey_create_attributes)    
    # puts "User survey created. Assigned to @user_survey variable. At inspect it is: ", @user_survey.inspect
    #<Survey id: 34, your_name: "hello", dojo_loc: "sj", fave_lang: "Py", comment: "today", 
    # created_at: "2018-01-02 21:44:43", updated_at: "2018-01-02 21:44:43">
    
    @user_survey= Survey.new(survey_create_attributes)
    res=@user_survey.save
    puts "Tried to save new user_survey", res
    puts "If unsuccessfull, or false, above, this will have errors: ", @user_survey.errors

    if session[:count]!=nil
      session[:count]+=1
      puts "Session count is: ", session[:count]
    else
      session[:count]=0;
      puts "Session count is: ", session[:count]
    end

    puts "Printing request.url: ", request.url 
    # http://localhost:3000/surveys
    # (EXAMLE => "http://localhost:3000/lists/7/items" )
    puts "Printing request.path: ", request.path
    # /surveys
    # (EXAMPLE => "/lists/7/items" )
    puts "The surveys_result_path(@user_survey) is: ", surveys_result_path(@user_survey)
    # /surveys/result/34
    puts "The surveys_result_path(params[:survey]) is: ", surveys_result_path(params[:survey])
    # /surveys/result?comment=today&dojo_loc=sj&fave_lang=Py&your_name=hello
    puts "The surveys_root_path is: ", root_path
    # /
    puts "Redirecting now from create method 
    to result method, and to the result view, using surveys_result_path(@user_survey)..."
    # CAN DO:
    # redirect_to surveys_result_path(request.params), notice: "Thanks for submitting this form! You have subitted this form #{session[:count]} times now.", flash: {new_survey_errors: @user_survey.errors}
    # OR:
    unless res # if it is true that res is false...
      flash[:new_survey_errors] = @user_survey.errors.full_messages
      render :result  
      #Moved flash from redirect line below (previous way of implementation)
    else
      # USED TO HAVE this next line (if w/o the "unless/else" conditionals): 
      # => 
      # redirect_to surveys_result_path(@user_survey), notice: "Thanks for submitting this form! You have subitted this form #{session[:count]} times now.", flash: {new_survey_errors: @user_survey.errors} 
      # ..., but moved the *flash* message up, because errors on instance varibale will exist only if "res" above is false...
      
      # This is on successful save, i.e. passed validations on @user_survey instance model variable:
      redirect_to surveys_result_path(@user_survey), notice: "Thanks for submitting this form! You have subitted this form #{session[:count]} times now."
      # OR can pass via session in :id key and in result action method, find object with that :id, or 
      # possibly in template you can also do query and render what needed?
    end 
  end

  # private
  # def set_survey
  #   puts "I am in set survey method"
  #   print "in set_survey method1 params are: ", params
  #   print "in set_survey method2: ", params[:id]
  #   puts "in set_survey method3: ", params[:controller]
  #   puts "in set_survey method4: ", params[:action]    
  #   @user_survey = Survey.find(params[:id])
  # end
end

# about UNLESS:
#   unless condition
#     #thing to be done if the condition is false
#   end