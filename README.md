# Cowboy Courses Prototype

#### Welcome to the prototype version of Cowboy Courses

This is the prototype of an application created to scrape the [Oklahoma State
University course catalog](http://prodosu.okstate.edu/osup-bin/tsrvweb.exe?&WID=W&tserve_tip_write=||WID&ConfigName=rclssecttrms2osu&ReqNum=1&TransactionSource=H&tserve_trans_config=rclssecttrms2osu.cfg&tserve_host_code=HostSeventeen&tserve_tiphost_code=TipSeventeen)

It was originally called sissed because the online system is called SIS:
Student Information System. This is the first prototype version I developed
in Rails 2.x, using Ruby Enterprise 1.8.7.

## What is Cowboy Courses?

Cowboy Courses is a web scraper that scrapes the Oklahoma
State University Course Catalog. It would get all the current
terms, subjects, courses, and sections with all the instructors,
dates, times, locations, course number, and status. 

It would allow a student to create an account, find the courses
they wanted and subscribe / watch them if a certain property had
changed. For example, if the professor changed, or time changed,
or the status changed from closed to open due to another student
unenrolling opening a seat. The application would then TXT/SMS or 
Email the student of the change. Then the student could get to a 
computer as fast as possible to enroll in that course they wanted.

## Use Case

The use case and where this is useful is when you are a freshmen
or perhaps a senior needing a certain course to graduate that is 
already full. There are other potential uses also. If you don't 
a specific date/time or instructor is another example.

## Other

Cowboy Courses also has the ability to rate and comment on courses.
Helping students find the best instructors and courses.
