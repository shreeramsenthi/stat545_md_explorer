context("Squaring non-numerics")

test_that("At least numeric values work.", {
  num_vec <- c(0, -4.6, 3.4)
  expect_identical(square(numeric(0)), numeric(0))
  expect_equal(square(num_vec), num_vec^2)
})

test_that("Logicals automatically convert to numeric.", {
  logic_vec <- c(T, T, F)
  expect_identical(square(logical(0)), numeric(0))
  expect_equal(class(square(logic_vec)), "numeric")
  expect_equal(square(logic_vec), c(1, 1, 0))
  }
)
