% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{fastafile}
\alias{fastafile}
\title{Example nucleotide fasta file}
\format{
\subsection{\code{fastafile}}{

A character vector
}
}
\source{
Modified from \url{https://bioinformatics.org/annhyb/examples/seq_fasta.html}
and \url{https://en.wikipedia.org/wiki/FASTA_format}
}
\usage{
fastafile
}
\description{
An example fasta-formatted file with a mixture of nucleotide and protein
sequences. It is used in the vignette to demonstrate parsing with the tools
from the package. It is not clear to me whether mixing of sequence types is
allowed in a fasta file, but we demonstrate in the vignette that is is easy
to parse them from a single file. The sequences used are truncated for the
sake of the example.
}
\keyword{datasets}
