Hello,

I’ve recently had the chance to examine and analyze several aspects of our company data. I specifically worked with our users, brands, and receipts data. We have some very capable data quality tools at our disposal, and I was able to dig into the details to identify several issues and questions than need attention. I’m hoping you can point me in the right direction for a few of these questions.

I’ve listed out questions and comments for each topic.

Brands
-	I’ve found “test” data in our production dataset. I will contact the engineering operations team to let them know as test data will invalidate some of our analytics findings and metrics.
-	We have greater than 20% of our brands with a missing brand code. How can we address that? Should we consider brands without a brand code invalid?
-	We’re also utilizing both a brand code and a brand name. Are both necessary for the business? How do they relate to one another?
-	We have several brands in the dataset that share a barcode value with another brand. I’m assuming this shouldn’t happen. Can you confirm that each brand shouldn’t share a barcode value with any other brand? 

Users
-	We have Fetch staff as users in our dataset. Is this expected? It’s recommended that we remove the staff from our analytics products. If you could provide a point of contact for that, I’d like to start the process to remove them from production.
-	I’ve found duplicate entries for user ids. I’ll let the engineering operations team know and I’ll implement logic to ensure these don’t appear in our metrics.

Receipts
-	I noticed we have some receipts that earn an abnormally high value of points (e.g. greater than 1000). Do we have any limits or rules for maximum number of points earned per receipt? If so, we can add data validations to our processes to find invalid values.
-	I also have the same question for the count of items purchased for a receipt. Should there be any limits?
-	We also have receipts were the line items on the receipt repeat many times. Is this a quality issue we should watch out for and flag (e.g. the same item appearing more than 10 times on a receipt).
-	I see most of the receipt data we have is only from two months (2021-01 and 2021-02). I will ask around to see if there’s a reason for this and if we can possibly add much more data into our dataset.


General
-	I see that we use a terminology called “metabrite” in some of our data attributes. What is “metabrite” and are there any metrics that we should define around it?
-	Same question for “cpg”.

Thanks in advance for taking the time to go through these comments and questions. Once we’re able to address these data issues, we’ll not only have better data for our analysts and reports, but we’ll also keep our data pipelines more efficient by not having to process invalid data (and keep costs in check). Without addressing these issues, we waste both employee and operating costs to track down issues and potentially producing inaccurate business reports.

One last item that may help us (the data team) is help from you getting the word out that we’re on a mission to make our data assets as dependable and accurate as possible for the company. If you happen to interact with anyone that you feel could help us on that journey, please do let me know.

Thanks,
Lucas
