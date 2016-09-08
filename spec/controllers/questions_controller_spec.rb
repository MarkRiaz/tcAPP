require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

  let(:question) { create(:question)}
  let(:user) { create (:user)}
  describe 'GET #index' do
    
    let(:questions) {create_list(:question, 2)}	

    before { get :index }
      

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end

  end	
  
  describe 'GET #show' do
    before {get :show, id: question}

    it 'assigns the requested question to @question' do
	expect(assigns(:question)).to eq question
    end

    it 'renders show view' do
 	expect(response).to render_template :show
    end

  end
	
  describe 'GET #new' do
   sign_in_user

   before {get :new}
   
   it 'assigns a new Question to @question' do
     expect(assigns(:question)).to be_a_new(Question) 
   end  

   it 'renders new view' do
 	expect(response).to render_template :new
   end

  end 

  describe 'POST #create' do
    sign_in_user

    context 'with valid attributes' do

      it 'saves the new question in the database' do
        expect { post :create, question: attributes_for(:question) }.to change(Question, :count).by(1)
      end

      it 'saves the new user question in the database' do
        expect { post :create, question: attributes_for(:question) }.to change(@user.questions, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, question: attributes_for(:question)
        expect(response).to redirect_to questions_path
      end

    end

    context 'with invalid attributes' do

      it 'does not save the question' do
        expect { post :create, question: attributes_for(:invalid_question) }.to_not change(@user.questions, :count)
      end

      it 're-renders new view' do
        post :create, question: attributes_for(:invalid_question)
        expect(response).to render_template :new
      end

    end

  end

  describe 'GET #edit' do
    sign_in_user
    before { get :edit, id: question }

    it 'assings the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user

    context 'user delete own question' do
      before { question.update(user_id: @user.id) }
    
      it 'deletes question' do
        expect { delete :destroy, id: question }.to change(@user.questions, :count).by(-1)
      end
    end
   
    context 'user delete not his question' do 
      before { question }
      it 'does not delete question' do
        expect { delete :destroy, params: { id: question} }.to_not change(@user.questions, :count)        
      end     
    end
  end

end
