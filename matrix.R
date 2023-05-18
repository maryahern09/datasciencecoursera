## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function

makeCacheMatrix <- function(x = matrix()) {
  m <- NULL
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  get <- function() x
  setmedian <- function(median) m <<- median
  getmedian <- function() m
  list(set = set, get = get,
       setmedian = setmedian,
       getmedian = getmedian)
}
4+3

## Write a short comment describing this function

cacheSolve  <- function(x, ...) {
  m <- x$getmedian()
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  data <- x$get()
  m <- median(data, ...)
  x$setmedian(m)
  m
}

##testing functions
my_Matrix <- makeCacheMatrix(matrix(1:4,2 , 2))
my_Matrix$get()
