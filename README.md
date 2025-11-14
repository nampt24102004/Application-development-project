 
Requirement & Design Specification
Online Learning IT
Version: 1.2
				
*A - Added M - Modified D - Deleted

Table Contents

Contents
Record of Changes	2
Table Contents	2
I. Overview	4
1. System Context	4
1.1.Operating Environment	4
2. ERD	5
2. User Requirements	9
2.1 Actors	9
2.2 Diagrams	9
2.3 Descriptions	10
2.4 Main Workflows	13
3. System Functionalities	13
3.1 Screens Flow	13
3.2 Screen Authorization	13
3.3 Non-UI Functions	15
Activate account	15
II. Functional Requirements	16
1. Public View	16
1.1 Home	16
1.2 Blog	18
1.3 Blog Details	21
1.4 Course List	23
1.5 Course Detail	26
2. Authentication	30
2.1 User Register	30
2.2 User Login	32
2.3 Reset Password	34
2.4  Change Password	36
3. User Dashboard	38
3.1 User Profile	38
3.2 My Registration	41
3.3 My Course	45
3.4 Course Register	47
4. Subject Management	50
4.1 Subject List	50
4.2 New Subject	53
5. Learning Content	54
5.1 Lesson View:	54
6. Expert interface	62
6.1 New Course	62
6.2 Management Course	66
7. Admin interface	69
7.1 Registration List	69
7.2 Question List	73
7.3 Question Detail	75
III. System Design	77
1. Database Design	77
1.1 Database Schema	77
2.Header and Footer	78
2.2 Header	78
2.3 Footer	78
3. Code packages	79
3.1. Package diagram	79
3.2 Package Descriptions	79
3.3 Third‑Party Libraries	80

I. Overview
1. System Context 
The Online Learning IT System is an online learning platform specializing in information technology. The system provides management, learning, assessment and knowledge sharing functions for many user groups such as: students, experts, employees and administrators. The main goal of the system is to support learning and developing professional skills in the field of IT in a flexible, convenient and effective way.



1.1.Operating Environment
Operating Environment The application shall run on Tomcat 9, SQL Server 2019, supported browsers (Chrome, Edge, Firefox) on desktop and mobile



2. User Requirements
2.1 Actors

ID	Actor	Description
01	Guest	Non-authenticated users who can see public resources and perform operations không yêu cầu đăng nhập.
02	Admin	Manage existing users, add new Teachers and Course Managers; receive and process contact requests.
03	Course Manager	Authenticate and approve or reject courses submitted by Teachers.
04	Teacher	Create courses and their content (lectures, materials, quizzes, etc.) for the system
05	Student	Purchase and enroll in published courses; access learning materials and take quizzes; submit reviews for the courses you’ve completed.

2.2 Diagrams
2.2.1 UCs for Guest 

2.2.1 UCs for Student


2.2.3 UCs for Expert


2.2.4 UCs for Administrator

2.3 Descriptions

ID	Use Case	Actors	Use Case Description
1	User Login	Guest	Allow a guest to enter email and password to authenticate and access their account.
2	User Register	Guest	Allow a guest to submit registration information and create an unactivated account.
3	Reset Password	Guest	Allow a guest to enter their email to receive a password reset link.
4	User Authorization	System	Enforce role-based access control by validating user permissions for each request.
5	User Profile	Student, Teacher, Manager, Admin	Display the logged‑in user’s profile information, including role‑specific details.
6	Change Password	Student, Teacher, Manager, Admin	Allow a logged‑in user to update their password by providing the old password and a new one.
7	Home	Guest	Display homepage with sliders, hot posts, featured subjects and quick links.
8	Blogs List	Guest	Show a paginated list of blog posts sorted by most recent update.
9	Blog Details	Guest	Display full content of a selected blog post, including title, author, date and category.
10	Courses List	Guest	Show a paginated list of available courses sorted by most recent update.
11	Course Details	Guest	Display selected course’s description, price, curriculum outline, reviews and link to purchase.
12	Course Register	Student	Allow a student to enroll in a course, creating a new registration record.
13	My Registrations	Student	Show the student’s list of course registrations with status and dates.
14	My Courses	Student	Display courses in which the student is enrolled, with access links.
15	Lesson View	Student	Present course lessons (videos, materials) to the student for viewing.
16	Quiz Lesson	Student	Allow the student to attempt a lesson‑specific quiz and submit answers.
17	Quiz Handle	Student	Provide the quiz interface for the student to browse and answer questions.
18	Quiz Review	Student	Enable the student to review completed quiz details and correct answers.
19	Dashboard	Marketing	Display marketing statistics for subjects (new, total), new users and post performance.
20	Post Details	Marketing	Show detailed information about a selected post: thumbnail, category, title, content and stats.
21	Sliders List	Marketing	Present a paginated list of homepage sliders with preview images and titles.
22	Slider Details	Marketing	Display full details for a selected slider including image, title and link.
23	Subjects List	Admin, Expert	Show paginated list of all subjects with status, creation date and statistics.
24	New Subject	Admin, Expert	Provide form for admin/expert to enter new subject metadata (title, description, image).
25	Subject Details	Admin, Expert	Display full information of a subject and allow editing of its metadata.
26	Subject Dimension	Admin, Expert	Enable input or editing of a subject’s dimensions (duration, level, language).
27	Price Package	Admin	Allow admin to configure or update pricing packages for subjects.
28	Subject Lessons	Admin, Expert	Show list of lessons under a subject and allow adding or editing lessons.
29	Lesson Details	Admin, Expert	Provide form to create or update a lesson’s title, content, video and attachments.
30	Questions List	Admin, Expert	Present all existing questions for a subject with filters and pagination.
31	Question Details	Admin, Expert	Enable creation or editing of a specific question and its possible answers.
32	Question Import	Admin, Expert	Allow bulk import of questions from file into the question bank.
33	Quizzes List	Admin, Expert	Show list of quizzes created for a subject, with status and creation date.
34	Quiz Details	Admin, Expert	Provide form to create or edit quiz metadata and assign questions.
35	Registrations List	Sales	Display paginated list of user registrations with subject, date and status.
36	Registration Details	Sales	Show full details of a specific registration, including user info and subject data.
37	Users List	Admin	Present paginated list of all registered users with status and role filters.
38	User Details	Admin	Display detailed information for a user (avatar, contact, role, status).
39	Settings List	Admin	Show paginated list of application settings with keys and current values.
40	Setting Details	Admin	Enable viewing and editing of a single application setting’s key, value and description.

2.4 Main Workflows
Main Information/Data Entities Managed
●Users (Students, Admins)
●Courses
●Registrations
●Payments
System Roles/Actors
●Student
●Admin
Workflows Overview
This swimlane diagram describes the course registration and approval process involving two main roles: Student and Admin.


3. System Functionalities
3.1 Screens Flow

3.2 Screen Authorization


Screen Name	Guest	Customer	Expert	Admin
User Login	X	X	X	X
User Register	X	X	X	X
Reset Password	X	X	X	X
User Profile		X	X	X
Change Password		X	X	X
Home	X	X	X	X
Blogs List	X	X	X	X
Blog Details	X	X	X	X
Courses List	X	X	X	X
Course Details	X	X	X	X
Course Register	X	X	X	X
My Registrations		X		
My Courses		X		
Lesson View		X		
Dashboard				X
Post Details	X	X	X	X
Sliders List	X	X	X	X
Slider Details				
Subjects List			X	X
New Subject			X	X
Subject Details			X	X
Subject Dimension			X	X
Price Package			X	X
Lesson Details			X	X
Questions List			X	
Question Details			X	
Question Create			X	
Registrations List				X
Users List				X




3.3 Non-UI Functions

#	Feature	System Function	Description
1	User Authorization	Send email	Validate session/token and enforce role-based access control on all API endpoints (no UI).
2	User Authentication	Clean revoked token	Periodically remove or invalidate revoked/expired tokens to ensure secure sessions.
3	Authorization	Permission checks	Check user roles and permissions before allowing access to restricted resources or actions.
4	Activate Account	Send email	Send activation link to the user’s email after registration for account verification.

II. Functional Requirements
1. Public View
1.1 Home





Field	Details
Use Case Name	View Home Page
Created By	Nguyễn Khải
Date Created	21/07/2025
Primary Actor	Guest/User
Secondary Actors	None
Trigger	User navigates to the website’s home page.
Description	Allows any visitor to view the main home page, displaying a slider carousel, featured courses, latest blog posts, featured subjects, and a sidebar with latest posts & contact info, with links to detail pages.
Preconditions	- Active internet connection- Web server & CMS running
Postconditions	- Home‑page components rendered- Visitor may click any item (slider, course, post, subject, contact) to navigate to its detail page
Normal Flow	1. User opens home page URL.
2. System loads slider data & displays carousel.
3. System loads latest blog posts (thumbnails, titles, dates)
.4. System loads featured subjects (image, title, tagline).
5. System loads featured courses.
6. Renders sidebar (latest posts, contact).
7–10. Visitor clicks any slider/post/subject/course → redirected to detail.
Alternative Flows	- No slider data → show “No sliders available” placeholder
.- No blog posts → show “No hot posts available.”
- No subjects → show “
No featured subjects at this time.”- No courses → show “
No featured courses at this time.”
Exceptions	- Backend failure → show “Unable to load content. Please try again later.”
- Image load error → display alt‑text + fallback image
Priority	Medium
Frequency of Use	Very frequent (on every site visit)
Business Rules	BR-01	Only published sliders, posts, subjects, and courses are shown on the home page.
BR-02	All clickable elements (slider, post, course, subject) must redirect to a valid detail page.
BR-03	Sidebar must always contain at least one valid contact info item (email or phone).
BR-04	If no slider/post/subject/course data exists, the system must show a “no data” placeholder.
BR-05	On backend failure, system shows “Unable to load content” instead of crashing.
BR-06	On image load error, alt-text must be shown and a fallback image must be displayed.
BR-07	Homepage components must reflow responsively for desktop, tablet, and mobile devices.
BR-08	Blog posts must include thumbnail, title, and post date.
BR-09	Featured subjects must include an image, title, and tagline.
BR-10	Sliders must contain image, title, and a backlink to valid content.
Other Information	- UI Includes: Slider carousel, Blog grid, Course cards, Subject gallery, Sidebar widget.
- Responsive: Components must reflow for mobile, tablet, and desktop.
Assumptions	- Content managed via CMS & delivered via APIs.- Static assets served via CDN.- Browsers support modern HTML5/CSS3 features.

1.2 Blog



Field	Details
Use Case Name:	Blog List
Created By:	Nguyễn Khải	Date Created:	26/05/2025
Primary Actor:	Registered User	Secondary Actors	Guest

Trigger	User navigates to the blog listing page (e.g. via “Blog” link or pagination controls)
Description	Displays a paginated list of blog posts sorted by most recent update. Each post shows its thumbnail, title, category, and brief summary. Sidebar includes search box, categories, latest posts, and contact/links.
Preconditions	- User has internet access and opens the blog list URL.
- At least one published post exists (unless alternative flow applies).
Postconditions	- User views list of posts (or placeholder message).
- Clicking a post redirects to its detail page.
Normal Flow	1. System retrieves page 1 of posts sorted by UpdatedDate DESC.
2. Displays up to N posts per page, each with thumbnail, title, category, summary.
3. Renders pagination controls.
4. Renders sidebar:   
     a. Search box   
     b. Categories list   
     c. Latest 5 posts  
     d. Static contact/links
5. User interacts (pagination/search/category) → list updates.
6. User clicks thumbnail/title → redirect to PostDetailServlet?postId=….
Alternative Flows	- No posts available → show “No posts available.” + sidebar.
- No categories defined → sidebar shows “No categories.”
- ≤5 posts exist → “Latest Posts” lists however many available
.- Search yields no results → show “No posts match your search.” + “Clear search” link.
Exceptions	- Database failure → show “Unable to load posts. Please try again later.”
- Image load failure → display default placeholder thumbnail.
Priority	Medium
Frequency of Use	Very frequent (most visitors browse blog listings)
Business Rules	BR-11	Only posts with Status = 1 (published) are displayed in the blog list.
BR-12	Pagination size is configurable (e.g., 10 posts per page).
BR-13	Search filters blog posts based on keywords in both title and content.
BR-14	Category filter displays only categories that contain at least one published post.
BR-15	"Latest Posts" in the sidebar always shows up to 5 most recently updated published posts.
BR-16	If no blog posts exist, the system shows “No posts available” along with the sidebar.
BR-17	If no categories are defined, the sidebar shows “No categories.”
BR-18	If search yields no results, the system shows “No posts match your search” and a “Clear search” link.
BR-19	Clicking any blog title or thumbnail redirects to its detail page using PostDetailServlet?postId=...
BR-20	On image load failure, a default placeholder thumbnail must be displayed.

1.3 Blog Details



Field	Details
Use Case Name:	Blog Details
Created By:	Nguyễn Khải
Date Created:	26/05/2025
Primary Actor:	Registered User
Secondary Actors:	Guest
Trigger:	User clicks the thumbnail or title of a blog post on the listing page (e.g. BlogList.jsp?postId=…).
Description:	Displays the full content of a single blog post, including title, author, date, category, body text/images, comments, and related posts. Sidebar shows search, categories, latest posts, contact/links.
Preconditions:	- User has internet access and opens the blog‑details URL (PostDetailServlet?postId=…)
.- The requested post exists and has Status = 1 (published).
Postconditions:	- User views the complete post with all metadata.- User may scroll, share, or comment (if permitted).
Normal Flow:	1. System reads the postId parameter.
2. Retrieves the post’s data (title, author, date, category, content, images).
3. Retrieves comments for that post.
4. Retrieves top 5 “Latest Posts” and categories with ≥1 published post.
5. Retrieves related posts (same category, most recent).
6. Renders page: • Header with title, author name (link), date, category (link) • Post body (formatted text, images) • Share buttons (Facebook, Twitter, LinkedIn) • Comments section: list existing + comment form (if registered) • Sidebar: search box, category list, latest 5 posts, static contact/links
7. User may: • Submit a comment → go to step 8 
• Click a related post → redirect to its details (restart flow)
 • Use pagination/search in sidebar → redirect to blog list
Alternative Flows:	- Invalid postId → show “Post not found.” + sidebar
- No comments → display “Be the first to comment.” + show comment form if registered
- ≤5 latest posts → list however many available
- No related posts → omit “Related Posts” section (or show “No related posts”).
Exceptions:	- Database failure → show “Unable to load post. Please try again later.”
- Image load failure → display default placeholder image- Comment submission error → show validation or “Unable to submit comment.”
Priority:	High
Frequency of Use:	Very frequent (every time a visitor reads a post)
Business Rules:	BR-21	Only blog posts with Status = 1 (published) can be viewed.
BR-22	Comments can only be submitted by registered (logged-in) users.
BR-23	The comment form must validate that content is not empty before submission.
BR-24	Related posts must be from the same category as the current post, excluding the current post itself.
BR-25	Share buttons must generate proper URLs that include the postId parameter.
BR-26	If postId is invalid or not found, system shows “Post not found.”
BR-27	If there are no comments, display “Be the first to comment.” along with the comment form (if logged in).
BR-28	“Latest Posts” sidebar shows up to 5 most recently updated published posts.
BR-29	If there are no related posts, hide or replace the “Related Posts” section.
BR-30	On image load failure, display a default placeholder image.
BR-31	On comment submission error, show validation feedback or “Unable to submit comment.”






1.4 Course List


UC Name:	 Courses List
Created By:	NamPT	Date Created:	4/7/2025
Primary Actor:	 Guest,Student	Secondary Actors:	
Trigger:	The user accesses the "Course System" interface from the main menu or homepage.
Description:	This use case describes the process in which users (students) browse, search, and register for available courses on the system. Courses are displayed by category, with pagination, can be filtered as desired when users view the list and can be registered for directly from the listing.
Preconditions:	●The user must be logged into the system (for course registration).
● The course database must be available.
● A stable internet connection is required.
● The user has not registered for the same course previously.
Postconditions:	● The selected course is added to the user's registration list .
● The user can access the course from the "My Course" section.
Normal Flow:	10.0 Course Browsing and Registration
1. The user accesses the "Course System" interface.
2. The system displays a list of available courses, grouped by category.
3. The user can:
●Use the search bar to filter by course name.
●Filter by category (e.g., Programming, Databases, Marketing, Management).
●View featured courses in the left sidebar.

4. The user clicks the "Register Now" button below a course card.
5. The system processes the registration and returns a response.
6. The user is redirected to a confirmation page or the "My Registrations" page.
7. The user is can be filtered as desired when users view the list.

Alternative Flows:	10.1 Course Already Registered
●If the user has already registered for a course:

○The system shows a message: “You have already registered for this course.”

○No duplicate registration is performed.

10.2 No Courses Displayed
●If no courses match the criteria:

○The system shows the message: “No courses match your search criteria.”
Exceptions:	10.E.1 Database Connection Failure
●If the database query fails:

○The system shows an error: “Unable to load course list. Please try again later.”
Priority:	High
Frequency of Use:	Students are expected to use this feature frequently when browsing or registering for new courses.
Business Rules:	BR-30, BR-31, BR-34, BR-36, BR-38
Other Information:	● All course updates and edit changes must comply with security and data integrity standards.
Assumptions:	●The system has a sufficient number of available courses to display.

●Each student can register for a course only once.

1.5 Course Detail


UC Name:	  Course Details
Created By:	NamPT	Date Created:	06/06/2025
Primary Actor:	Guest, Student	Secondary Actors:	
Trigger:	The user selects a specific course from the course listing on the “Course System” interface.
Description:	This use case describes the process by which a student views the full details of a selected course. It includes course name, overview, description, original and discounted prices, category, user reviews of the course and a "Register Now" button for enrollment. It also provides navigation to other courses, categories, and contact links.
Preconditions:	●The user must be logged in to register for a course.
●The course database must be accessible.
●A stable internet connection must be available.
●The course being viewed must exist in the system.
Postconditions:	●If the user registers, the course is added to their registration list with status (e.g., Pending or Approved).
●The user can view this course in their "My Courses" section.
Normal Flow:	11.0 Viewing Course Details and Registration
1.The user accesses the "Course System" from the main menu or homepage.
2.The user selects a course from the list to view its details.
3.The system displays the Course Detail page with:
○Course title
○Overview and description
○Original and discounted prices
○"Register Now" button
○Sidebar with search, categories, featured subjects, and contact links
○Review of Student
4.The user may:
○Click Register Now to initiate registration
○Use the Search bar to explore other courses
○Filter by subject categories or click featured courses
○View images and videos for the course in the slider section.
○Create and view review of courses. 
5.If the user clicks Register Now, the system processes the request.
6.The system redirects the user to the confirmation page or "My Registrations".


Alternative Flows:	11.1 Course Already Registered
●If the user has already registered for the selected course:
○The system displays a message: “You have already registered for this course.”
○No duplicate registration is performed.
11.2 No Course Details Found
●If the course is not available or has been removed:
○The system shows the message: “Course details are not available.”
Exceptions:	11.E.1 Database Connection Failure
●If the system fails to retrieve course data:
○An error is shown: “Unable to load course details. Please try again later.”
Priority:	High
Frequency of Use:	Very frequent. Students regularly view course details before registering.
Business Rules:	BR-13,BR-30,BR-31, BR-34, BR-36, BR-38
Other Information:	●The UI must follow the latest accessibility and usability standards.
●Any course update or modification must comply with data integrity policies.
Assumptions:	●The course exists in the database at the time of access.
●The user is authorized to register.
●The system has sufficient content and course diversity.


2. Authentication 
2.1 User Register


Use Case Name:	User Register
Created By:	Nguyễn Bảo Long	Date Created:	06/06/2025
Primary Actor:	Guest	Secondary Actors:	None
Trigger:	A guest user navigates to the "Create Your Account" page and starts filling in the registration form.
Description:	This use case allows new users to register for an account by providing their personal details, setting a password, and gaining access to the system.
Preconditions:	PRE-1: The website can be accessed.
PRE-2: The user has a valid email address.
PRE-3: The email service is functional to send the password creation link.
Postconditions:	POST-1: The user successfully creates an account, sets a password, and can log in.
POST-2: If registration or password setting fails, the user is informed with an appropriate error message.
Normal Flow:	1. The user navigates to the "Create Your Account" registration page.
2. The user fills in their Full Name, selects Gender, enters Email Address, and Phone Number.
3. The user clicks the "Sign Up" button.
4. The system validates the provided details (e.g., unique email).
5. If valid, the system creates a temporary account and sends a time-limited password creation link to the user's email.
6. The system displays a confirmation that the link has been sent.
7. The user opens the email and clicks the "Set Your Password" link (or similar).
8. The user is redirected to the "Set Your Password" page.
9. The user enters a new password twice (Enter New Password, Confirm New Password), ensuring it meets requirements.
10. The user clicks "Save & Login".
11. The system validates the new password and updates the user's account with the new password.
12. Upon successful password setting, the user is prompted to login or is automatically logged in.
Alternative Flows:	None
Exceptions:	- If any required field (Full Name, Email Address, Phone Number) is empty, display an error: "Field is required."
- If the Email Address is already registered, display an error: "Email already exists. Please sign in."
- If the password creation link has expired, display an error: "The link has expired. Please try creating an account again."
- If the new passwords do not match, display an error: "Passwords do not match."
- If the new password does not meet requirements (e.g., minimum length, character types), display an error: "Password must meet requirements."
- If an invalid email format is entered, display an error: "Invalid email format."
Priority:	High
Frequency of Use:	Occasionally
Business Rule:	BR-INPUT-1, BR-INPUT-2, BR-PASS-1, BR-PASS-2, BR-EMAIL-1, BR-LINK-1, BR-NOTIF-1.


2.2 User Login

Use Case Name:	Login
Created By:	Nguyễn Bảo Long		
Primary Actor:	Guest		
Trigger:	The user attempts to access a protected area of the system or clicks a "Sign In" button/link.
Description:	This use case allows a registered user to gain access to the system by providing their valid credentials (email and password).
Preconditions:	PRE-1: The website is accessible.
PRE-2: The user has a registered account with valid credentials (email and password).
Postconditions:	POST-1: The user is successfully logged into the system and redirected to their dashboard/home page.
POST-2: If login fails, the user is informed with an appropriate error message.
Normal Flow:	1. The user navigates to the login page ("Welcome back").
2. The user enters their registered Email in the "Enter Your Email" field.
3. The user enters their Password in the "Enter Your Password" field.
4. The user clicks the "Sign In" button.
5. The system validates the entered credentials against the stored user data.
6. If the credentials are valid, the system logs the user in.
7. The user is redirected to the main application page or dashboard.
Alternative Flows:	AF-1: User clicks "Forgot Password?": The system redirects the user to the password reset flow.
AF-2: User clicks "Sign up": The system redirects the user to the account registration flow.
Exceptions:	- If the "Enter Your Email" field is empty, display an error message: "Email is required."
- If the "Enter Your Password" field is empty, display an error message: "Password is required."
- If the entered Email and Password do not match any registered account, display an error message: "Invalid email or password."
- If the account is locked or banned, display an error message: "Your account is locked. Please contact support."
Priority:	High
Frequency of Use:	Frequent
Business Rule:	BR-INPUT-1, BR-LOGIN-1, BR-LOGIN-2, BR-NAV-1, BR-NOTIF-1.
2.3 Reset Password


Use Case Name:	Reset Password
Created By:	Nguyễn Bảo Long	Date Created:	26/05/2025
Primary Actor:	Guest, Customer, Admin/Manager	Secondary Actors:	None
Trigger:	A user initiates the password reset process by requesting a reset link.
Description:	This use case allows users who have forgotten their password to reset it by receiving a time-limited reset link via email and entering a new password.
Preconditions:	PRE-1: The website can be accessed.
PRE-2: The user has a registered account with a valid email address.
PRE-3: The email service is functional to send the reset link.
Postconditions:	POST-1: The user successfully resets their password and can log in with the new password.
POST-2: If the reset fails, the user is informed with an appropriate error message.
Normal Flow:	1. The user navigates to the reset password page.
2. The user enters their registered email address.
3. The user submits the reset password request.
4. The system validates the email against the database.
5. If valid, the system generates a time-limited reset link and sends it to the user's email.
6. The user clicks the link and is redirected to the password reset page.
7. The user enters the new password twice for confirmation.
8. The system validates the new password (e.g., matching entries, meeting password requirements).
9. Upon successful validation, the password is updated, and the user is notified of success.
10. The user can log in with the new password.
Alternative Flows:	None
Exceptions:	- If the email field is empty, display an error message: "Email is required."
- If the email is not registered, display an error message: "Email not found."
- If the reset link has expired, display an error message: "The reset link has expired. Please request a new one."
- If the new passwords do not match, display an error message: "Passwords do not match."
- If the new password does not meet requirements (e.g., minimum length), display an error message: "Password must meet requirements."
Priority:	High
Frequency of Use:	Occasionally
Business Rule:	BR-INPUT-1, BR-EMAIL-1, BR-LINK-1, BR-PASS-1, BR-PASS-2, BR-NOTIF-1.

2.4  Change Password


Use Case Name:	Change Password
Created By:	Nguyễn Bảo Long	Date Created:	06/06/2025
Primary Actor:	Customer, Admin/Manager	Secondary Actors	None
Trigger:	The user, while logged in, navigates to the "Change Password" section of their profile or settings.
Description:	This use case allows a logged-in user to update their existing password to a new one, ensuring account security.
Preconditions:	PRE-1: The user is successfully logged into the system.
PRE-2: The user remembers their current password.
Postconditions:	POST-1: The user's password is successfully updated, and they can log in with the new password.
POST-2: If the password change fails, the user is informed with an appropriate error message.
Normal Flow:	1. The logged-in user navigates to the "Change Password" screen.
2. The user enters their current password in the "Old Password" field.
3. The user enters their desired new password in the "Enter New Password" field.
4. The user re-enters the new password in the "Confirm New Password" field.
5. The user clicks the "Save Change" button.
6. The system validates the "Old Password" against the stored current password.
7. The system validates that "Enter New Password" and "Confirm New Password" match.
8. The system validates that the "New Password" meets all defined requirements (e.g., minimum length, character types).
9. If all validations pass, the system updates the user's password in the database.
10. The user receives a success notification (e.g., "Password changed successfully").
Alternative Flows:	AF-1: User clicks "Forgot Password?": The system redirects the user to the password reset flow (similar to the forgotten password flow).
Exceptions:	- If "Old Password" field is empty, display an error message: "Old Password is required."
- If "Enter New Password" field is empty, display an error message: "New Password is required."
- If "Confirm New Password" field is empty, display an error message: "Confirm New Password is required."
- If "Old Password" does not match the current password, display an error message: "Incorrect Old Password."
- If "Enter New Password" and "Confirm New Password" do not match, display an error message: "New passwords do not match."
- If "Enter New Password" does not meet requirements (e.g., minimum length, character types), display an error message: "New password must meet requirements."
- If the new password is the same as the old password, display an error message: "New password cannot be the same as old password."
Priority:	High
Frequency of Use:	Occasionally
Business Rule:	BR-INPUT-1, BR-PASS-1, BR-PASS-2, BR-PASS-3, BR-PASS-4, BR-NAV-1, BR-NOTIF-1.


3. User Dashboard
3.1 User Profile


UC Name:	 Change profile student
Created By:	NamPT	Date Created:	26/05/2025
Primary Actor:	Student	Secondary Actors:	Admin/Expert
Trigger:	The student initiates profile updates from their dashboard by selecting "Change"options.
Description:	This use case describes  the process of users modifying their personal and account information within the system. Students can update their profile details while maintaining data integrity and security.
Preconditions:	● Student must be logged into the system
● Student is on the user dashboard
● Student has necessary permissions to modify their profile
● Network connection is stable
● System database is operational
Postconditions:	● Student profile information is successfully updated
● Changes are immediately reflected in the user's account
Normal Flow:	5.0 Profile information update
1. The Student navigates to the profile section in the user dashboard.
2. The system displays the current profile information.
3. The Student selects the "Chỉnh sửa" option.
4. The system presents editable fields:
● Name
● Birthday:
● Phone:
● Mail:
● Gender (Male/ Female)
● Image URL
5. The Student modifies the desired fields.
6. Email cannot be changed
7.The Student confirms the changes by clicking the” Save" button.
8. Students return to the User Profile by clicking the “Back” button.
9. The system updates the database with the new profile information
10. The system displays a success confirmation message.
11. The user returns to the profile overview.
Alternative Flows:	5.1 Invalid profile information
1. Steps 1-6 of "Change Information" are the same as the Normal Flow.
2. If the profile data entered is invalid:
● The system highlights specific invalid fields.
● The system displays detailed error messages.
● The system prevents the save operation.
● The system retains valid input information.
Exceptions:	5.E.1 Database connection failure
1. If database update fails:
● Abort profile/password modification
● Rollback any partial changes
● Display system error message
Priority:	Frequently
Frequency of Use:	Expected multiple times per user account lifecycle
Business Rules:	BR-23, BR-24, BR-25, BR-26, BR-29, BR-50
Other Information:	● All profile updates and password changes must comply with security and data integrity standards.
Assumptions:	The system enforces user-specific access controls to ensure that users can only modify their own profile.

3.2 My Registration


UC Name:	 My Registrations
Created By:	NamPT	Date Created:	26/05/2025
Primary Actor:	Student	Secondary Actors:	N/A
Trigger:	The student navigates to the "My Registrations" section from their dashboard.
Description:	This use case describes the process by which a student views their course registration list, utilizes sidebar features for subject search and navigation, and optionally manages registrations that are in “Submitted” status.
Preconditions:	● Student must be logged into the system.
● Student is on the dashboard or any navigable location with access to the “My Registrations” section.
● Network connection is stable.
● System database is operational
Postconditions:	● Student views a list of all their course registrations.
● If applicable, the student can cancel or edit registrations that are still in "Submitted" status.
Normal Flow:	13.0  View My Registrations
1. The student navigates to the “My Registrations” section.
2. The system displays the search with:
●A subject search box
          3. The system displays a list of the user's course                          registrations.
4. Each registration includes the following information:
●STT
●Course name
●Registration time
●Package
●Total cost
●Status (e.g., Submitted, Paid, Cancelled)
●Valid from date
●Valid to date
5. For each registration in “Submitted” status:
●The system displays “Cancel” and “Payment” actions.
●If the student clicks “Cancel”, the system prompts for confirmation.
○Upon confirmation, the registration is marked as cancelled.
●If the student clicks “Payment”, the system will open a window for the student to confirm the transfer to the payment page.
6. The system updates the registration data in the database (if payment/cancelled).
7.A confirmation message is shown to the student.

Alternative Flows:	13.1 Invalid Edit Attempt
1.If the student edits a registration but enters invalid data:
●The system highlights invalid fields.
●Displays appropriate error messages.
●Prevents submission until valid data is entered.
Exceptions:	5.E.1 Database connection failure
1. If database update fails:
●Abort the process.
●Rollback any partial changes.
●Display a system error message.
Priority:	Frequently
Frequency of Use:	Frequently, depending on course registration activities.
Business Rules:	BR-01, BR-07, BR-08, BR-25, BR-27, BR-28, BR-38
Other Information:	●Sidebar remains accessible and functional during user interactions with the registration list.
●UX design ensures clear visibility of actions (payment/cancel) based on status.
Assumptions:	●The system enforces user-specific access control.
●System time zone settings are consistent when calculating “valid from” and “valid to” dates.


3.3 My Course



UC Name:	 View My Courses
Created By:	NamPT	Date Created:	26/05/2025
Primary Actor:	Student	Secondary Actors:	N/A
Trigger:	User clicks on "My Courses" from the main navigation bar after logging in.
Preconditions:	● The user is logged in.
●  The account has at least one successfully registered course.
● Network connection is stable.
● System database is operational
Postconditions:	●  The learner sees the list of courses they have access to.
● The learner can click “View” to view the lesson of each course.
Normal Flow:	14.0 View My Courses
1. The learner accesses the “My Course” page from the navigation bar.
2. The system queries the list of courses that the learner has registered for and approved.
3. The courses are displayed as a list of cards (cards), each card can display course information.
4.Each card displays:
●Course name 
●Representative image (if any)
●“View” button to access course details
5. The learner clicks “View” to view the detailed content of the corresponding course.
Alternative Flows:	14.1 No courses
1.  If the user does not have any approved courses:
2.The system displays the message: “You have not registered for any courses.”
Exceptions:	5.E.1 Database error or access denied
1. If failed data query or access invalid:
●The system displays the error: "Course cannot be loaded. Please try again later."
Priority:	Frequently
Frequency of Use:	Frequently whenever a learner wants to access his course.
Business Rules:	BR-01, BR-13, BR-21, BR-37, BR-38, BR-32
Other Information:	●Sidebar remains accessible and functional during user interactions with the registration list.

●UX design ensures clear visibility of actions (edit/cancel) based on status.
Assumptions:	●The user has registered for only courses and successfully browsed.
●Reasonable system authorization.

3.4 Course Register


UC Name:	Course Register
Created By:	NamPT	Date Created:	06/06/2025
Primary Actor:	Student	Secondary Actors:	N/A
Trigger:	The user clicks the "Register Now" button on the course detail page.
Description:	This use case describes the process in which a student registers for a specific course by filling out a registration form. The form collects essential information including price package, full name, email, mobile number, and gender. Upon submission, the system validates and stores the registration.
Preconditions:	●The user must be logged into the system.
●The selected course and its price packages must exist in the database.
●The registration form must be accessible.
●Internet connection must be stable.
Postconditions:	●The registration request is recorded in the system with appropriate status (e.g., Pending).
●Confirmation is displayed or the user is redirected to their "My Registration" or success message page.
Normal Flow:	1.7.0 Register for a Course Using the Form
1.The user views the course details page.
2.The user clicks "Register Now".
3.The system displays the registration form with the following fields:
○Dropdown to select Price Package
○Text fields for Full Name, Email, Mobile
○Dropdown for Gender
4.The user fills in the form and clicks "Register".
5.The system validates the inputs:
○All fields must be filled.
○Email and mobile must follow correct format.
6.If validation passes:
○Registration data is saved in the system.
○The system shows a success message or redirects to confirmation.
7.If the user clicks "Cancel", the system clears the form or redirects back to course detail
Alternative Flows:	1.7.1 Invalid or Incomplete Input
●If the user submits the form with missing or invalid information:
○The system displays an error message next to each invalid field.
○The user is asked to correct and resubmit.
1.7.2 Already Registered for the Course
●If the user is already registered:
○The system shows: “You have already registered for this course.”
○Duplicate registration is not allowed.
Exceptions:	1.7.3 Database Save Failure
●If registration data fails to save due to a database error:
○The system displays: “Unable to process registration at this time. Please try again later.”
Priority:	High
Frequency of Use:	Frequent – used whenever students enroll in courses.
Business Rules:	BR-01, BR-14, BR-22, BR-25, BR-26, BR-34, BR-35
Other Information:	●Form layout should be responsive on both desktop and mobile.
●Data must be stored securely and comply with privacy policies.
Assumptions:	●The course has at least one active price package.
●The system backend supports student registration logic.
●Form data is sanitized before being saved.


3.5 Payment



UC Name:	Payment
Created By:	NamPT	Date Created:	23/07/2025
Primary Actor:	Student	Secondary Actors:	N/A
Trigger:	Student clicks on the "Pay" or "Confirm Payment" button after selecting a course and package.
Description:	This screen displays the course registration summary before the student confirms their payment.
The page shows a table containing:
●Course name
●Package
●Price
●Valid from (start date)
●Valid to (end date)
●Status (e.g., "Pending payment", "Awaiting confirmation")
At the bottom, there is a “Payment Confirm” button to finalize the registration/payment.
Preconditions:	●Student is logged in
●Student has selected a course and package to register
●The course, package, and price info are loaded from the database
Postconditions:	The student’s registration status is updated (e.g., from “Pending” to “Confirmed”)
Payment confirmation is recorded and visible in the student profile
Valid date ranges are stored for access control
Normal Flow:	Student selects a course and package from course catalog.
System redirects to the Course Payment screen.
The screen displays:
●Course name
●Package name
●Total price
●Valid from / to
●Current status (default: “Pending ”)
Student reviews the information.
Student clicks “Payment Confirm”.
The system:
●Validates the registration details
●Saves the registration with status “Confirmed” or equivalent
●Shows a success message or redirects to the list of registered courses
Alternative Flows:	Incomplete Information
●If any course or package info is missing:
○Show message: “Invalid registration data. Please try again.”
Payment Failed
●If payment processing fails (in real case with gateway):
○Show error: “Payment failed. Please check your balance or try again later.”
Exceptions:	Server/Database Error:
●Show message: “Unable to complete registration. Please try again later.”
Priority:	Frequently
Frequency of Use:	Moderate – Only when students actively register for a course.
Business Rules:	BR-01, BR-22, BR-30, BR-31, BR-32, BR-33, BR-37
Other Information:	●Should be mobile-friendly
●Use loading animation when confirming
●If using payment gateway, this step might redirect externally
Assumptions:	●Course and package details are already configured
●System backend supports registration status update and history tracking





4. Subject Management
4.1 Subject List




Field	Details
Use Case Name:	New Subject
Created By:	Nguyễn Khải	Date Created:	26/05/2025
Primary Actor:	Admin	Secondary Actors	Expert

Trigger	The user (Admin or Expert) navigates to the Subject List screen after login.
Description	This use case describes how Admin and Expert users can view the list of subjects. Admin sees all subjects, Experts see only their assigned subjects. The list supports search, filtering by category/status, and direct links to add/edit/view subjects (admin only for edit/add).
Preconditions	- User is logged in as Admin or Expert.
- System database is operational.
- There is at least one subject in the system for display.
Postconditions	- The list of subjects matching search/filter criteria is displayed.
- Data shown respects role-based permissions.
- Actions to add/edit/view subjects are available as per user role.
Normal Flow	1. User accesses the Subject List screen via menu/header.
2. System checks user's role.
3. System retrieves subjects:   
- Admin: all subjects   
- Expert: only subjects assigned to this expert
4. System displays subjects in table format with details (Name, Category, Owner, Status, etc.)
5. User may filter/search by name, category, or status.
6. Admin can click “Add New Subject” to create a new subject.
7. Admin can click “Edit” or “View” on a subject; Expert can only “View” their assigned subjects.
8. If no result: system shows “No subjects found.”
Alternative Flows	No Subjects Found:
- If filter/search yields no results, display: “No subjects found.”Unauthorized Role:
- If a user is not Admin/Expert, redirect to Access Denied page.
Exceptions	Database Connection Failure:
- Display error: "System is temporarily unavailable." Log error for admin review.
Priority	High
Frequency of Use	Very frequent – used by Admin/Experts to manage and track all subjects/courses.
Business Rules	BR-101: Only Admin can add/edit any subject.
BR-102: Expert can only view subjects assigned to them.
BR-103: Search/filter is case-insensitive.
BR-104: Subjects listed must display Owner (Expert), Category, Status.
BR-105: Only subjects with status (active/draft) shown based on filter.
Other Information	- Owner field shows full name of assigned Expert.
- Supports pagination if many subjects.
- Frontend may show role badge and avatar in header.
- All links/actions respect role-based permissions.
- UI design supports responsive layouts for desktop/tablet.

4.2 New Subject


Field	Description
Use Case ID	UC-12
Use Case Name	Create New Subject
Created By	KhaiNHE191679
Date Created	03/07/2025
Primary Actor	Admin
Secondary Actors	Expert
Trigger	Admin selects “Add New Subject” from the Subject List screen.
Description	This use case describes how an Admin user can create a new subject by entering subject details including Name, Category, Owner, Status, and Description.
Preconditions	User is logged in as Admin.System database is operational.
Postconditions	A new subject is successfully created and stored in the database.Subject List screen updates to show the newly created subject.
Normal Flow	Admin clicks the “Add New Subject” button on the Subject List screen.System displays the "New Subject" form.Admin fills in the required fields: SubjectName, Category, Owner (Expert), Status, and Description.Admin submits the form by clicking "Save."System validates input data.System saves the new subject to the database and returns to the Subject List screen, displaying the updated list.
Alternative Flows	Validation Error: If validation fails, the system displays specific error messages next to relevant fields.Cancel Creation: Admin clicks "Cancel," and the system returns to the Subject List without saving data.
Exceptions	Database Connection Failure: Display error: "System is temporarily unavailable." Log error for admin review.
Priority	High
Frequency of Use	Frequent – Admin regularly creates new subjects to keep course content updated.
Business Rules	BR-101: Only Admin can add/edit any subject.
BR-103: Category selection and Status selection are mandatory.
BR-104: Subject name must be unique within the same category.
Other Information	Owner field displays full names of Experts.UI design supports responsive layouts for desktop/tablet.System-generated SubjectID is not editable by Admin.



5. Learning Content
5.1 Lesson View:






Field	Details
Use Case Name:	Lesson View
Created By:	Nguyễn Khải	Date Created:	26/05/2025
Primary Actor:	Registered User	Secondary Actors	Guest

Trigger	The student selects a registered course to view its lesson structure and content.
Description
 	This use case describes how a student views a list of lessons in a course they are registered in.
 Lessons are organized hierarchically: Sections contain multiple Modules, and each Module contains one or more Lessons.(Section > Module > Lesson)
Each Lesson includes a title, detailed content, status, display order, and may include a video or content link via the URLLesson attribute.
The student can navigate through Sections and expand Modules to view all Lessons within a Course in a clear hierarchical structure.
 
 
Preconditions	Student is logged in.

Student has an approved registration for the selected course.

The selected course has at least one section with modules and lessons.

System database is operational.
 
Postconditions
 	All lessons are displayed in hierarchy: Section → Module → Lesson.

Lessons are sorted by their [Order] value within each module.

Only lessons with Status = 1 (active) are displayed.

Each lesson’s main content link is rendered from the URLLesson field.
 
Normal Flow	1.The student navigates to the "My Courses" page after logging in.

2.The student selects a registered course to view its content.

3.The system queries data from the CourseSection, SectionModule, and Lesson tables to retrieve all related lessons for the selected course.

4.The system organizes the data into a hierarchical structure: Section → Module → Lesson.

5.Each lesson is displayed with its basic details: LessonID, LessonTitle, LessonDetails, Status, and URLLesson.

6.Lessons within each module are sorted by their [Order] field to ensure the correct sequence.

7.The student clicks on a lesson title to open and view the lesson content.

8.The system renders the lesson content by embedding the media or page linked through the URLLesson field (e.g., video, article).
 
 	 
 
Alternative Flows	No Lessons Found
● If no lesson exists for the course, system displays:
 “No lessons available for this course.”
 
Exceptions	Database Connection Failure
● Abort operation.

● Display error: "System is temporarily unavailable."

● Log the error for admin review.

Invalid URLLesson or Missing Content
● Show placeholder: “Lesson content not available.”

● Skip broken lesson instead of blocking whole view.

 
Priority	High
Frequency of Use	Very frequent – students use this whenever accessing course content.
 
Business Rules	● BR-35:
 Mỗi bài học (Lesson) phải liên kết với một Module hợp lệ, và Module đó phải nằm trong một Section thuộc Course.

● BR-36:
 Chỉ các bài học có Status = 1 (Active) mới được hiển thị cho sinh viên.

● BR-37:
 Các bài học trong cùng một Module phải được sắp xếp theo trường [Order] để đảm bảo trình tự học tập.

● BR-38:
 Sinh viên chỉ được xem bài học của những khóa học mà họ đã đăng ký thành công (Registration.Status = 'Approved').

● BR-40:
 Cấu trúc hiển thị bài học phải tuân theo phân cấp:
 Course → Section → Module → Lesson.

 
Other Information	● LessonDetails supports rich text or HTML content.

● URLLesson may point to embedded videos, articles, or external materials.

● Frontend UI supports expanding/collapsing of sections and modules.

● Grid/List layout is handled by frontend only (no DB support required).



6. Expert interface
6.1 Management Course 


UC Name:	Management Course
Created By:	NamPT	Date Created:	18/07/2025
Primary Actor:	Expert	Secondary Actors:	
Trigger:	The user (Expert) clicks on “Student Course Management” to view all students registered for courses.
Description:	This screen shows a list of students who have registered for courses.
 Experts and Admins can view important student course details and delete a student’s course registration if needed.
Each row shows one student’s information:
●Full name
●Email
●Phone number
●Course name
●Package name
●Price
●Registration date
●Duration
●A Delete button to remove the Course
Preconditions:	●The user must be logged in with the role of Expert or Admin.
●At least one student must be registered for a course.
The system must have access to the student and course data.
Postconditions:	●The selected student’s course registration is removed from the system (if deleted).
●The screen updates to reflect the change.
Normal Flow:	1.Expert/Admin opens the "Student Course Management" screen.
2.The system loads a table showing:
●STT (index)
●Full Name
●Email
●Phone Number
●Course
●Package
●Price
●Registration Date
●Duration
●Action (Delete button)
3.The user can scroll through the list and review course info.
4.If the user clicks Delete on a row:
●The system asks for confirmation (optional).
●If confirmed, the course registration for that student is deleted.
●The table is refreshed.
Alternative Flows:	Delete Canceled:
●If the user cancels the delete confirmation:
Nothing changes.
○The table remains the same.
Exceptions:	1 –  No Data Available:
●If there are no students registered:
○Show a message like “No registrations found.”
Priority:	High
Frequency of Use:	Often – whenever Admins or Experts need to check or manage student course registrations.
Business Rules:	
Other Information:	●Table must support mobile and desktop views.
●Icons help visually identify fields (email, phone, calendar).
●Table should allow pagination or filtering if data grows large.
Assumptions:	●All student-course registration data is stored in the database.
●Deleting a course registration does not affect the student’s account.
●Proper confirmation before delete to avoid accidental loss.

7. Admin interface
7.1 Registration List





UC Name:	Registration List
Created By:	NamPT	Date Created:	18/07/2025
Primary Actor:	Admin	Secondary Actors:	N/A
Trigger:	The Admin clicks on the "Course Registration" section from the admin panel.
Description:	This screen allows the Admin to view, filter, sort, and manage all course registrations in the system.
At the top of the screen, summary cards show:
●Total registrations
●Registrations pending approval
●Accepted registrations
●Rejected/Canceled registrations
Below that, the main table lists each course registration with the following details:
●ID
●User email
●Registration time
●Course (subject)
●Package
●Total cost
●Status (Approved, Pending, NotApproved,Paid)
●Valid from
●Valid to
●Last updated by
Admins can:
●Search by email
●Filter by:
○Course (with searchable dropdown)
○Registration time (from date, to date)
○Status
●Sort the list by:
○ID, Email, Registration Time, Subject, Package, Total Cost, Status, Valid From, Valid To
●Edit existing registration 
Preconditions:	●The user must be logged in with Admin role.
●The system has registration records.
●Subject and package data are available.
●Backend supports filtering, searching, and sorting.
Postconditions:	●The registration list is updated based on filters/search/sort.
●New or edited registration is saved successfully.
●Changes are reflected immediately in the list.
Normal Flow:	1.Admin accesses the "Course Registration" screen.
2.The screen shows summary counters and a registration table.
3.Admin uses:
●Search bar to find by email.
●Dropdown filter for subject.
●Date picker for registration time.
●Filter for status.
4.Admin can sort the table by clicking on any column header.
5.Admin can click:
●Edit icon on any row to modify the selected registration.
6.After saving, the changes update the list.
Alternative Flows:	1 – No Results Found:
●If the filters/search return no matches:
○Display message: “No registrations found.”
2 – Save Failed (Edit):
●If saving changes fails:Display message: “Unable to save registration. Please try again later
Exceptions:	1 – Backend Unavailable:
●If the system cannot load data due to a server issue:
Display message: “Unable to load registrations. Please check your connection or try again later.”
Priority:	High
Frequency of Use:	Very Frequent – Used daily by Admins to track student registrations.
Business Rules:	BR-07, BR-11, BR-12, BR-14, BR-15
Other Information:	●Screen must work smoothly on both desktop and tablet.
●Actions should be secured and logged (especially updates).
●Pagination or load-more should be used if the list is long.
Assumptions:	●Courses and packages are already defined in the system.
●Admin has permission to manage all user registrations.
●Data updates in real-time or on save.
7.2 Question List


Use Case Name:	Question List
Created By:	Nguyễn Bảo Long	Date Created:	06/06/2025
Primary Actor:	Admin	Secondary Actors	None
Trigger:	The Admin/Manager navigates to the "Questions List" section of the system.
Description:	This use case allows an authorized user (Admin/Manager) to view, search, filter, refresh, add, and edit questions within the system.
Preconditions:	PRE-1: The user is successfully logged into the system with appropriate "Admin/Manager" role.
PRE-2: The system's question database is accessible.
Postconditions:	POST-1: The user successfully views and interacts with the question list according to their actions.
POST-2: Any applied searches, filters, or pagination changes are reflected in the displayed list.
POST-3: If a new question is added or an existing one is edited, the changes are saved to the database.
Normal Flow:	1. The user navigates to the "Questions List" screen.
2. The system displays the list of questions with default sorting and pagination.
3. Search: The user enters a keyword in the "Search question ..." field and clicks "Apply" (or presses Enter). The system filters the list to show matching questions.
4. Filter: The user selects an option from the "Filter by Level" dropdown and clicks "Apply". The system filters the list by the selected level.
5. Records/Page: The user enters/selects a number in "Records/Page" and clicks "Apply". The system updates the number of questions displayed per page.
6. Refresh: The user clicks the "Refresh" button. The system reloads the list, clearing any applied search/filters.
7. Add New Question: The user clicks the "+ Add new Question" button. The system navigates to the "Add New Question" form.
8. Edit Question: The user clicks the edit icon/link in the "Option" column for a specific question. The system navigates to the "Edit Question" form for that question.
9. Pagination: The user clicks on pagination buttons (e.g., page numbers, next/previous arrows) to navigate between pages of the question list. The system displays the questions for the selected page.
Alternative Flows:	None
Exceptions:	- If no results are found for a search/filter, display "No questions found matching your criteria."
- If invalid input is provided for "Records/Page", display an error message (e.g., "Invalid number of records per page.").
- If there is a database connection issue, display an error message: "Unable to load questions. Please try again later."
- If the user attempts to add/edit a question without necessary permissions, display "Access Denied."
Priority:	High
Frequency of Use:	Frequent
Business Rule:	BR-AUTH-1, BR-QL-1, BR-QL-2, BR-QL-3, BR-ERROR-DB.
7.3 Question Detail


Use Case Name:	Question Details
Created By:	Nguyễn Bảo Long	Date Created:	24/06/2025
Primary Actor:	Admin	Secondary Actors	None
Trigger:	The Admin/Manager navigates to the "Questions List" section of the system.
Description:	This use case allows an authorized user to view, edit, and manage the detailed information of a specific question, including its content, answers, and associated media.
Preconditions:	PRE-1: The user is successfully logged into the system with appropriate "Admin/Manager" role.
PRE-2: The system's question database and media storage are accessible.
PRE-3: If editing, the question must exist in the database.
Postconditions:	POST-1: All valid changes to the question details and associated media are successfully saved.
POST-2: If a question is deleted, it is removed from the database.
POST-3: The user is notified of success or any errors during the process.
Normal Flow:	1. The user navigates to the "Questions Details" screen (either for a new or existing question).
2. View/Edit Question Fields: The user views or modifies fields such as Subject, Dimension(s), Lesson, Status, and Content.
3. Manage Answers:
a. The user modifies existing answers (Answer, Explanation) and adjusts "Correct ?" checkbox.
b. The user clicks "Add answer" to add new answer fields.
c. The user clicks the "-" icon to remove an answer.
4. Manage Media:
a. The user clicks "Change List Media". The "Change List Media" modal/screen appears.
b. The user can click "Add media" to add new media rows.
c. For each media item, the user selects "Type Media", clicks "Choose File" to select a media file, and enters a "Description".
d. The user can click the "-" icon next to a media item to remove it.
e. The user clicks "Save Media List" within the modal to apply media changes. The system validates and uploads/updates media associations. The user receives a media save confirmation.
f. The media modal closes, and the user returns to the "Questions Details" screen with updated media preview.
5. The user clicks "Save Changes" (on the main "Questions Details" screen) to apply all modifications to the question.
6. The system validates all input fields (question details, answers, media associations).
7. If validation passes, the system updates the question details in the database.
8. The user receives a success message (e.g., "Question details saved successfully").
9. Delete Question (Optional): The user clicks "Delete Question".
10. The system prompts for confirmation.
11. If confirmed, the system deletes the question from the database and redirects to the "Questions List" screen.
12. The user receives a success message (e.g., "Question deleted successfully").
Alternative Flows:	AF-1: User clicks the "Back Arrow" on "Questions Details": The system navigates back to the "Questions List" without saving unsaved changes (may prompt for confirmation).
AF-2: User clicks the "X" (close) button on "Change List Media" modal: The modal closes without saving media changes made during that session.
Exceptions:	- If any required field on "Questions Details" (e.g., Subject, Content, at least one Answer) is empty, display an error message: "Field is required."
- If invalid data format is entered (e.g., non-numeric where number is expected), display an error: "Invalid input format."
- If "Save Changes" on main screen fails due to a database error, display: "Failed to save changes. Please try again."
- If "Delete Question" fails, display: "Failed to delete question. Please try again."
- If no correct answer is marked, or multiple correct answers are marked (if only one is allowed), display an error (e.g., "Please select exactly one correct answer.").
- Media Exceptions:
- If no file is chosen after clicking "Choose File", display an error: "Please select a file."
- If an unsupported file type is chosen, display an error: "Unsupported file format."
- If file upload fails (e.g., network error, server issue), display an error: "File upload failed. Please try again."
- If "Description" field is empty for a media item (if required), display an error: "Description is required for media."
- If "Save Media List" fails due to a database error, display: "Failed to save media list. Please try again."
Priority:	High
Frequency of Use:	Frequent
Business Rule:	BR-AUTH-1, BR-INPUT-1, BR-INPUT-2, BR-QD-1, BR-QD-2, BR-QD-3, BR-QD-4, BR-QD-5, BR-QD-6, BR-ERROR-DB, BR-NOTIF-1.
7.4 User List



UC Name:	UserList
Created By:	NamPT	Date Created:	22/07/2025
Primary Actor:	Admin	Secondary Actors:	N/A
Trigger:	Admin clicks on the “User List” section from the admin panel.
Description:	This screen allows the Admin to view, filter, sort, search, and manage all registered users in the system.
At the top of the screen:
●A search box lets the admin search users by Full Name, Email, or Mobile number
●Dropdown filters allow filtering by Gender, Role, and Status
●A "Filter/Search" button applies the current search/filter criteria
Below that, the user table displays the following fields:
●ID (STT)
●Full Name
●Gender
●Email
●Mobile
Role
●Status
●Action (Edit / Delete)
Each row includes action buttons to edit or delete the user.
 Above the table, there is a “+ Add New User” button.
Pagination is used if the list is long, with a page number shown at the bottom.
Preconditions:	●Admin is logged in
●There are user records in the database
●Backend API supports filtering, searching, sorting, pagination
Postconditions:	●User list is updated dynamically based on search, filters, or sorting
●If a user is edited, the change reflects immediately
●New users can be added via the form triggered by “Add New User”
Normal Flow:	1.Admin opens the "User List" screen.
2.The system shows the list of users with search and filter controls.
3.Admin types into the search box to filter by name, email, or mobile.
4.Admin selects filters from Gender, Role, and Status dropdowns.
5.Admin clicks “Filter/Search” to update the user list.
6.Admin can click on any column header to sort (ascending/descending) by ID, Name, Gender, Email, Mobile, Role, or Status.
7.Admin clicks:
○Edit to view/edit a user’s info.
○Delete to remove a user.
8.Admin can click the “+ Add New User” button to add a new user.

Alternative Flows:	●No Matches Found:
○Show message: “No users found.”
●Save Failed (Edit/Add):
○Show message: “Unable to save user. Please try again later.”
Exceptions:	Exceptions:
1.Backend Error or Server Timeout:Show message: “Unable to load user data. Please try again later.”
Priority:	High
Frequency of Use:	Very Frequent – Used daily by Admins to track student registrations.
Business Rules:	BR-21, BR-22, BR-23, BR-24, BR-26
Other Information:	●Page should work on both desktop and tablet smoothly
●Use pagination for long lists
●Search and filters should be responsive and not require full page reload
Assumptions:	●Admin has proper rights to manage users
●User roles and statuses are predefined in the system



III. System Design
1. Database Design
1.1 Database Schema

1.2 Data Description

No.	Table	Description
1	Role	Description: Store user roles- RoleID (PK): INT- RoleName: NVARCHAR(10), one of ‘Admin’, ‘Expert’, ‘Student’
2	Account	Description: Store user account details
- UserID (PK): INT identity
- RoleID (FK → Role.RoleID): INT
- FullName: NVARCHAR(100)
- Gender: NVARCHAR(10), ‘Male’/’Female’/’Other’
- Email: NVARCHAR(100)- PhoneNumber: VARCHAR(20)
- Password: NVARCHAR(255) (hashed)- URLAvatar: NVARCHAR(255)
- Status: NVARCHAR(20), ‘active’/’warning’/’banned’
- Address: NVARCHAR(200)
- Birthday: DATE
3

	Setting	Description: Store per‑user settings- SettingID (PK): INT
- UserID (FK → Account.UserID): INT
- SettingType: NVARCHAR(50)
- SettingValue: NVARCHAR(MAX)
- SettingOrder: INT
- SettingDecription: NVARCHAR(255)
- SettingStatus: BIT (0/1)
4	PostCategory	Description: Store blog post categories
- CategoryID (PK): INT
- CategoryName: NVARCHAR(100)
- URL: NVARCHAR(255)
5	Post	Description: Store blog posts- PostID (PK): INT
- UserID (FK → Account.UserID): INT
- CategoryID (FK → PostCategory.CategoryID): INT
- BlogTitle: NVARCHAR(255)
- PostDetails: NVARCHAR(MAX)- Status: BIT (0/1)
- UpdatedDate: DATETIME
- ThumbnailURL: NVARCHAR(255)- IsHot: BIT (0/1)
6	Subject	Description: Store course subjects/topics- SubjectID (PK): INT identity
- SubjectName: NVARCHAR(100)
- Category: NVARCHAR(50)
- OwnerID (FK → Account.UserID): INT
- FeaturedFlag: BIT (0/1)
- Status: BIT (0/1)
- Description: NVARCHAR(MAX)
7	Dimension	Description: Store dimensions linked to a subject
- DimensionID (PK): INT
- SubjectID (FK → Subject.SubjectID): INT
- DimensionName: NVARCHAR(255)
- Description: NVARCHAR(255)
8	ExpertSubject	Description: Map experts to subjects (M:N)
- ExpertID (FK → Account.UserID): INT
- SubjectID (FK → Subject.SubjectID): INT
9	SubjectMedia	Description: Store media for subjects
- MediaID (PK): INT identity
- SubjectID (FK → Subject.SubjectID): INT
- MediaURL: NVARCHAR(255)
- MediaType: NVARCHAR(10), ‘image’/’video’
- MediaName: NVARCHAR(255)
10	Course	Description: Store courses under subjects
- CourseID (PK): INT
- SubjectID (FK → Subject.SubjectID): INT
- CourseTitle: NVARCHAR(255)
- CourseTag: NVARCHAR(100)
- URLCourse: NVARCHAR(255)
- CourseDetail: NVARCHAR(MAX)
- CourseLevel: NVARCHAR(50)
- FeatureFlag: NVARCHAR(50)
- Status: BIT (0/1)- CourseraDuration: INT
11	CourseMedia	Description: Store media for courses
- MediaID (PK): INT identity
- CourseID (FK → Course.CourseID): INT
- MediaURL: NVARCHAR(255)
- MediaType: NVARCHAR(10), ‘image’/’video’
12	Review	Description: Store user reviews for courses
- ReviewID (PK): INT
- UserID (FK → Account.UserID): INT- CourseID (FK → Course.CourseID): INT
- Content: NVARCHAR(MAX)
- Star: INT (1–5)- CreatedAt: DATETIME
- Status: BIT (0/1)
- ImageURL: NVARCHAR(255)
13	CourseSection	Description: Store sections within a course
- SectionID (PK): INT
- CourseID (FK → Course.CourseID): INT
- SectionTitle: NVARCHAR(255)
14	SectionModule	Description: Store modules within a section- ModuleID (PK): INT
- SectionID (FK → CourseSection.SectionID): INT
- ModuleTitle: NVARCHAR(255)
15	PricePackage	Description: Store pricing packages for courses
- PackageID (PK): INT- CourseID (FK → Course.CourseID): INT
- Name: NVARCHAR(100)
- AccessDuration: INT- ListPrice: DECIMAL(18,2)
- SalePrice: DECIMAL(18,2)
- Status: BIT (0/1)
- Description: NVARCHAR(MAX)
16	Registration	Description: Store user registrations to courses
- RegistrationID (PK): INT
- UserID (FK → Account.UserID): INT
- CourseID (FK → Course.CourseID): INT
- PackageID (FK → PricePackage.PackageID): INT
- ApprovedBy (FK → Account.UserID): INT
- Status: NVARCHAR(20), ‘Pending’/’Approved’/’NotApproved’
- ValidFrom: DATE- ValidTo: DATE
17	Lesson	Description: Store lessons within modules
- LessonID (PK): INT
- ModuleID (FK → SectionModule.ModuleID): INT
- LessonTitle: NVARCHAR(255)
- LessonDetails: NVARCHAR(MAX)
- URLLesson: NVARCHAR(255)- [Order]: INT
- Status: BIT (0/1)
18	LessonProgress	Description: Track user lesson completion
- UserID (PK, FK → Account.UserID): INT
- LessonID (PK, FK → Lesson.LessonID): INT
- Completed: BIT (0/1)- CompletedAt: DATETIME
19	Quiz	Description: Store quizzes for sections
- QuizID (PK): INT
- SectionID (FK → CourseSection.SectionID): INT
- QuizName: NVARCHAR(100)
- PassRate: DECIMAL(5,2)
- QuizType: NVARCHAR(50)
- QuizDuration: INT
- QuizLevel: NVARCHAR(50)
- Status: BIT (0/1)
20	QuizAttempt	Description: Store each user’s quiz attempt
- AttemptID (PK): INT
- UserID (FK → Account.UserID): INT
- QuizID (FK → Quiz.QuizID): INT
- StartTime: DATETIME
- EndTime: DATETIME
- TotalScore: DECIMAL(5,2)
21	Question	Description: Store quiz questions
- QuestionID (PK): INT
- QuestionContent: NVARCHAR(MAX)
- QuestionType: INT
- QuestionLevel: INT
- Status: BIT (0/1)- CreatedBy (FK → Account.UserID): INT
- CreatedAt: DATETIME
- SubjectID (FK → Subject.SubjectID): INT
- LessonID (FK → Lesson.LessonID): INT
22	QuestionDimension	Description: Map questions to dimensions (M:N)
- QuestionID (PK, FK → Question.QuestionID): INT
- DimensionID (PK, FK → Dimension.DimensionID): INT
23	QuestionAnswer	Description: Store possible answers for questions
- AnswerID (PK): INT identity
- AnswerDetail: NVARCHAR(MAX)
- Explanation: NVARCHAR(MAX)
- IsCorrect: BIT (0/1)
- QuestionID (FK → Question.QuestionID): INT
24	QuestionMedia	Description: Store media for questions
- MediaID (PK): INT identity
- MediaURL: NVARCHAR(255)
- MediaType: INT- MediaDescription: NVARCHAR(255)
- QuestionID (FK → Question.QuestionID): INT
25	QuizQuestion	Description: Link questions into quizzes
- QuizQuestionID (PK): INT
- QuizID (FK → Quiz.QuizID): INT
- QuestionID (FK → Question.QuestionID): INT
- QuestionOrder: INT
- Points: DECIMAL(5,2)
26	UserAnswer	Description: Store user’s answers in a quiz attempt
- UserAnswerID (PK): INT
- AttemptID (FK → QuizAttempt.AttemptID): INT
- QuestionID (FK → Question.QuestionID): INT
- UserAnswerContent: NVARCHAR(MAX)
- IsCorrect: BIT (0/1)
27	Slider	Description: Store homepage sliders
- SliderID (PK): INT- UserID (FK → Account.UserID): INT
- CourseID (FK → Course.CourseID): INT
- Title: NVARCHAR(255)
- ImageURL: NVARCHAR(255)
- Backlink: NVARCHAR(255)
- Status: BIT (0/1)
- Notes: NVARCHAR(MAX)
- DisplayOrder: INT- ValidFrom: DATE


2.Header and Footer
2.2 Header


Field Name	Field Type	Description
Name Web	Text	The name web and information web..
Home	Text Button	The view home page.
Course	Text Button	The course list show page
Blog	Text Button	The blog introduce web
Login	Button	The screen Login
Logout	Button	User click when login success
Avatar	Image	The screen information

2.3 Footer




Field Name	Field Type	Description
About Online Course	Text	Text section about the site and its creator
Home	Text Button	The view home page.
Course	Text Button	The course list show page
About Us	Text Button	The introduce web
Connect with Us	Button 	The view information web
3. Code packages
3.1. Package diagram

3.2 Package Descriptions

Package	Main Functionality	Example Components
model	• Define Entities to pass data between layers.
• Contains no business logic, only properties and getters/setters.	Account.java, Course.java, Registration.java
view	• Contains interface files: .jsp, HTML, CSS, JS.
• Used to display data from the model via JSTL or EL.	home.jsp, login.jsp, userPages/, adminPages/
controller	• Receive request from view, parse parameter, call DAO, navigate to view.
• Handle simple logic, forward/redirect, set session/request.	LoginServlet, LessonController, SubjectDetailServlet
dao	• Handle database queries via JDBC.
• Only CRUD operations with models, no complex business processing.	UserDAO, SubjectDAO, RegistrationDAO
dal	• Provides a shared DBContext class for DAOs to connect to the database.	DBContext.java
util	• Utilities that can be reused throughout the project: sending emails, formatting data, logging, processing file uploads...	EmailUtil, StringUtil, FileHelper, DbUtil
validate	• Input validator.
Used in controller to check data before processing.	InputValidator

3.3 Third‑Party Libraries

Library	Version	Purpose	Notes
jakarta.servlet.jsp.jstl	3.0.0	JSP Standard Tag Library (JSTL)	For Tomcat 10+ / Jakarta EE 9+
jakarta.servlet.jsp.jstl-api	3.0.0	JSTL API interfaces	Required at compile time
jakarta.activation	2.0.1	JavaMail activation framework	Mail attachment handling
jakarta.mail	2.0.1	JavaMail API	Sending e‑mails from servlets
jaxb-api	2.1	XML binding (if you marshal/unmarshal XML)	Used by some web services
sqljdbc42.jar	(vendor’s)	Microsoft SQL Server JDBC driver	For database connectivity


