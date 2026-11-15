# Netflix Visual Analytics

## Project Overview

This project analyzes the provided Netflix catalog dataset using Python and R. The workflow prepares and cleans the data, performs descriptive and statistical exploration, and creates visualizations for the most common genres and the distribution of content ratings.

The Python analysis is completed in a Jupyter Notebook in Visual Studio Code using pandas, Seaborn, and Matplotlib. The ratings-distribution chart is reproduced in R using ggplot2, and the Python and R rating counts are compared to verify consistent results.

## Project Requirements

The project addresses the following requirements:

- Unzip the Netflix dataset.
- Rename the extracted dataset to `Netflix_shows_movies.csv`.
- Identify and address missing values.
- Describe and statistically explore the dataset.
- Visualize the most common genres using Python.
- Visualize the distribution of content ratings using Python.
- Reproduce one visualization in R.
- Save the completed charts as image files.
- Include instructions for accessing and understanding the Python and R work.

## Technologies Used

- Python 3
- Jupyter Notebook
- Visual Studio Code
- pandas
- Seaborn
- Matplotlib Pyplot
- R
- ggplot2
- Python `pathlib` module
- Python `zipfile` module

## Project Structure

```text
netflix-visual-analytics/
|
|-- netflix_visual_analysis.ipynb
|-- netflix_visualization.R
|-- netflix_data.csv
|-- netflix_data.zip
|-- Netflix_shows_movies.csv
|-- Netflix_shows_movies_cleaned.csv
|-- rating_counts_python.csv
|-- README.md
|-- .gitignore
|
|-- extracted_data/
|   `-- netflix_data.csv
|
`-- outputs/
    |-- most_common_genres_python.png
    |-- ratings_distribution_python.png
    `-- ratings_distribution_r.png
```

## File Descriptions

### `netflix_visual_analysis.ipynb`

The main Python Jupyter Notebook. It contains the complete workflow for:

- Importing the required libraries
- Defining relative file paths
- Extracting the ZIP archive
- Renaming the extracted CSV
- Loading and inspecting the dataset
- Cleaning missing values
- Converting the date column
- Checking duplicate records
- Performing descriptive and categorical analysis
- Preparing the genre and rating summaries
- Creating and saving the Python charts
- Exporting the cleaned dataset
- Exporting Python rating counts for R verification

### `netflix_visualization.R`

The R script that:

- Loads the renamed Netflix dataset
- Cleans the rating field
- Calculates the rating distribution
- Imports the Python rating-count summary
- Verifies that the Python and R rating results match
- Creates the R ratings-distribution chart with ggplot2
- Saves the chart as a high-resolution PNG

### `netflix_data.csv`

The original CSV dataset supplied for the assignment.

### `netflix_data.zip`

A ZIP copy of the supplied CSV. The instructor supplied the data as a CSV rather than a ZIP archive, so this file was created to demonstrate the assignment's required unzip workflow.

### `Netflix_shows_movies.csv`

The renamed working dataset created after extracting `netflix_data.zip`.

### `Netflix_shows_movies_cleaned.csv`

The cleaned dataset exported from the Python notebook.

### `rating_counts_python.csv`

The Python-generated rating summary used to verify that Python and R produce identical category counts.

### `outputs/`

Contains the completed high-resolution visualizations:

- `most_common_genres_python.png`
- `ratings_distribution_python.png`
- `ratings_distribution_r.png`

## Dataset Description

The dataset contains 6,234 Netflix catalog records and 12 columns:

- `show_id`
- `type`
- `title`
- `director`
- `cast`
- `country`
- `date_added`
- `release_year`
- `rating`
- `duration`
- `listed_in`
- `description`

The records include both Movies and TV Shows. The `listed_in` field may contain several comma-separated genre labels for one title, while `rating` contains content classifications such as `TV-MA`, `TV-14`, `TV-PG`, `R`, and `PG-13`.

## Data Preparation

The dataset supplied for the assignment was `netflix_data.csv`. To demonstrate the required unzip workflow:

1. The source CSV was compressed into `netflix_data.zip`.
2. Python verified that the ZIP file existed.
3. The ZIP archive was extracted into `extracted_data/`.
4. The extracted `netflix_data.csv` was copied and renamed to `Netflix_shows_movies.csv`.
5. The renamed dataset was loaded into pandas for analysis.

Relative paths are used so the project can run on another computer without editing a personal Windows path.

## Data Cleaning

The original missing-value counts were:

| Column | Missing Values | Cleaning Decision |
|---|---:|---|
| `director` | 1,969 | Replaced with `Unknown Director` |
| `cast` | 570 | Replaced with `Unknown Cast` |
| `country` | 476 | Replaced with `Unknown Country` |
| `date_added` | 11 | Retained as unavailable dates |
| `rating` | 10 | Replaced with `Not Rated` |

The `date_added` values were stripped of extra spaces and converted to a pandas date-time type using mixed-format parsing. The 11 unavailable dates were retained as missing dates rather than replaced with invented information.

The dataset contained no completely duplicated rows. All 6,234 records and 12 columns were preserved after cleaning.

## Data Exploration

### Release Years

- Oldest release year: 1925
- Most recent release year: 2020
- Average release year: 2013.4

### Content Types

| Content Type | Titles | Percentage |
|---|---:|---:|
| Movie | 4,265 | 68.4% |
| TV Show | 1,969 | 31.6% |

Movies therefore represent more than twice as many catalog entries as TV Shows.

### Leading Ratings

| Rating | Titles |
|---|---:|
| TV-MA | 2,027 |
| TV-14 | 1,698 |
| TV-PG | 701 |
| R | 508 |
| PG-13 | 286 |

`TV-MA` is the most frequent content rating, followed by `TV-14`. These categories indicate a high concentration of catalog content classified for mature or teenage audiences.

### Leading Genres

The comma-separated `listed_in` values were split into individual genres before counting.

| Genre | Title Associations |
|---|---:|
| International Movies | 1,927 |
| Dramas | 1,623 |
| Comedies | 1,113 |
| International TV Shows | 1,001 |
| Documentaries | 668 |
| TV Dramas | 599 |
| Action & Adventure | 597 |
| Independent Movies | 552 |
| TV Comedies | 436 |
| Thrillers | 392 |

## Important Interpretation of “Most Watched Genres”

The dataset does not contain watch counts, viewing hours, streams, audience totals, or another measure of actual viewing behavior. Therefore, genre frequency in the Netflix catalog is used as a proxy for the assignment's “most watched genres” requirement.

The Python visualization is titled:

```text
Top 10 Most Common Genres in the Netflix Catalog
```

This wording accurately describes what the available data measures and avoids claiming that catalog frequency proves audience viewing popularity.

## Visualizations

### Python: Most Common Genres

`outputs/most_common_genres_python.png`

A horizontal Seaborn bar chart displays the ten most frequent catalog genres. The chart uses a continuous numeric x-axis, descending order, readable genre labels, and formatted values at the end of each bar.

### Python: Ratings Distribution

`outputs/ratings_distribution_python.png`

A vertical Seaborn bar chart displays all 15 rating categories. The categories are ordered from highest to lowest count, and each bar includes a formatted count label.

### R: Ratings Distribution

`outputs/ratings_distribution_r.png`

The ratings-distribution chart is reproduced in R using ggplot2. The R script independently cleans and counts the rating values before creating and saving the chart.

## Python and R Verification

The Python notebook exports its rating counts to `rating_counts_python.csv`. The R script imports that file and compares it with the rating counts calculated independently in R.

The verification produced:

```text
Python rating categories: 15
R rating categories: 15
Python total titles: 6234
R total titles: 6234
Python and R rating counts match: TRUE
```

This confirms that both languages produced the same rating-distribution results.

## Python Setup in Visual Studio Code

### Requirements

Install:

- Python 3
- Visual Studio Code
- Microsoft Python extension
- Microsoft Jupyter extension
- pandas
- seaborn
- matplotlib
- ipykernel

Install the required Python libraries from the Visual Studio Code terminal:

```bash
python -m pip install pandas seaborn matplotlib ipykernel
```

If the system uses `python3`, run:

```bash
python3 -m pip install pandas seaborn matplotlib ipykernel
```

## Run the Python Notebook

1. Open the `netflix-visual-analytics` project folder in Visual Studio Code.
2. Open `netflix_visual_analysis.ipynb`.
3. Select a Python kernel containing pandas, Seaborn, Matplotlib, and ipykernel.
4. Confirm that `netflix_data.zip` is in the project folder.
5. Select **Restart Kernel**.
6. Select **Run All**.
7. Confirm that no cell produces an unhandled error.
8. Confirm that the charts and exported files are created.

Expected Python confirmations include:

```text
Netflix dataset loaded successfully.
Number of rows: 6234
Number of columns: 12
Genre chart exists: True
Ratings chart exists: True
Cleaned file exists: True
Rating-count file exists: True
```

## R Setup in Visual Studio Code

### Requirements

Install:

- R
- Visual Studio Code
- R extension for Visual Studio Code
- ggplot2

Install ggplot2 from an R terminal:

```r
install.packages(
  "ggplot2",
  repos = "https://cloud.r-project.org"
)
```

## Run the R Script

Ensure that the following files are in the project folder:

```text
Netflix_shows_movies.csv
rating_counts_python.csv
netflix_visualization.R
```

### R Terminal Method

If necessary, set the R working directory to the project folder:

```r
setwd(
  "C:/path/to/netflix-visual-analytics"
)
```

Then run:

```r
source("netflix_visualization.R")
```

### PowerShell Method

From the project folder, run:

```powershell
Rscript "netflix_visualization.R"
```

The expected final summary is:

```text
R VISUALIZATION SUMMARY
==============================
Chart saved successfully: outputs/ratings_distribution_r.png
Chart file exists: TRUE
Rating categories displayed: 15
Python and R results verified: TRUE
```

## Reproducing the Complete Project

For a complete test:

1. Place `netflix_data.zip` beside the notebook.
2. Restart the Python kernel and run all notebook cells.
3. Confirm that `Netflix_shows_movies.csv` is created.
4. Confirm that `Netflix_shows_movies_cleaned.csv` is created.
5. Confirm that both Python charts are saved in `outputs/`.
6. Confirm that `rating_counts_python.csv` is created.
7. Run `netflix_visualization.R`.
8. Confirm that the R chart is saved.
9. Confirm that Python and R rating counts match.

## Findings and Limitations

The dataset contains 6,234 Netflix titles, including 4,265 Movies and 1,969 TV Shows. Movies account for 68.4% of the catalog, while TV Shows account for 31.6%.

`International Movies` is the most frequent genre with 1,927 title associations, followed by `Dramas` with 1,623 and `Comedies` with 1,113. `TV-MA` is the most common content rating with 2,027 titles, followed by `TV-14` with 1,698.

The genre analysis measures the number of catalog titles associated with each genre. It does not measure audience viewing behavior. The supplied dataset also ends in 2020, so the analysis does not describe Netflix's current catalog.

## Testing Checklist

Before submission, confirm that:

- [ ] `netflix_visual_analysis.ipynb` runs from beginning to end.
- [ ] `netflix_visualization.R` runs successfully.
- [ ] `Netflix_shows_movies.csv` is created.
- [ ] `Netflix_shows_movies_cleaned.csv` is created.
- [ ] Missing text values are handled.
- [ ] The 11 unavailable dates remain correctly represented.
- [ ] Duplicate-row count is zero.
- [ ] Genre values are split and counted correctly.
- [ ] `most_common_genres_python.png` exists.
- [ ] `ratings_distribution_python.png` exists.
- [ ] `ratings_distribution_r.png` exists.
- [ ] Python and R rating counts match.
- [ ] The README explains the “most watched genres” limitation.

## Possible Future Improvements

Future versions could include:

- A newer Netflix catalog dataset
- Actual viewing hours or audience-count data
- Country-level genre comparisons
- Movie-versus-TV rating comparisons
- Release-year trend visualizations
- Runtime and season analysis
- Interactive dashboards using Plotly, Shiny, Tableau, or Power BI
- Automated data-quality reports
- Statistical tests comparing content groups

## Data Use

The dataset is used for educational analysis. Before publishing the repository publicly, confirm that the supplied dataset is approved for redistribution.

## Author

Oluremi Moses Akindeko

## Purpose

Developed as part of a Master of Science in Data Analytics course assignment focused on visual analytics with Python and R.

## License

This project is intended for educational and portfolio purposes.
