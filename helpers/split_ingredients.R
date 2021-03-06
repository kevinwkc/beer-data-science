# Split ingredients from one column into many on the comma

library(stringr)

split_ingredients <- function(df, ingredients_to_split) {
  
  ncol_df <- ncol(df)
  
  for (ingredient in ingredients_to_split) {
    print(paste0("-------- splitting ingredient ", ingredient, " --------"))

    ingredient_split <- str_split(df[[ingredient]], ", ")    # this returns a list
    num_new_cols <- max(lengths(ingredient_split))      # find out max number of instances of an ingredient per beer. this will be the number of columns we're adding.
  
    for (num in 1:num_new_cols) {
      
      this_col <- ncol_df + 1         # create a new column, initialize it with NAs, and name it
      
      df[, this_col] <- NA
      names(df)[this_col] <- paste0(ingredient, "_", num)
      ncol_df <- ncol(df)             # update the number of columns
      for (row in seq_along(ingredient_split)) {           # for each element in our list of split up ingredients
        print((paste0("On ingredient ", ingredient, ", row  ", row)))
        if (!is.null(ingredient_split[[row]][num])) {         # if it exists, add it to the correct column in our df
          df[row, this_col] <- ingredient_split[[row]][num]
        }
      }
      df[[names(df)[this_col]]] <- factor(df[[names(df)[this_col]]])
    }
    
    
    ncol_df <- ncol(df)
  }
  return(df)
}

ings_2_split <- c("hops_name", "malt_name")
now_split <- split_ingredients(beer_necessities, ings_2_split)


### A more functional way of doing this using separate()

# now_split_2 <- separate(data = beer_necessities,
#           col = hops_name, into = setdiff(names(foo), names(beer_necessities)), sep = ", ")
