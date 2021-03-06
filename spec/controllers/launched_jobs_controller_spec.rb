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

RSpec.describe LaunchedJobsController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # LaunchedJob. As you add validations to LaunchedJob, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    FactoryGirl.build(:launched_job).attributes
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # LaunchedJobsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index", skip: "Dynamic datatable" do
    # I would put credential validations here
    it "assigns all launched_jobs as @launched_jobs" do
      launched_job = LaunchedJob.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:launched_jobs)).to eq([launched_job])
    end
  end

  describe "GET show" do
    it "assigns the requested launched_job as @launched_job" do
      launched_job = LaunchedJob.create! valid_attributes
      get :show, {:id => launched_job.to_param}, valid_session
      expect(assigns(:launched_job)).to eq(launched_job)
    end
  end

  describe "GET new", skip: "No route" do
    it "assigns a new launched_job as @launched_job" do
      get :new, {}, valid_session
      expect(assigns(:launched_job)).to be_a_new(LaunchedJob)
    end
  end

  describe "GET edit", skip: "No route" do
    it "assigns the requested launched_job as @launched_job" do
      launched_job = LaunchedJob.create! valid_attributes
      get :edit, {:id => launched_job.to_param}, valid_session
      expect(assigns(:launched_job)).to eq(launched_job)
    end
  end

  describe "POST create", skip: "No route" do
    describe "with valid params" do
      it "creates a new LaunchedJob" do
        expect {
          post :create, {:launched_job => valid_attributes}, valid_session
        }.to change(LaunchedJob, :count).by(1)
      end

      it "assigns a newly created launched_job as @launched_job" do
        post :create, {:launched_job => valid_attributes}, valid_session
        expect(assigns(:launched_job)).to be_a(LaunchedJob)
        expect(assigns(:launched_job)).to be_persisted
      end

      it "redirects to the created launched_job" do
        post :create, {:launched_job => valid_attributes}, valid_session
        expect(response).to redirect_to(LaunchedJob.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved launched_job as @launched_job" do
        post :create, {:launched_job => invalid_attributes}, valid_session
        expect(assigns(:launched_job)).to be_a_new(LaunchedJob)
      end

      it "re-renders the 'new' template" do
        post :create, {:launched_job => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update", skip: "No route" do
    describe "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested launched_job" do
        launched_job = LaunchedJob.create! valid_attributes
        put :update, {:id => launched_job.to_param, :launched_job => new_attributes}, valid_session
        launched_job.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested launched_job as @launched_job" do
        launched_job = LaunchedJob.create! valid_attributes
        put :update, {:id => launched_job.to_param, :launched_job => valid_attributes}, valid_session
        expect(assigns(:launched_job)).to eq(launched_job)
      end

      it "redirects to the launched_job" do
        launched_job = LaunchedJob.create! valid_attributes
        put :update, {:id => launched_job.to_param, :launched_job => valid_attributes}, valid_session
        expect(response).to redirect_to(launched_job)
      end
    end

    describe "with invalid params" do
      it "assigns the launched_job as @launched_job" do
        launched_job = LaunchedJob.create! valid_attributes
        put :update, {:id => launched_job.to_param, :launched_job => invalid_attributes}, valid_session
        expect(assigns(:launched_job)).to eq(launched_job)
      end

      it "re-renders the 'edit' template" do
        launched_job = LaunchedJob.create! valid_attributes
        put :update, {:id => launched_job.to_param, :launched_job => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy", skip: "No route" do
    it "destroys the requested launched_job" do
      launched_job = LaunchedJob.create! valid_attributes
      expect {
        delete :destroy, {:id => launched_job.to_param}, valid_session
      }.to change(LaunchedJob, :count).by(-1)
    end

    it "redirects to the launched_jobs list" do
      launched_job = LaunchedJob.create! valid_attributes
      delete :destroy, {:id => launched_job.to_param}, valid_session
      expect(response).to redirect_to(launched_jobs_url)
    end
  end

  describe 'GET rerun' do
    it 'redirects to the job_specs/:id/run_now path' do
      launched_job = FactoryGirl.create(:launched_job, :with_tpl_dev_test_job_spec)
      get :rerun, { id: launched_job.id }, valid_session
      expect(response).to redirect_to job_specs_run_now_path(launched_job.job_spec.id)
    end
  end

  describe 'GET kill_job' do
    before { @request.env['HTTP_REFERER'] = "/launched_jobs" }

    context 'when the job is running' do
      before { @launched_job = FactoryGirl.create(:launched_job, :with_tpl_dev_test_job_spec, status: LaunchedJob::RUNNING) }
      
      it 'redirects to the launched jobs path' do
        get :kill_job, { id: @launched_job.id }, valid_session
        expect(response).to redirect_to launched_jobs_path
      end
      it 'kills the job' do
        get :kill_job, { id: @launched_job.id }, valid_session
        expect(@launched_job.reload.status).to eq LaunchedJob::ERROR
        expect(@launched_job.reload.status_message).to match /Job Killed/
      end
    end

    context 'when the job is not running' do
      before { @launched_job = FactoryGirl.create(:launched_job, :with_tpl_dev_test_job_spec, status: LaunchedJob::SUCCESS) }

      it 'redirects to the launched jobs path' do
        get :kill_job, { id: @launched_job.id }, valid_session
        expect(response).to redirect_to launched_jobs_path
      end
      
      it 'does not change the status' do
        expect {
          get :kill_job, { id: @launched_job.id }, valid_session
        }.not_to change {
          @launched_job.reload.status
        }
      end
    end
  end
end
