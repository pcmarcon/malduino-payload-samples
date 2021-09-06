ren h:\*.enc *.
del h:\test.txt
copy test.txt h:

ren \\w02.local\h$\*.enc *.
del \\w02.local\h$\test.txt
copy test.txt \\w02.local\h$
del \\w02.local\c$\temp\*.* /f/q

ren \\w03.local\h$\*.enc *.
del \\w03.local\h$\test.txt
copy test.txt \\w03.local\h$
del \\w03.local\c$\temp\*.* /f/q

ren \\w04.local\h$\*.enc *.
del \\w04.local\h$\test.txt
copy test.txt \\w04.local\h$
del \\w04.local\c$\temp\*.* /f/q

ren \\w05.local\h$\*.enc *.
del \\w05.local\h$\test.txt
copy test.txt \\w05.local\h$
del \\w05.local\c$\temp\*.* /f/q
