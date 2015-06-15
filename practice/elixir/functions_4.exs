prefixer = fn prefix -> 
  fn string -> 
    prefix <> " " <> string 
  end 
end