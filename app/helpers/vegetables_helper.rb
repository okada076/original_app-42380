module VegetablesHelper
  def category_class(category)
    {
      '果菜類' => 'fruit',
      '根菜類' => 'root',
      '果実類' => 'citrus',
      '葉菜類' => 'leaf'
    }[category] || 'other'
  end

end
