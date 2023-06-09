#' Glioblastoma Data Collected by MD Anderson Cancer Center
#' 
#' To patients' privacy we are providing a resampled version of the original dataset
#' 
#' @format A \code{data.table} with 339 rows and 13 columns:
#' \describe{
#' \item{Surgery Reason}{A binary covariate  1=``therapeutic" or 0=``other" (relapse)}
#' \item{Histologic Grade}{A binary civariate indicating the grade of astrocytoma: 1=``IV (GBM)" or 0=``"I-III (low-grade or anaplastic)"  }
#' \item{EOR}{A binary civariate indicating the \emph{extent of resection}: 1=``gross-total" or 0=``sub-total"}
#' }
#' 
#' @source {MD Anderson Cancer Center}
#' 
#' @examples
#' data(MDACC_reproduced)
#' head(MDACC_reproduced)
"MDACC_reproduced"