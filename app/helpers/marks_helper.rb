module MarksHelper
  def btn_read
    link_to t("marks.read"), mark_path(@mark, mark_type: :read),
      method: :put, id: "btn-mark", remote: true, class: "btn btn-default"
  end

  def btn_reading
    link_to t("marks.reading"), mark_path(@mark, mark_type: :reading),
      method: :put, id: "btn-mark", remote: true, class: "btn btn-default"
  end

  def btn_favorite
    link_to t("marks.Unfavorite"), mark_path(@mark, favorite: false),
      method: :put, id: "btn-mark", remote:true, class: "btn btn-default"
  end

  def btn_unfavorite
    link_to t("marks.Fravorite"), mark_path(@mark, favorite: true),
      method: :put, id: "btn-mark", remote:true, class: "btn btn-default"
  end

  def show_mark_type mark_type
    case mark_type
    when Settings.mark.reading
      image_tag Settings.mark.image_reading, size: Settings.mark.size_small,
        alt: t("mark.reading") 
    when Settings.mark.read
      image_tag Settings.mark.image_read, size: Settings.mark.size_small,
        alt: t("marks.read")
    end
  end
end
