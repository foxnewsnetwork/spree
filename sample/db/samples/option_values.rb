Spree::Sample.load_sample("option_types")

grade = Spree::OptionType.find_by_presentation!("Grade")
color = Spree::OptionType.find_by_presentation!("Color")

Spree::OptionValue.create!([
  {
    :name => "Grade A",
    :presentation => "A",
    :position => 1,
    :option_type => grade
  },
  {
    :name => "Grade B",
    :presentation => "B",
    :position => 2,
    :option_type => grade
  },
  {
    :name => "Grade C",
    :presentation => "C",
    :position => 3,
    :option_type => grade
  },
  {
    :name => "Grade D",
    :presentation => "D",
    :position => 4,
    :option_type => grade
  },
  {
    :name => "Red",
    :presentation => "Red",
    :position => 1,
    :option_type => color,
  },
  {
    :name => "Green",
    :presentation => "Green",
    :position => 2,
    :option_type => color,
  },
  {
    :name => "Blue",
    :presentation => "Blue",
    :position => 3,
    :option_type => color
  }
])