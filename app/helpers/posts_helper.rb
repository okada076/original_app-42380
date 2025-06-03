module PostsHelper
  def category_label(key)
    case key
    when 'grow_log'
      '育成記録'
    when 'trouble_note'
      'つまずきノート'
    else
      key
    end
  end
end
