class DocumentSectionsController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
    @document = @project.documents.find(params[:document_id])
    @document_section = @document.document_sections.build(params[:document_section])

    respond_to do |f|
      if @document_section.save
        f.html { redirect_to [@project, @document] }
        f.js
      else
        f.html { redirect_to [@project, @document] }
        f.js { render :text => :error, :status => 500 }
      end
    end
  end

  def sort
    params[:document_section].each_with_index do |id, pos|
      DocumentSection.update_all(['position=?', pos + 1], ['id=?', id])
    end

    respond_to do |format|
      format.js { head :ok }
    end
  end
end
