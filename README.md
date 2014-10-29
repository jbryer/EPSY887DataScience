# EPSY 887 Data Science Institute (Fall 2014) #

***Instructor:***		Jason Bryer (jason@bryer.org)   
***Class Time:*** 		Tuesday 4:15 p.m. - 7:05  p.m.  
***Class Location:***  	Humanities 24  
***Grading:*** 			3 credits, S/U grading  
***Course Website:*** 	[http://epsy887.bryer.org](http://epsy887.bryer.org)


Over the last five to ten years, data science has becoming one of the fastest growing fields and was named one of the "sexiest" jobs by [Harvard Business Review](http://hbr.org/2012/10/data-scientist-the-sexiest-job-of-the-21st-century/). But is data science something new? Conway (2010) describes data science as the intersection of statistics, hacking skill (e.g. programming, computer skills, etc.), and expertise (see Figure 1). This seminar will explore the skills and tools necessary for data science with a special emphasis on the role of data science in educational and social science contexts. The first third of the course will focus on learning [R](http://www.r-project.org), the open source statistical software and programming language used by many data scientists (i.e. hacking skills). The middle third will explore some of the important statistical procedures used by data scientists including: data visualizations, classification and regression trees, logistic regression, propensity score analysis, and other topics as time permits (i.e. math and statistical knowledge). The final third of class will be left for topics of special interest to students and their research agendas (i.e. substantive expertise). Class examples will utilize the [Programme of International Student Assessment](http://www.oecd.org/pisa/) (PISA), a large scale international study conducted every three years. Other open and freely available datasets will also be discussed as appropriate.

<img src='Figures/Data_Science_Venn_Diagram.png' width='50%' alt='The Data Science Venn Diagram'/>  
[Figure 1. The Data Science Venn Diagram (Conway, 2010)](http://drewconway.com/zia/2013/3/26/the-data-science-venn-diagram)


### Topics:


* Introduction to R (e.g. data input, recoding, etc.)
* Reshaping data ([`reshape` package](http://www.jstatsoft.org/v21/i12/paper))
* Data visualization vis-à-vis a grammar of graphics ([`ggplot2`](http://ggplot2.org/))
* Introduction to programming for data analysis (e.g. loops, conditional statements, functions, etc.)
* Missing data ([`MICE`](http://www.stefvanbuuren.nl/mi/), [`Amelia` II](http://gking.harvard.edu/amelia/))
* Analysis of complex surveys (e.g. use of replicate weights and multiple plausible values) ([`survey` package](http://faculty.washington.edu/tlumley/survey/))
* Document preparation and typesetting with Markdown, LaTeX, and Sweave
* R package development
* Web based and interactive graphics (including [Shiny](http://shiny.rstudio.com)).
* Software project management principles as applied to data analysis (e.g. source control, progress tracking, versioning, Github, R-Forge, etc.).
* Other statistical topics as identified by students and appropriate for analysis of large datasets. Topics may include:
	* Propensity score analysis
	* Item response theory
	* Random forests
	* Classification and regression trees
	* Cluster analysis
	* Principal component analysis
	* Factor analysis
	* Multilevel modeling

Students are encouraged to bring their own data and/or research questions as this seminar will emphasize applied statistics and analysis. Class examples however, will utilize the Programme for International Student Assessment (PISA; OECD 2009). 

### Prerequisites

It is recommended that students have at least two graduate level statistics courses (EPSY 530 and EPSY 630 or equivelent). No prior experiences with R is expected, but some experience with using statistical software would be helpful.

### Software

This course will make substantial use of the R software language. The following software is required and freely available. See the [installation](Installation/Install.md) page for details.

* [R](http://www.r-project.org)
* [Rtudio](http://www.rstudio.org)
* LaTeX ([MiKTeX](http://miktex.org/) on Windows or [MacTeX](http://www.tug.org/mactex/) on Mac)

### Suggested Textbooks

The first two books, Kabacoff and Matloff, are recommended for learning R. They provide two different perspectives on R. Specifically, Kabacoff presents R from a data analyst point-of-view whereas Matloff provides more of a software programming perspective. They complement each other nicely. Zumel's book covers topics in R more relevant to data science. Lastly, Shron's provides a discussion about thinking about data from different perspectives. It is not necessary to purchase all these books.

* Kabacoff, R.J. (2011). *[R in Action: Data Analysis and Graphics with R](http://www.amazon.com/R-Action-Robert-Kabacoff/dp/1935182390/ref=sr_1_1?ie=UTF8&qid=1351957914&sr=8-1&keywords=r+in+action&tag=jasbry-20)*. Shelter Island, NY: Manning.

* Matloff, N. (2011). *[The Art of R Programming](http://www.amazon.com/gp/product/B00683GXUO/ref=as_li_qf_sp_asin_il_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B00683GXUO&linkCode=as2&tag=jasbry-20)*. San Francisco, CA: No Stratch Press

* Zumel, N., & Mount, J. (2014). *[Practical Data Science with R](http://www.manning.com/zumel/)*. Shelter Island, NY: Manning.

* Shron, M. (2014). *[Thinking With Data: How to Turn Information into Insights](http://shop.oreilly.com/product/0636920029182.do)*. Sebastopol, CA: O'Reilly.


### Schedule

*NOTE: Tentative. Subject to change*

Date   | Topic 
-------|:------
Aug-26 | Intro to Data Science; Tools of the Trade
Sep-2  | Loading and working with data in R
Sep-9  | Data Visualizations using a grammar of graphics
Sep-16 | More Grammar of Graphics
Sep-23 | Intro to programming in R
Sep-30 | Missing Data / Analysis of complex surveys
Oct-7  | Classification and Regression Trees (CART) methods
Oct-14 | Intro to Propensity Score Analysis
Oct-21 | Bootstrapping PSA
Oct-28 | PSA with Non-Binary Treatments
Nov-4  | Multilevel PSA
Nov-11 | Markdown, LaTeX, and Shiny
Nov-18 | TBD
Nov-25 | TBD
Dec-2  | Presentations
Dec-9  | Presentations

### Grading

This course is graded as pass/fail. Successful students will attend and participate in the weekly classes. Additionally, contributing the course wiki is expected.

The culmination of the course will be a short (20 to 30 minute) presentation and document outlining the analysis you conducted with your dataset. Students are encouraged to bring their own dataset (e.g. data to be used for a dissertation), but that is not necessary. Many free and public datasets are available for use and will be discussed in the first couple classes.

### Academic Integrity

Whatever you produce for this course should be your own work and created specifically for this course. You cannot present work produced by others, nor offer any work that you presented or will present to another course. If you borrow text or media from another source or paraphrase substantial ideas from someone else, you must provide a reference to your source.

The University policy on academic dishonesty is clearly outlined in the Student Bulletin, and includes, but is not limited to plagiarism, cheating on examinations, multiple submissions, forgery, unauthorized collaboration, and falsification. These are serious infractions of University regulations and could result in a failing grade for the work in question, a failing grade in the course, or dismissal from the University. http://www.albany.edu/undergraduate_bulletin/regulations.html

### Reasonable Accommodation

Reasonable accommodations will be provided for students with documented physical, sensory, systemic, cognitive, learning and psychiatric disabilities. If you believe you have a disability requiring accommodation in this class, please notify the Director of Disabled Student Services (Campus Center 137, 442-5490). That office will provide the course instructor with verification of your dis- ability, and will recommend appropriate accommodations. For more information, visit the website of the UAlbany Office for Disabled Student Services. http://www.albany.edu/studentlife/DSS/ guidelines/accomodation.html

