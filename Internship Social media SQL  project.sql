## SOCIAL MEDIA PROJECT ASSIGNMENT --
## Project overview ## 
-- The social media analytics tool aims to provide comprehensive insights 
-- into user interactions, content performance, and engagement metrics on a 
-- social media platform. The project involves managing and analyzing a variety of data 
-- points, such as user profiles, posts, comments, likes, and followers, to enable 
-- detailed performance tracking and trend analysis.

CREATE DATABASE social_media;
USE social_media;
select * from users; 
select * from photos; 
select * from videos; 
select * from post; 
select * from comments; 
select * from post_likes;
select * from comment_likes; 
select * from follows; 
select * from hashtags; 
select * from hashtag_follow; 
select * from post_tags; 
select * from bookmarks; 
select * from login; 

-- Q1 write a query to find all posts made by users in 
-- "agra","maharashtra" and "west bengal".
select * from users; 
select * from post;
alter table post add foreign key (user_id) references users (user_id);   
select DISTINCT(p.location),u.user_id,p.post_id,u.username from users u 
join post p
on u.user_id = p.user_id
where p.location in ('maharashtra',"Agra","west bengal");
##  Problem: It is difficult to understand the geographical 
-- distribution of content created by users in specific locations.
## Solution: The query retrieves posts from users located in "Agra," "maharashtra," and "west bengal," 
-- helping to analyze regional content trends and user engagement.
## output: "maharashtra" is the location where the most posts have been made.
-- West Bengal has a moderate number of posts, while Agra shows the lowest level 
-- of activity. Strategies should be developed to increase post engagement in West Bengal and Agra.

-- ***********************************************************************************************
-- Q2 write a query list top 5 most-followed hashtags on the 
-- platform.
select * from follows; 
select * from hashtags;
select * from hashtag_follow; 
select h.hashtag_name , count(hf.user_id)as follower_count from hashtag_follow hf  
join hashtags h 
on hf.hashtag_id = h.hashtag_id
group by h.hashtag_name
order by follower_count desc 
limit 5 ; 
## problam: Understanding which hashtags are the 
-- most popular and influential on the platform is challenging.
## solution: The query retrieves the top 5 hashtags with the highest number of followers.
-- This helps in identifying the most-followed hashtags and understanding user interests and trends.
## output: family is the most-followed hashtag with the highest number 4 of followers.
-- runforunity is the second followed hashtag with the highest number 3 of followers.
 
-- ***********************************************************************************************
-- Q3 Identify the top 10 most-used hashtags in posts. 
select * from post_likes; 
select * from post_tags; 
select * from hashtags; 
select * from post; 
select h.hashtag_name,h.hashtag_id,count(p.post_id) as use_count from hashtags h 
join post_tags p 
on h.hashtag_id = p.hashtag_id 
group by h.hashtag_name,h.hashtag_id
order by use_count desc 
limit 10; 
## problam: Determining which hashtags are most frequently used in posts is essential 
-- for understanding popular topics and trends on the platform.
## solution: The query retrieves the top 10 hashtags that are most frequently used in posts. 
-- This helps identify the most popular hashtags and gauge their relevance in the content shared by users.
## output: "photooftheday" is the most used hashtag with 20 occurrences, followed by "family" and "christmas" 
-- with 19 occurrences each.  

-- ********************************************************************************************************
-- Q4 Write a query to find users who have never made any posts on the
-- platform.
select * from users; 
select * from post; 
 select u.user_id, u.username from users u 
where user_id not in (select distinct user_id from post); 
## problam: Identifying users who have never contributed any posts on the platform is challenging. 
-- This information is crucial for understanding user engagement and targeting reactivation strategies.
## solution:The query retrieves users who do not have any entries in the post table.
## output: these users cameron,george,jamie,joshua and ollie users never made any posts.

-- ********************************************************************************************************
-- Q5 Write a query to find the posts that have received the highest number of
-- likes.
select * from post_likes; 
select * from post; 
select p.post_id, count(p.user_id)as like_post,p.caption from post p 
join post_likes pl 
on p.post_id = pl.post_id
group by p.post_id 
order by like_post desc 
limit 10; 
## problam:Identifying which posts have received the highest number of likes is essential 
-- for understanding user engagement and determining the most popular content on the platform.
## solution: The query retrieves posts along with their like counts and orders them to find the top posts 
-- with the highest number of likes. This helps to highlight the most liked posts and gauge their popularity.
## output: Post ID 42 has the most likes (24), followed by Post IDs 76 and 58 with 23 likes each.

-- ************************************************************************************************************
-- Q6 Write a query to determine the average number of posts made by users. 
  select * from post; 
  select * from users;
  select avg(post_count) as average_posts_per_user from
  ( select coalesce(count(p.post_id), 0) as post_count
from users u
left join post p 
on u.user_id = p.user_id
group by u.user_id) as user_post_counts; 
## problam: Problem: It is challenging to understand the overall engagement level of users on the platform.
## solution: Calculate the average number of posts per user.
## output:  The average number of posts per user is 2.0.

 -- *************************************************************************************************************
  -- Q7 Write a query to track the total number of logins made by each user.
  select * from users;
  select * from login; 
  select u.user_id, u.username , count(o.login_id) as number_logins from login o
  join users u 
  on u.user_id = o.user_id 
  group by u.user_id,u.username
  order by number_logins desc
  limit 5; 
  ## problam: Track the total number of logins made by each user and identify the top 5 users with the most logins.
  ## solution: Count and list the total logins for each user, showing the top 5.
  ## output: William is the most active user with 174 logins, followed by Mason with 74 logins. 
 
  -- ****************************************************************************************************************
  -- Q8 write a query to find any user who has liked every post on the platform.
select * from post_likes;
select user_id , count(user_id) from post_likes 
group by user_id 
having count(user_id) = (select count(post_id) from post); 
## problam:  Identify users who have liked every post available on the platform to gauge complete engagement.
## solution: List users who liked every post on the platform.
## output: There are no users who have liked every post.

  -- ********************************************************************************************************************
 -- Q9 write a query to find users who have never commented on any post.
 select * from users ; 
 select * from comments; 
 select u.user_id, u.username from users u 
 where user_id not in (select distinct user_id from comments c);
 ## problam: Identify users who have never commented on any post to understand engagement levels.
 ## solution:  Use a NOT IN subquery to filter users whose IDs do not appear in the comments table,
 -- ensuring the final result includes only those who have not commented.
 ## output: The query confirms that "Raj Gupta" has not liked any posts, and his details are returned. 
 
-- *************************************************************************************************************************
-- Q10 write a query to find any user who has commneted on every post.
 -- on the platform. 
 select * from comments; 
 select * from post ;
 select * from users; 
select u.user_id,u.username from users u 
join comments c 
on u.user_id = c.user_id 
group by u.user_id,u.username
having count(distinct c.post_id) = (select count(*) from post);
## problam: It is challenging to determine which users have engaged with every post on the platform by commenting on each one. 
-- Identifying such users is important for understanding complete user engagement and interaction with all available content.
## solution: The SQL query compares the number of distinct posts commented on by each user with the total number of posts.
--  It selects users who have commented on all posts.
## output: There are no users who have commented every post.

-- ****************************************************************************************************************************
-- Q11 Write a query to find users who are not followed by any other users. 
select * from users; 
select * from follows; 
select u.user_id , u.username from users u 
left join follows f 
on u.user_id = f.followee_id 
where f.followee_id is null; 
## problam: It is challenging to determine which users are not followed by any other users. Identifying such users helps  
-- in understanding which users have no followers, which could be important for engagement analysis or platform growth strategies.
## solution: The SQL query uses a LEFT JOIN to find users who do not have any followers by checking for NULL values in the follow relationship.
## output: There are no users followed by any other users. 

-- **********************************************************************************************************************************
-- Q12 Write a query to find users who are not following anyone.
select * from users ; 
select * from follows; 
select u.user_id, u.username from users u 
left join follows f 
on u.user_id = f.follower_id 
where f.follower_id is null; 
## problam: Identifying users who are not following anyone is important for understanding user engagement and activity on the platform.
## solution: he SQL query uses a LEFT JOIN to find users who do not have any following relationships by checking for NULL values
-- in the follower relationships.
## output: There are no users who following anyone.  

-- ***********************************************************************************************************************************
-- Q13 Write a query to find users who have made more than five posts.
select * from users; 
select * from post;
select u.user_id,u.username,count(p.post_id) as number_post from users u 
join post p 
on u.user_id = p.user_id 
group by u.user_id,username 
having number_post >5;  
## problam: It is important to determine which users are highly active on the platform by making
-- more than five posts. This helps in identifying active users and understanding their engagement level. 
## solution: The SQL query counts the number of posts for each user and filters to include those with more than five posts.
## output: user_id 37 Ethan made 6 post.  

-- ****************************************************************************************************************************************
-- Q14 Write a query to find users who have more than 40 followers.
select * from users; 
select * from follows; 
select u.user_id, u.username , count(f.follower_id) as follower from users u 
left join follows f 
on u.user_id = f.followee_id 
group by u.user_id,u.username 
having follower > 40
order by follower desc;
## problam: It is important to identify users who have a significant following on the platform, i.e., 
-- users who have more than 40 followers. This helps in understanding the reach and influence of users on the platform.
## solution: The SQL query counts the number of followers each user has and filters to include only those with more than 40 followers.
## output: the user "Charlie" has the highest 45 follower count, followed by others with equal counts.

-- *******************************************************************************************************************************************
-- Q15 write a query to find comments specific words like "good" 
-- or "beautiful. 
select * from comments ;
select comment_id, comment_text from comments 
where comment_text like "%good%" or comment_text like "%beautiful%";
## problam: Understanding which comments contain specific positive or aesthetically pleasing words like "good" or "beautiful" 
-- is crucial for analyzing user sentiment and identifying popular themes in user feedback.
## solution: The query retrieves comments from the comments table that include either the word "good" or "beautiful" in their text.
-- This helps in identifying and analyzing comments that use these keywords, which can be useful for sentiment analysis or content evaluation. 
## output: The results show that most comments are about beauty and looking good. They reflect a lot of positive feedback and admiration.   

-- *******************************************************************************  
-- Q16 write a query to find the posts with the longest captions.
select * from post; 
select user_id , caption,length(caption)as longest_captions from post 
order by longest_captions desc
limit 5 ;
## problam: Identifying which posts have the longest captions is useful for understanding which posts provide the most 
-- detailed or descriptive content.
## solution: calculates the length of each caption, and sorts the posts by caption length in descending order. This allows you to find 
-- and list the posts with the longest captions. 
## output: User ID 37 has the longest caption with 80 characters and the second User ID 50 has the second-longest caption with 76 characters 

-- *********************************************************************************************************************END













 







 

 
 
 
  
  
  
  
  
  
  
  
  
 
 
 
 











 

