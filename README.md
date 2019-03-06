# Booklet from PDF

This provides a process pipeline to generate a booklet from a given PDF such
that the booklet is printable at home. It will reorder the pages.  The number
of pages `n` of the input PDF has to be divisible by 4.  Denoting `[  |  ]` as
a pair of pages, the output will be reordered as follows:

    [      n |     1 ]
    [      2 | n - 1 ]
    [ n -  2 |     3 ]
    [      4 | n - 3 ]
    and so on ...

For example a booklet with 8 pages:

    $ ./page-order.sh 8
    8, 1,
    2, 7,
    6, 3
    5, 4

The printer settings would be `short-edge binding` and `2 pages per sheet` (and
the default layout direction ` left-to-right top-to-bottom`).

If your printer outputs the back-side of pages upside-down, use the
--rotate-back-page flag, as in `bookletfromPDF.sh input.pdf --rotate-back-page`

