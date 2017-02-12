class NotesController < ApplicationController
  def index
    load_notes
  end

  def show
    load_note
  end

  def new
    build_note
  end

  def create
    build_note
    save_note or render 'new'
  end

  def edit
    load_note
    build_note
  end

  def update
    load_note
    build_note
    save_note or render 'edit'
  end

  def destroy
    load_note
    @note.destroy
    redirect_to notes_path
  end

  private

  def load_notes
    @notes ||= note_scope.to_a
  end

  def load_note
    @note ||= note_scope.find(params[:id])
  end

  def build_note
    @note ||= note_scope.build
    @note.attributes = note_params
  end

  def save_note
    if @note.save
      redirect_to @note
    end
  end

  def note_params
    note_params = params[:note]
    note_params ? note_params.permit(:title, :text, :published) : {}
  end

  def note_scope
    Note.scoped
  end
end
