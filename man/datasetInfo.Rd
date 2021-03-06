% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ep_dataset.R
\name{datasetInfo}
\alias{datasetInfo}
\title{datasetInfo}
\usage{
datasetInfo(
  dataset,
  request = NULL,
  ...,
  file = NULL,
  return = TRUE,
  overwrite = FALSE,
  memoised = FALSE
)
}
\arguments{
\item{dataset}{Character. Can either be the dataset ID or its short name 
(e.g. GSE1234). If a vector of length>1 is provided return all matching dataset
 objects similar to \code{\link{allDatasets}} but without access to additional 
 parameters. \code{request} parameter cannot be specified for inputs of length>1
 unless specifiet otherwise in request description.}

\item{request}{Character. If NULL retrieves the dataset object. Otherwise
 \itemize{
     \item \code{platforms}: Retrieves platforms for the given dataset
     \item \code{samples}: Retrieves samples for the given dataset
     \item \code{annotations}: Retrieves the annotations for the given dataset
     \item \code{design}: Retrieves the design for the given dataset
     \item \code{data}: Retrieves the data for the given dataset. Parameters:
         \itemize{
             \item \code{filter}: Optional, defaults to FALSE. If TRUE, call
              returns filtered expression data.
              \item \code{IdColnames}: Optional. defaults to FALSE.
               If true shortens data column names to only include the bioAssayId
               which is unique to samples in Gemma. Makes it easier to match to
               samples acqured from the "samples" request.
         }
     \item \code{differential}: Retrieves available differential expression
     tests for the given dataset.
         \itemize{
             \item \code{offset}: Optional, defaults to 0. Skips the 
             specified amount of objects when retrieving them from the
              database.
             \item \code{limit}: Optional, defaults to 20. Limits the result 
             to specified amount of objects. Use 0 for no limit.
         }
     \item \code{degs}: Retrieves the differential expression results for the given dataset.
         \itemize{
             \item \code{differential}: Differential id of the differential expression. Can be acquired
             from the \code{differential} endpoint.
         }
     \item \code{diffExExpr}: Retrieves expression values for differential expression subsets for the given datasets.
     Parameters:
         \itemize{
             \item \code{diffExSet}: Result set id of the differential expression. Can be
             acquired from the \code{differential} endpoint:
             
             \code{datasetInfo('GSE43364',request = 'differential')$resultSets[[1]]$id}
             \item \code{keepNonSpecific}: Optional, defaults to FALSE.
             
             If set to false, the response will only include elements that map exclusively to each gene
             
             If set to true, the response will include all elements that map to each gene, even if they also map to other genes.
             \item \code{threshold}: Optional, defaults to 100. 
             The threshold that the differential expression has to meet to be included in the response.
             \item \code{limit}: Optional, defaults to 100. Maximum amount of returned gene-probe expression level pairs to include in the response.
             \item \code{consolidate}: Optional. Defaults no NULL. 
             
             Whether genes with multiple elements should consolidate the information. If the 'keepNonSpecific' parameter is set to true, then all gene non-specific vectors are excluded from the chosen procedure.
             
             The options are:
                 \itemize{
                     \item \code{NULL}:list all vectors separately. 
                     \item \code{"pickmax"}: only return the vector that has the highest expression (mean over all its bioAssays).
                     \item \code{"pickvar"}: only return the vector with highest variance of expression across its bioAssays
                     \item \code{"average"}: create a new vector that will average the bioAssay values from all vectors
                 }
         }
     \item \code{geneExpression}: Retrieves the expression levels of given genes for 
     given datasets. Can be used with multiple datasets. Parameters:
         \itemize{
             \item \code{genes}: Required. A list of identifiers, separated by commas (e.g: 1859, 5728).
             
             Can either be the NCBI ID (1859), Ensembl ID (ENSG00000157540) or official symbol (DYRK1A) of the gene.
             
             NCBI ID is the most efficient (and guaranteed to be unique) identifier.
             
             Official symbol represents a gene homologue for a random taxon, unless used in a specific taxon (see the Taxa Endpoints).
             
             If the gene taxon does not match the taxon of the given datasets, expression levels for that gene will be missing from the response
             
             You can combine various identifiers in one query, but any invalid identifier will cause the call to yield an error. Duplicate identifiers of the same gene will result in duplicates in the response.
             
             \item \code{keepNonSpecific}: Optional. Defaults to FALSE. 
             
             If set to false, the response will only include elements that map exclusively to each queried gene
             
             If set to true, the response will include all elements that map to each queried gene, even if they also map to other genes.
             
             \item \code{consolidate}: Optional. Defaults no NULL. 
             
             Whether genes with multiple elements should consolidate the information. If the 'keepNonSpecific' parameter is set to true, then all gene non-specific vectors are excluded from the chosen procedure.
             
             The options are:
                 \itemize{
                     \item \code{NULL}:list all vectors separately. 
                     \item \code{"pickmax"}: only return the vector that has the highest expression (mean over all its bioAssays).
                     \item \code{"pickvar"}: only return the vector with highest variance of expression across its bioAssays
                     \item \code{"average"}: create a new vector that will average the bioAssay values from all vectors
                 }
         }
}}

\item{...}{Use if the specified request has additional parameters.}

\item{file}{Character. File path. If provided, response will be saved to file}

\item{return}{Logical. If the response should be returned. Set to false when
you only want to save a file}

\item{overwrite}{Logical. If TRUE, existing files will be overwritten. If FALSE
a warning will be thrown and no action is taken.}

\item{memoised}{Logical. If TRUE a memoised version of the function will be
used which is faster for repeated requests. Use \code{\link{forgetGemmaMemoised}}
to clear memory.}
}
\value{
A data.frame or a list depending on the request
}
\description{
Retrieves information about a single dataset based on the given dataset 
identifier. Combines several API calls
}
\examples{
\donttest{
datasetInfo('GSE81454')
datasetInfo('GSE81454', request = 'platforms')
datasetInfo('GSE81454', request='data',filter = FALSE)
}
}
