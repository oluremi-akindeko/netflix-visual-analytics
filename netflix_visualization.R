# Netflix Visual Analytics
# Create and verify the ratings distribution chart in R

# Load the visualization package
library(ggplot2)


# ---------------------------------------------------------
# DEFINE FILE LOCATIONS
# ---------------------------------------------------------

# Define the Netflix dataset created by the Python notebook
netflix_file <- "Netflix_shows_movies.csv"

# Define the Python rating-count summary
python_rating_file <- "rating_counts_python.csv"

# Define the output folder
output_folder <- "outputs"

# Define the R chart filename
ratings_chart_file <- file.path(
  output_folder,
  "ratings_distribution_r.png"
)


# ---------------------------------------------------------
# LOAD AND PREPARE THE NETFLIX DATA
# ---------------------------------------------------------

tryCatch({

  # Confirm that the Netflix dataset exists
  if (!file.exists(netflix_file)) {
    stop(
      paste(
        netflix_file,
        "could not be found in the project folder."
      )
    )
  }

  # Load the Netflix dataset
  netflix_data <- read.csv(
    netflix_file,
    stringsAsFactors = FALSE,
    check.names = FALSE,
    na.strings = c("", "NA")
  )

  # Confirm that the dataset contains records
  if (nrow(netflix_data) == 0) {
    stop(
      "The Netflix dataset contains no records."
    )
  }

  # Confirm that the rating column exists
  if (!"rating" %in% names(netflix_data)) {
    stop(
      "The rating column could not be found."
    )
  }

  cat("Netflix dataset loaded successfully.\n")
  cat("Number of rows:", nrow(netflix_data), "\n")
  cat("Number of columns:", ncol(netflix_data), "\n")


  # ---------------------------------------------------------
  # CLEAN THE RATING COLUMN
  # ---------------------------------------------------------

  # Replace missing or blank ratings with Not Rated
  netflix_data$rating[
    is.na(netflix_data$rating) |
      trimws(netflix_data$rating) == ""
  ] <- "Not Rated"

  # Remove spaces before and after rating labels
  netflix_data$rating <- trimws(
    netflix_data$rating
  )


  # ---------------------------------------------------------
  # CREATE THE R RATING COUNTS
  # ---------------------------------------------------------

  # Count titles in each rating category
  rating_counts <- as.data.frame(
    table(netflix_data$rating),
    stringsAsFactors = FALSE
  )

  # Give the columns clear names
  names(rating_counts) <- c(
    "Rating",
    "Title_Count"
  )

  # Ensure the columns use appropriate data types
  rating_counts$Rating <- as.character(
    rating_counts$Rating
  )

  rating_counts$Title_Count <- as.integer(
    rating_counts$Title_Count
  )

  # Arrange ratings from highest to lowest count
  rating_counts <- rating_counts[
    order(
      rating_counts$Title_Count,
      decreasing = TRUE
    ),
  ]

  # Reset row numbers
  row.names(rating_counts) <- NULL

  # Display the R rating counts
  cat("\nRATING COUNTS\n")
  cat("==============================\n")

  print(
    rating_counts,
    row.names = FALSE
  )

  cat(
    "Total titles represented:",
    sum(rating_counts$Title_Count),
    "\n"
  )


  # ---------------------------------------------------------
  # COMPARE PYTHON AND R RATING COUNTS
  # ---------------------------------------------------------

  # Confirm that the Python summary file exists
  if (!file.exists(python_rating_file)) {
    stop(
      paste(
        python_rating_file,
        "could not be found in the project folder."
      )
    )
  }

  # Import the Python rating counts
  python_rating_counts <- read.csv(
    python_rating_file,
    stringsAsFactors = FALSE,
    check.names = FALSE
  )

  # Confirm that the Python summary has two columns
  if (ncol(python_rating_counts) != 2) {
    stop(
      paste(
        python_rating_file,
        "must contain exactly two columns."
      )
    )
  }

  # Rename the Python columns to match the R columns
  names(python_rating_counts) <- c(
    "Rating",
    "Title_Count"
  )

  # Ensure the Python columns use matching data types
  python_rating_counts$Rating <- as.character(
    python_rating_counts$Rating
  )

  python_rating_counts$Title_Count <- as.integer(
    python_rating_counts$Title_Count
  )

  # Sort the Python table alphabetically by rating
  python_rating_counts <- python_rating_counts[
    order(python_rating_counts$Rating),
  ]

  # Create an alphabetically sorted R comparison table
  r_rating_counts_comparison <- rating_counts[
    order(rating_counts$Rating),
  ]

  # Reset row numbers before the comparison
  row.names(python_rating_counts) <- NULL
  row.names(r_rating_counts_comparison) <- NULL

  # Compare the Python and R summary tables
  rating_counts_match <- identical(
    python_rating_counts,
    r_rating_counts_comparison
  )

  # Display the comparison results
  cat("\nPYTHON AND R COMPARISON\n")
  cat("==============================\n")

  cat(
    "Python rating categories:",
    nrow(python_rating_counts),
    "\n"
  )

  cat(
    "R rating categories:",
    nrow(r_rating_counts_comparison),
    "\n"
  )

  cat(
    "Python total titles:",
    sum(python_rating_counts$Title_Count),
    "\n"
  )

  cat(
    "R total titles:",
    sum(r_rating_counts_comparison$Title_Count),
    "\n"
  )

  cat(
    "Python and R rating counts match:",
    rating_counts_match,
    "\n"
  )

  # Stop if the Python and R results differ
  if (!rating_counts_match) {
    stop(
      paste(
        "The Python and R rating counts do not match.",
        "Review the rating-cleaning and counting steps."
      )
    )
  }


  # ---------------------------------------------------------
  # CREATE THE OUTPUT FOLDER
  # ---------------------------------------------------------

  # Create the outputs folder if necessary
  if (!dir.exists(output_folder)) {
    dir.create(
      output_folder,
      recursive = TRUE
    )
  }

  # Confirm that the output folder exists
  if (!dir.exists(output_folder)) {
    stop(
      "The outputs folder could not be created."
    )
  }


  # ---------------------------------------------------------
  # CREATE THE RATINGS DISTRIBUTION CHART
  # ---------------------------------------------------------

  # Preserve the descending category order in the chart
  rating_counts$Rating <- factor(
    rating_counts$Rating,
    levels = rating_counts$Rating
  )

  # Create the ratings-distribution chart
  ratings_chart <- ggplot(
    rating_counts,
    aes(
      x = Rating,
      y = Title_Count
    )
  ) +
    geom_col(
      fill = "darkorange"
    ) +
    geom_text(
      aes(
        label = format(
          Title_Count,
          big.mark = ",",
          scientific = FALSE
        )
      ),
      vjust = -0.4,
      size = 3
    ) +
    labs(
      title = "Distribution of Netflix Content Ratings",
      x = "Content Rating",
      y = "Number of Titles"
    ) +
    scale_y_continuous(
      labels = function(values) {
        format(
          values,
          big.mark = ",",
          scientific = FALSE,
          trim = TRUE
        )
      },
      expand = expansion(
        mult = c(0, 0.12)
      )
    ) +
    theme_minimal() +
    theme(
      plot.title = element_text(
        hjust = 0.5,
        size = 14,
        face = "bold"
      ),
      axis.text.x = element_text(
        angle = 45,
        hjust = 1
      ),
      panel.grid.major.x = element_blank()
    )

  # Display the chart in the R plotting window
  print(ratings_chart)

  # Save the chart as a high-resolution PNG
  ggsave(
    filename = ratings_chart_file,
    plot = ratings_chart,
    width = 12,
    height = 6,
    dpi = 300,
    bg = "white"
  )


  # ---------------------------------------------------------
  # DISPLAY THE FINAL SUMMARY
  # ---------------------------------------------------------

  cat("\nR VISUALIZATION SUMMARY\n")
  cat("==============================\n")

  cat(
    "Chart saved successfully:",
    ratings_chart_file,
    "\n"
  )

  cat(
    "Chart file exists:",
    file.exists(ratings_chart_file),
    "\n"
  )

  cat(
    "Rating categories displayed:",
    nrow(rating_counts),
    "\n"
  )

  cat(
    "Python and R results verified:",
    rating_counts_match,
    "\n"
  )

}, error = function(error) {

  # Display a helpful error message
  cat(
    "\nProcessing error:",
    conditionMessage(error),
    "\n"
  )
})