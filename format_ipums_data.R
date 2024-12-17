library(arrow)

full_ipums <- read_csv_arrow("data/ipumsi_00013.csv.gz")

# ----- write csv files for each city/province----- 
library(parallel)
mclapply(
  unique(full_ipums$GEO1_VN2019),
  function(geocode){
    write_csv(
      full_ipums %>%
        filter(GEO1_VN2019 == geocode),
      str_interp("data/ipumsi_00013/GEO1_VN2019_${geocode}.csv")
    )

    gc()
    return()
  }

)

# ----- save full ipums as a parquet ----- 
write_parquet(full_ipums, "data/ipumsi_00013.parquet")