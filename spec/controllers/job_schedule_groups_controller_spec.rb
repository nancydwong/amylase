require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe JobScheduleGroupsController, :type => :controller do

  def construct_associated_attributes(model, association)
    attributes = model.attributes.with_indifferent_access
    attributes["#{association}_attributes"] = {}
    idx = 0
    model.send(association).each do |s|
      attributes["#{association}_attributes"][idx.to_s.to_sym] = s.attributes
      idx += 1
    end
    attributes
  end


  # This should return the minimal set of attributes required to create a valid
  # JobScheduleGroup. As you add validations to JobScheduleGroup, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    valid_build = FactoryGirl.build(:job_schedule_group, :schedule_maintenance)
    construct_associated_attributes(valid_build, :job_schedules)
  end

  let(:invalid_attributes) do
    invalid_attributes = valid_attributes.clone
    invalid_attributes[:name] = "MyInvalidJobScheduleGroup"
    invalid_attributes[:job_schedules_attributes][0.to_s.to_sym][:schedule_time] = '* *'
    invalid_attributes
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # JobScheduleGroupsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all job_schedule_groups as @job_schedule_groups" do
      job_schedule_group = JobScheduleGroup.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:job_schedule_groups)).to eq([job_schedule_group])
    end
  end

  describe "GET show" do
    it "assigns the requested job_schedule_group as @job_schedule_group" do
      job_schedule_group = JobScheduleGroup.create! valid_attributes
      get :show, {:id => job_schedule_group.to_param}, valid_session
      expect(assigns(:job_schedule_group)).to eq(job_schedule_group)
    end
  end

  describe "GET new" do
    it "assigns a new job_schedule_group as @job_schedule_group" do
      get :new, {}, valid_session
      expect(assigns(:job_schedule_group)).to be_a_new(JobScheduleGroup)
    end
  end

  describe "GET edit" do
    it "assigns the requested job_schedule_group as @job_schedule_group" do
      job_schedule_group = JobScheduleGroup.create! valid_attributes
      get :edit, {:id => job_schedule_group.to_param}, valid_session
      expect(assigns(:job_schedule_group)).to eq(job_schedule_group)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new JobScheduleGroup" do
        expect {
          post :create, {:job_schedule_group => valid_attributes}, valid_session
        }.to change(JobScheduleGroup, :count).by(1)

      end

      it "assigns a newly created job_schedule_group as @job_schedule_group" do
        post :create, {:job_schedule_group => valid_attributes}, valid_session
        expect(assigns(:job_schedule_group)).to be_a(JobScheduleGroup)
        expect(assigns(:job_schedule_group)).to be_persisted
      end

      it "redirects to the created job_schedule_group" do
        post :create, {:job_schedule_group => valid_attributes}, valid_session
        expect(response).to redirect_to(JobScheduleGroup.last)
      end
    end

    describe "with invalid params" do
      it "does not save the new JobScheduleGroup" do
        test = JobScheduleGroup.new invalid_attributes
        expect {
          post :create, job_schedule_group: invalid_attributes
        }.not_to change(JobScheduleGroup, :count)
      end

      it "assigns a newly created but unsaved job_schedule_group as @job_schedule_group" do
        post :create, {:job_schedule_group => invalid_attributes}, valid_session
        expect(assigns(:job_schedule_group)).to be_a_new(JobScheduleGroup)
      end

      it "re-renders the 'new' template" do
        post :create, {:job_schedule_group => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      before do
        @job_schedule_group = JobScheduleGroup.create! valid_attributes

        # Append a new schedule
        new_schedule = FactoryGirl.build(:job_schedule, 
                                         job_schedule_group: @job_schedule_group, 
                                         schedule_time: '06 06 06 * * America/Los_Angeles').attributes.with_indifferent_access
        @updated_attributes = construct_associated_attributes(@job_schedule_group, :job_schedules)
        @updated_attributes['job_schedules_attributes'][666.to_s.to_sym] = new_schedule
      end

      it "updates the requested job_schedule_group by appending a job_schedule" do
        put :update, {:id => @job_schedule_group.to_param, :job_schedule_group => @updated_attributes}, valid_session
        expect { @job_schedule_group.reload }.to change { @job_schedule_group.job_schedules.length }.by(1)
      end

      it "assigns the requested job_schedule_group as @job_schedule_group" do
        put :update, {:id => @job_schedule_group.to_param, :job_schedule_group => @updated_attributes}, valid_session
        expect(assigns(:job_schedule_group)).to eq(@job_schedule_group)
      end

      it "redirects to the job_schedule_group" do
        put :update, {:id => @job_schedule_group.to_param, :job_schedule_group => @updated_attributes}, valid_session
        expect(response).to redirect_to(@job_schedule_group)
      end
    end

    describe "with invalid params" do
      it "assigns the job_schedule_group as @job_schedule_group" do
        job_schedule_group = JobScheduleGroup.create! valid_attributes
        put :update, {:id => job_schedule_group.to_param, :job_schedule_group => invalid_attributes}, valid_session
        expect(assigns(:job_schedule_group)).to eq(job_schedule_group)
      end

      it "re-renders the 'edit' template" do
        job_schedule_group = JobScheduleGroup.create! valid_attributes
        put :update, {:id => job_schedule_group.to_param, :job_schedule_group => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested job_schedule_group" do
      job_schedule_group = JobScheduleGroup.create! valid_attributes
      expect {
        delete :destroy, {:id => job_schedule_group.to_param}, valid_session
      }.to change(JobScheduleGroup, :count).by(-1)
    end

    it "redirects to the job_schedule_groups list" do
      job_schedule_group = JobScheduleGroup.create! valid_attributes
      delete :destroy, {:id => job_schedule_group.to_param}, valid_session
      expect(response).to redirect_to(job_schedule_groups_url)
    end
  end

end
