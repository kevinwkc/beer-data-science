
library(forcats)

# ------------------ collapse styles ---------------
# Create a new column that merges styles that contain certain keywords into the same style

# most general to most specific such that if something has india pale ale it will be
# characterized as india pale ale not just pale ale

keywords <- c("Pale Ale", "India Pale Ale", "Double India Pale Ale", "Lager", "India Pale Lager", "Hefeweizen", 
              "Barrel-Aged","Wheat", "Pilsner", "Pilsener", "Amber", "Golden", "Blonde", "Brown", "Black", "Stout", 
              "Imperial Stout", "Fruit", "Porter", "Red", "Sour", "Kölsch", "Tripel", "Bitter", "Saison", "Strong Ale", 
              "Barley Wine", "Dubbel")
collapse_styles <- function(df) {
  df$style_collapsed <- vector(length=length(df$style))

  for (beer in 1:nrow(df)) {
    if (grepl(paste(keywords, collapse="|"), df$style[beer])) {    # if one of the keywords exists in the style
      for (keyword in keywords) {         # loop through the keywords to see which one it matches
        if(grepl(keyword, df$style[beer]) == TRUE) {
          df$style_collapsed[beer] <- keyword    # if we have a match assign the keyword to that row's style_collpased
        }                         # if multiple matches, it gets the later one in keywords
      } 
    } else {
      df$style_collapsed[beer] <- as.character(df$style[beer])       # else style_collapsed is just style
    }
    
    if(trace_progress == TRUE) {message(paste0("Collapsing this ", df$style[beer], " to: ", df$style_collapsed[beer]))}
  }
  df$style_collapsed <- factor(df$style_collapsed)
  return(df)
}


# Collapse some more by hand
collapse_further <- function(df) {
  df[["style_collapsed"]] <- df[["style_collapsed"]] %>%
    fct_collapse(
      "Wheat" = c("Hefeweizen", "Wheat"),
      "Pilsener" = c("Pilsner", "American-Style Pilsener") # pilsener = pilsner = pils
    )
  return(df)
}


# ------ Do the collapsing
# beer_necessities <- beer_necessities %>% collapse_styles() %>% collapse_further()


