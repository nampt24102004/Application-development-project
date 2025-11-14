USE OLIT
GO

-- Thêm dữ liệu vào bảng Role
INSERT INTO Role (RoleID, RoleName) VALUES
(1, 'Admin'),
(2, 'Expert'),
(3, 'Student');

-- Thêm dữ liệu vào bảng Account
INSERT INTO Account (RoleID, FullName, Gender, Email, PhoneNumber, Password, URLAvatar, Status, Address, Birthday) VALUES
(2, N'Nguyễn Bảo Long', 'Male', 'longnbhe180858@fpt.edu.vn', '0123456789', '123', 'https://ss-images.saostar.vn/wp700/pc/1617160792140/saostar-j67dox5fxucodxyz.jpg', 'active', N'Hà Nội, Việt Nam', '1995-05-15'),
(2, N'Nguyễn Khải', 'Male', 'khainguyen25101998@gmail.com', '0987654321', '123', 'https://studiochupanhdep.com/Upload/Images/Album/anh-the-2023.jpg', 'active', N'Hồ Chí Minh, Việt Nam', '1988-08-20'),
(1, N'Phạm Tiến Nam', 'Male', 'nampthe181240@fpt.edu.vn', '0369852147', '123', 'https://chuphinhthe.com/upload/product/4709-tam-8496.jpg', 'active', N'Đà Nẵng, Việt Nam', '1990-12-03'),
(3, N'Phạm Thị Lan', 'Female', 'studen123@gmail.com', '0456789123', '123', 'https://faceinch.vn/upload/news/chup-anh-the-tha-toc-3007.jpg', 'active', N'Hải Phòng, Việt Nam', '2001-03-10'),
(3, N'Lê Minh Châu', 'Female', 'leminhchau01@gmail.com', '0911222333', '123', 'https://faceinch.vn/upload/news/chup-chan-dung-3-4662.jpg', 'active', N'Huế, Việt Nam', '2002-09-12'),
(3, N'Trần Anh Tú', 'Male', 'anh.tu@student.edu.vn', '0903444555', '123', 'https://bizweb.dktcdn.net/100/175/849/files/nhung-luu-y-khi-di-chup-anh-the-hoc-sinh-sinh-vien-1-016c9c22-e8bb-46fe-a6bb-69b81dcdd0c3.jpg?v=1720762597525', 'active', N'Quảng Nam, Việt Nam', '2000-07-08'),
(3, N'Huỳnh Gia Bảo', 'Male', 'giabao123@gmail.com', '0967888999', '123', 'https://smilemedia.vn/wp-content/uploads/2022/09/chup-hinh-the-dep-e1664379729855.jpg', 'active', N'TP.HCM, Việt Nam', '2003-02-21'),
(3, N'Vũ Thị Hạnh', 'Female', 'hanh.vt@gmail.com', '0935667788', '123', 'https://kamiidphoto.vn/wp-content/uploads/2025/04/top-9-tiem-chup-anh-the-dep-nhat-tp-thu-duc-907-7.jpg', 'active', N'Hà Nội, Việt Nam', '2001-11-30'),
(3, N'Đặng Quốc Duy', 'Male', 'duy.dang@studentmail.edu.vn', '0974332211', '123', 'https://bizweb.dktcdn.net/100/175/849/files/chup-anh-the-dep-cho-hoc-sinh-03.jpg?v=1609569926973', 'active', N'Cần Thơ, Việt Nam', '2002-04-05');

-- Thêm dữ liệu vào bảng PostCategory
INSERT INTO PostCategory (CategoryID, CategoryName, URL) VALUES
(1, N'Tin tức giáo dục', 'education-news'),
(2, N'Hướng dẫn học tập', 'study-guide'),
(3, N'Công nghệ', 'technology'),
(4, N'Kinh nghiệm học tập', 'learning-experience'),
(5, N'Sự kiện', 'events'),
(6, N'Lập trình', 'programming'),
(7, N'Thiết kế web', 'web-design'),
(8, N'Khởi nghiệp', 'startup'),
(9, N'Tài chính cá nhân', 'personal-finance'),
(10, N'Phát triển kỹ năng', 'skill-development'),
(11, N'Nghề nghiệp', 'career'),
(12, N'Đánh giá khóa học', 'course-review'),
(13, N'Thủ thuật học tập', 'study-tips'),
(14, N'Công cụ học tập', 'learning-tools'),
(15, N'Xu hướng IT', 'it-trends'),
(16, N'Phỏng vấn xin việc', 'job-interview'),
(17, N'Freelance', 'freelance'),
(18, N'Chứng chỉ IT', 'it-certification'),
(19, N'Học bổng', 'scholarship'),
(20, N'Kỹ năng mềm', 'soft-skills');

-- Thêm dữ liệu vào bảng Post
INSERT INTO Post 
  (PostID, UserID, CategoryID, BlogTitle, PostDetails, Status, UpdatedDate, ThumbnailURL, IsHot)
VALUES
(1, 1, 1, N'Xu hướng giáo dục trực tuyến 2024',
 N'Trong năm 2024, giáo dục trực tuyến tiếp tục bứt phá với nhiều xu hướng nổi bật:
- Cá nhân hóa học tập: Ứng dụng AI và phân tích dữ liệu giúp tùy chỉnh lộ trình, nội dung và tốc độ học phù hợp với từng học viên.
- Học tập kết hợp (Blended Learning): Kết hợp linh hoạt giữa các buổi học trực tiếp và trực tuyến, tận dụng ưu điểm của cả hai hình thức.
- Microlearning: Học theo các đoạn ngắn, tập trung vào từng kỹ năng cụ thể, dễ tiếp thu và phù hợp với nhịp sống bận rộn.
- Gamification: Áp dụng yếu tố trò chơi để tăng tính tương tác, động lực và trải nghiệm người học.
- Công nghệ thực tế ảo (VR/AR): Mang đến trải nghiệm thực hành sinh động, giúp học viên dễ hình dung và ghi nhớ kiến thức.',
 1, '2024-05-15 10:30:00', 'https://gitiho.com/caches/p_medium_large//uploads/315313/images/image_xu-huong-elearning-1.jpg', 1),

(2, 2, 2, N'5 mẹo học hiệu quả',
 N'Để tối ưu hóa hiệu suất học tập, bạn có thể áp dụng 5 phương pháp sau:
1. Pomodoro Technique: Chia thời gian học thành các phiên 25 phút, xen kẽ nghỉ 5 phút để duy trì sự tập trung.
2. Active Recall: Thường xuyên tự kiểm tra kiến thức bằng cách tóm tắt, đặt câu hỏi và trả lời mà không đọc lại tài liệu.
3. Spaced Repetition: Lặp lại nội dung theo khoảng cách thời gian tăng dần để chuyển kiến thức từ ngắn hạn sang dài hạn.
4. Mind Mapping: Vẽ sơ đồ tư duy để liên kết các khái niệm, giúp nhớ lâu và hiểu sâu hơn về mối quan hệ giữa các ý.
5. Teaching Others: Giải thích lại kiến thức cho bạn bè hoặc ghi lại video giảng dạy; việc này giúp bạn củng cố và phát hiện lỗ hổng kiến thức.',
 1, '2024-05-10 14:20:00', 'https://edubit.vn/data/blog/photo_1631782135.jpg?v=1631782136', 1),

(3, 3, 3, N'AI trong giáo dục',
 N'Trí tuệ nhân tạo (AI) đang được ứng dụng mạnh mẽ trong giáo dục với các giải pháp:
- Chatbot giảng dạy và hỗ trợ 24/7, trả lời câu hỏi và hướng dẫn học viên tức thì.
- Hệ thống đánh giá tự động: AI chấm điểm bài tập, đề xuất phản hồi cá nhân cho người học.
- Phân tích dữ liệu học tập: Xác định điểm mạnh, điểm yếu và đưa ra lộ trình ôn luyện tối ưu.
- Tạo nội dung động: AI có thể tự sinh đề ôn, bài tập và video giảng dựa trên nhu cầu từng học viên.
- Học tập tương tác: Ứng dụng VR/AR điều khiển AI giúp tạo môi trường học tập mô phỏng, tăng tính thực hành và trải nghiệm.',
 1, '2024-05-08 09:15:00', 'https://askany.com/_next/image?url=https%3A%2F%2Fd2czqxs5dso3qv.cloudfront.net%2Fimages%2Fb16fce83-f812-4b32-802d-7aac6fb27101.png&w=1920&q=75', 1),

(4, 2, 4, N'Kinh nghiệm thi chứng chỉ IT',
 N'Chia sẻ kinh nghiệm chuẩn bị và thi các chứng chỉ IT:
- Xác định chứng chỉ phù hợp: Microsoft, Cisco, CompTIA hay Oracle tùy mục tiêu nghề nghiệp.
- Lập kế hoạch học tập: chia nhỏ chủ đề, đặt deadline hàng tuần.
- Tài liệu tham khảo: sách chính thức, video hướng dẫn và khóa học online.
- Thực hành lab: cài đặt môi trường ảo, giải các bài tập mẫu.
- Thi thử: làm đề mẫu, phân tích đáp án để rút kinh nghiệm.
- Quản lý thời gian trong phòng thi: ưu tiên phần dễ ghi điểm trước.
- Mẹo vượt vũ môn: đọc kỹ hướng dẫn đề, không bỏ câu nào, dùng kỹ thuật loại trừ.',
 1, '2024-05-05 16:45:00', 'https://edusa.vn/wp-content/uploads/2023/11/cac-loai-chung-chi-tin-hoc-cho-sinh-vien-1.webp', 1),

(5, 1, 5, N'Sự kiện EdTech Vietnam 2024',
 N'Thông tin về hội thảo công nghệ giáo dục lớn nhất năm:
- Thời gian: 12–14/06/2024 tại TP. Hồ Chí Minh.
- Địa điểm: Trung tâm Hội nghị Quốc Gia, Q.7.
- Diễn giả: chuyên gia từ Google for Education, Microsoft Education, các startup và trường đại học.
- Chủ đề chính: AI trong giảng dạy, học tập cá nhân hóa, VR/AR trong đào tạo.
- Workshop kèm theo: thiết kế khóa học trực tuyến, phân tích dữ liệu học viên.
- Cách đăng ký: truy cập www.edtechvietnam.vn, nhận vé Early Bird trước 01/05.',
 1, '2024-05-01 11:00:00', 'https://vku.udn.vn/wp-content/uploads/2024/07/VKU-37-3.jpg', 1),

(6, 4, 1, N'10 xu hướng e-learning cho lập trình viên',
 N'Khám phá các công nghệ và phương pháp mới nhất giúp lập trình viên học tập hiệu quả hơn:
- Microlearning: bài học ngắn 5–10 phút, dễ theo dõi.
- Gamification: cấp độ, huy hiệu và bảng xếp hạng tăng tính hứng thú.
- Adaptive Learning: hệ thống tự điều chỉnh nội dung dựa trên kết quả.
- Mobile-first: học mọi lúc mọi nơi qua điện thoại.
- Podcasts & livestream: cập nhật kiến thức nhanh qua audio.
- AI Tutor: trợ lý ảo gợi ý tài liệu và giải đáp thắc mắc.
- Project-based: học qua làm dự án thực tế.
- Interactive Code Sandbox: luyện tập trực tiếp trên trình duyệt.
- VR Labs: mô phỏng môi trường lập trình động.
- Community Learning: học nhóm, pair programming và code review.',
 1, '2024-05-20 08:00:00', 'https://ocd.vn/wp-content/uploads/2025/03/How-to-Make-Friends-E-Learning-Presentation-1280-x-720-px-compressed.jpg', 0),

(7, 3, 2, N'Học Git và GitHub trong 1 ngày',
 N'Hướng dẫn nhanh các thao tác cơ bản và nâng cao với Git/GitHub, kèm ví dụ thực tế:
- Cài đặt Git và tạo tài khoản GitHub.
- Khởi tạo repo: git init, git clone.
- Làm việc với nhánh: git branch, git checkout, git merge.
- Commit & push: git add, git commit, git push.
- Quản lý xung đột merge và rebase.
- Tạo Pull Request trên GitHub.
- Sử dụng GitHub Actions để tự động hoá CI/CD.
- Viết file README, LICENSE và .gitignore chuẩn.',
 1, '2024-05-18 13:30:00', 'https://cdn.codegym.vn/wp-content/uploads/2021/12/khoa-hoc-nhap-mon-git-va-github-online-mien-phi-codegym-5.jpg', 0),

(8, 3, 3, N'Tự động hóa kiểm thử với Selenium',
 N'Hướng dẫn cài đặt, viết test case và chạy song song với Selenium WebDriver:
- Cài đặt Java, Maven/Gradle và thêm dependency Selenium.
- Download Driver (ChromeDriver, GeckoDriver) và cấu hình PATH.
- Tạo project mẫu: Page Object Model để tổ chức code.
- Viết test case: findElement, click, sendKeys, assertion.
- Sử dụng TestNG/JUnit để quản lý test suite.
- Chạy song song (parallel) với thread pool.
- Báo cáo kết quả: ExtentReports hoặc Allure.
- Tích hợp CI (Jenkins/GitHub Actions) để tự động chạy khi push code.',
 1, '2024-05-17 15:45:00', 'https://topdev.vn/blog/wp-content/uploads/2020/12/testing-1.jpg', 0),

(9, 2, 4, N'Chứng chỉ AWS Certified Cloud Practitioner',
 N'Chi tiết nội dung đề thi, kinh nghiệm ôn luyện và tài liệu tham khảo:
- Domains: Cloud Concepts, AWS Services, Security, Billing & Pricing.
- Tài liệu chính thức: AWS Whitepapers và FAQs.
- Khóa học miễn phí trên AWS Skill Builder.
- Thực hành: tạo tài khoản Free Tier, deploy EC2, S3, IAM.
- Đề thi thử: Tutorial Dojo, Whizlabs.
- Chiến lược làm bài: ưu tiên câu dễ, đọc kỹ dịch vụ trước khi trả lời.
- Lưu ý: cập nhật dịch vụ mới nhất trên console.',
 1, '2024-05-16 10:20:00', 'https://topdev.vn/blog/wp-content/uploads/2024/05/chung-chi-aws-la-gi-1.jpg', 0),

(10, 4, 5, N'Khoá học React.js miễn phí tháng 6/2024',
 N'Tổng hợp các khoá học, video và dự án mẫu để bạn bắt đầu với React.js:
- React Official Tutorial trên reactjs.org.
- FreeCodeCamp: full-course 8 giờ trên YouTube.
- Khóa “React Basics” của Codecademy.
- React Router: làm project Blog SPA.
- Hooks nâng cao: useReducer, useContext.
- Dự án mẫu: Todo App, Weather App, Chat App.
- Tài liệu: React Docs, CSS-in-JS với styled-components.
- Community: tham gia các nhóm trên Discord, StackOverflow.',
 1, '2024-05-22 09:15:00', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7X4unDFRGcQRqGGw2xhAn7W6CKbWTT9bKyg&s', 0
);



-- Thêm dữ liệu vào bảng Subject
INSERT INTO Subject (
    SubjectName, Category, OwnerID, FeaturedFlag, Status, Description
)
VALUES
  (N'Lập trình Java cơ bản', 
   N'Programming',    2, 1, 1, 
   N'Khóa học cung cấp kiến thức nền tảng về Java: cú pháp, biến, điều khiển luồng và lập trình hướng đối tượng.'),

  (N'Thiết kế cơ sở dữ liệu', 
   N'Database',       3, 1, 1, 
   N'Giới thiệu lý thuyết mô hình dữ liệu ER, chuẩn hóa, SQL cơ bản và cách tối ưu hoá hiệu năng truy vấn.'),

  (N'Phát triển Web Frontend', 
   N'Web Development',2, 1, 1, 
   N'Học HTML, CSS, JavaScript cơ bản và framework phổ biến để xây dựng giao diện web hiện đại và đáp ứng.'),

  (N'Marketing số', 
   N'Marketing',      3, 1, 1, 
   N'Khóa học khám phá các kênh digital marketing: SEO, SEM, email, mạng xã hội và phân tích dữ liệu chiến dịch.'),

  (N'Quản lý dự án IT', 
   N'Management',     2, 1, 1, 
   N'Nắm vững quy trình quản lý dự án phần mềm, SCRUM, Agile và kỹ năng lãnh đạo nhóm phát triển.');


-- Thêm dữ liệu vào bảng Dimension
INSERT INTO Dimension (DimensionID, SubjectID, DimensionName, Description) VALUES
(1, 1, N'Java Fundamentals', N'Cơ bản về cú pháp và cấu trúc Java'),
(2, 1, N'Object-Oriented Programming', N'Lập trình hướng đối tượng trong Java'),
(3, 2, N'Database Design', N'Thiết kế và chuẩn hóa cơ sở dữ liệu'),
(4, 2, N'SQL Queries', N'Viết và tối ưu hóa truy vấn SQL'),
(5, 3, N'React Components', N'Xây dựng và quản lý component trong React');

-- Thêm dữ liệu vào bảng ExpertSubject
INSERT INTO ExpertSubject (ExpertID, SubjectID) VALUES
(2, 1), -- Trần Thị Minh là Expert của Java
(3, 2), -- Lê Văn Hùng là Expert của Database
(2, 3); -- Trần Thị Minh là Expert của Web Frontend

-- Thêm dữ liệu vào bảng SubjectMedia
INSERT INTO SubjectMedia ( SubjectID, MediaURL, MediaType, MediaName) VALUES
( 1, 'https://example.com/java-intro.mp4', 'video', N'Video giới thiệu Java'),
( 2, 'https://example.com/database-diagram.png', 'image', N'Sơ đồ ERD mẫu'),
( 3, 'https://example.com/react-demo.mp4', 'video', N'Video demo React');

-- Thêm dữ liệu vào bảng Course
INSERT INTO Course 
(CourseID, SubjectID, CourseTitle, CourseTag, URLCourse, CourseDetail, CourseLevel, FeatureFlag, Status, CourseraDuration) VALUES
(1, 1, N'Nhập môn Java Programming', N'java,programming,beginner', 'https://i.ytimg.com/vi/ptOjDnsLOCc/mqdefault.jpg', N'Khóa học cơ bản về lập trình Java', N'Beginner', N'featured', 1, 40),
(2, 2, N'Thiết kế Database với MySQL', N'database,mysql,design', 'https://image.vietnix.vn/wp-content/uploads/2023/11/thiet-lap-co-so-du-lieu-tu-xa-voi-mysql-tren-ubuntu-20-04.png', N'Học cách thiết kế và tối ưu database', N'Intermediate', N'popular', 1, 30),
(3, 3, N'React.js cho người mới bắt đầu', N'react,javascript,frontend', 'https://cdn2.fptshop.com.vn/unsafe/1920x0/filters:format(webp):quality(75)/2023_12_28_638393296838948284_reactjs.jpg', N'Xây dựng ứng dụng web với React', N'Beginner', N'new', 1, 50),
(4, 4, N'Digital Marketing Strategy', N'marketing,digital,strategy', 'https://www.creationinfoways.com/blog/uploading/687193083.jpg', N'Chiến lược marketing số hiệu quả', N'Intermediate', N'trending', 1, 35),
(5, 5, N'Agile Project Management', N'agile,project,management', 'https://miro.medium.com/v2/resize:fit:1024/0*jlUybkZYz6yxWtdk.jpg', N'Quản lý dự án theo phương pháp Agile', N'Advanced', N'featured', 1, 25),
(6, 1, N'Python cho người mới bắt đầu', N'python,beginner,programming', 'https://s3-sgn09.fptcloud.com/codelearnstorage/files/thumbnails/python-cho-nguoi-moi-bat-dau_f1a0ae13118c411ab7068e248f9f0206.png', N'Lập trình Python từ cơ bản đến nâng cao', N'Beginner', N'popular', 1, 45),
(7, 2, N'Lập trình Web với Django', N'django,web,python', 'https://s3.icankid.io/icantech/cms/lap_trinh_web_django_7df5663f23.png', N'Xây dựng web app với Django Framework', N'Intermediate', N'featured', 1, 40),
(8, 3, N'UI/UX Design Cơ bản', N'design,ui,ux', 'https://vndigitech.com/wp-content/uploads/2024/03/nguyen-tac-thiet-ke-uiux-digitech-e1711471060658.webp', N'Hướng dẫn thiết kế giao diện người dùng', N'Beginner', N'new', 1, 35),
(9, 4, N'Phân tích dữ liệu với Excel', N'excel,data,analysis', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkrEWVMI81FoAsy5eo7eNzZ0BspQCP9OHf6A&s', N'Kỹ năng Excel nâng cao cho phân tích dữ liệu', N'Intermediate', N'popular', 1, 30),
(10, 5, N'Lập trình Android với Kotlin', N'android,kotlin,mobile', 'https://cdn-s.hoolacdn.com/daotaotester-18154-1fa76n8o6/sgp1/lib/image/banner-khlt-android_oZ7mnxq8oT7PtjBEo-original.png', N'Tạo ứng dụng Android bằng Kotlin', N'Intermediate', N'trending', 1, 50),
(11, 1, N'Java nâng cao: Spring Boot', N'java,spring,backend', 'https://techvccloud.mediacdn.vn/zoom/600_315/280518386289090560/2024/2/22/spring-boot-1708591158972430464422-0-0-500-890-crop-1708591162385231771559.jpg', N'Xây dựng API với Spring Boot', N'Advanced', N'featured', 1, 55),
(12, 2, N'Amazon Web Services (AWS) Cơ bản', N'aws,cloud,devops', 'https://api.careers.saigontechnology.com/storage/blogs/BLOG-HTQnbleYwWTiDLZpwL4fDnjmlNOFhrmdndPWCURk.webp', N'Làm quen với AWS và dịch vụ cloud', N'Beginner', N'new', 1, 30),
(13, 3, N'Machine Learning Cơ bản', N'ml,ai,python', 'https://vinuni.edu.vn/wp-content/uploads/2024/12/tim-hieu-machine-learning-co-ban-nhung-dieu-can-biet-cho-nguoi-moi-bat-dau-hinh-2.jpg', N'Giới thiệu Machine Learning và thuật toán', N'Intermediate', N'popular', 1, 60),
(14, 4, N'Training kỹ năng mềm cho lãnh đạo', N'softskills,leadership', 'https://hrcacademy.vn/uploads/anh-banner/thang-08/anh-dang-web/tong-quan.jpg', N'Kỹ năng giao tiếp và lãnh đạo hiệu quả', N'Advanced', N'trending', 1, 20),
(15, 5, N'Lập trình Node.js và Express', N'nodejs,express,backend', 'https://caodang.fpt.edu.vn/wp-content/uploads/a-9.png', N'Thiết kế backend với Node.js', N'Intermediate', N'featured', 1, 45);

--Thêm dữ liệu vào bảng CourseMedia
INSERT INTO CourseMedia (CourseID, MediaURL, MediaType)
VALUES
(1, 'https://i.ytimg.com/vi/ptOjDnsLOCc/mqdefault.jpg', 'image'),
(1, 'https://branium.pro/wp-content/uploads/2020/11/java-core-avatar.webp', 'image'),
(1, 'https://cdn.ngockhuong.com/wp-content/uploads/2017/06/get-started-with-java-programming.png', 'image'),
(1, 'https://youtu.be/Sb_cEAjHWOk?si=3ntUShyFHLxGrN_F', 'video'),

(2, 'https://image.vietnix.vn/wp-content/uploads/2023/11/thiet-lap-co-so-du-lieu-tu-xa-voi-mysql-tren-ubuntu-20-04.png', 'image'),
(2, 'https://bkhost.vn/wp-content/uploads/2022/07/mySql-workbench-1.jpg', 'image'),
(2, 'https://cloud-web-cms-beta.s3.cloud.cmctelecom.vn/cac_loai_data_base_602449a39f.jpeg', 'image'),
(2, 'https://youtu.be/bnW1forz4Sw?si=9H7dOxx8nfF1omNx', 'video'),

(3, 'https://cdn2.fptshop.com.vn/unsafe/1920x0/filters:format(webp):quality(75)/2023_12_28_638393296838948284_reactjs.jpg', 'image'),
(3, 'https://d1nzpkv5wwh1xf.cloudfront.net/640/k-577a160c047c994bb7e5b397/20190809-/zendvn04.png', 'image'),
(3, 'https://khoahocgiare.org/storage/product/reactjs-co-ban-den-nang-cao-1.jpg', 'image'),
(3, 'https://youtu.be/DJWCeD8h6EA?si=2fkKTAtvC8ySQ51N', 'video'),

(4, 'https://www.creationinfoways.com/blog/uploading/687193083.jpg', 'image'),
(4, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrZ9VDSXxlPQ2EbNy-9q6e-bbQACdZ4dVk1g&s', 'image'),
(4, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzkFeJTVpdqTMatKciNSb6Nuvi0y9c99PSeA&s', 'image'),
(4, 'https://youtu.be/wZZnxXyES80?si=AA71XvJlcvGA1G6d', 'video'),

(5, 'https://miro.medium.com/v2/resize:fit:1024/0*jlUybkZYz6yxWtdk.jpg', 'image'),
(5, 'https://media.geeksforgeeks.org/wp-content/uploads/20240422183950/Principles-of-Agile-Project-Management.webp', 'image'),
(5, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWqsyt06Tsj8JlfvV63Or_6QT8kNfK0TN6mw&s', 'image'),
(5, 'https://youtu.be/q3XnHCB7RNQ?si=hyEcrebAz2eSp_Hi', 'video'),

(6, 'https://s3-sgn09.fptcloud.com/codelearnstorage/files/thumbnails/python-cho-nguoi-moi-bat-dau_f1a0ae13118c411ab7068e248f9f0206.png', 'image'),
(6, 'https://msita.udn.vn/images/1728266685-850.png', 'image'),
(6, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPZlY20yTekLCsMyK5I-R613miI2BmD8Jctw&s', 'image'),
(6, 'https://youtu.be/8BDIkM6a7nE?si=nYPKDxqxngumXMDx', 'video'),

(11, 'https://techvccloud.mediacdn.vn/zoom/600_315/280518386289090560/2024/2/22/spring-boot-1708591158972430464422-0-0-500-890-crop-1708591162385231771559.jpg', 'image'),
(11, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQPhp2VEfo6ZCl561Il0VEqR8y-sENsSCONQ&s', 'image'),
(11, 'https://asia-1-fileserver-2.stringee.com/0/asia-1_1_TLNT9GX6H8ENYKZ/1695639037-Java_spring_boot_la_gi.png', 'image'),
(11, 'https://youtu.be/nqZy30G1wiA?si=qkpQuBhooVpJHpow', 'video'),

(12, 'https://api.careers.saigontechnology.com/storage/blogs/BLOG-HTQnbleYwWTiDLZpwL4fDnjmlNOFhrmdndPWCURk.webp', 'image'),
(12, 'https://cloud-web-cms-beta.s3.cloud.cmctelecom.vn/aws_faa694b58b.jpg', 'image'),
(12, 'https://cdn2.fptshop.com.vn/unsafe/1920x0/filters:format(webp):quality(75)/2023_12_27_638393105405931599_aws-la-gi-2.jpg', 'image'),
(12, 'https://youtu.be/dDajeR6l6UE?si=UI9ZnC5sVCJp4_tr', 'video'),

(13, 'https://vinuni.edu.vn/wp-content/uploads/2024/12/tim-hieu-machine-learning-co-ban-nhung-dieu-can-biet-cho-nguoi-moi-bat-dau-hinh-2.jpg', 'image'),
(13, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjD8ilgW7En1VfYhaAsZiJ3m68H3L4_jTgcA&s', 'image'),
(13, 'https://statics.cdn.200lab.io/2024/10/machine-learning-la-gi.jpeg', 'image'),
(13, 'https://youtu.be/2yFuforZegA?si=pGMkGmP8J99lPScA', 'video'),

(14, 'https://hrcacademy.vn/uploads/anh-banner/thang-08/anh-dang-web/tong-quan.jpg', 'image'),
(14, 'https://bondtnd.edu.vn/wp-content/uploads/2020/01/ky-nang-mem-la-gi-600x400.jpg', 'image'),
(14, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSd5UzGAae42aTTyqL_l2xhaqxg2S_5XzCxJA&s', 'image'),
(14, 'https://youtu.be/f5Q6RxAuos8?si=0nS_dcwfukls-xaW', 'video'),

(15, 'https://caodang.fpt.edu.vn/wp-content/uploads/a-9.png', 'image'),
(15, 'https://files.fullstack.edu.vn/f8-prod/courses/6.png', 'image'),
(15, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbSd9iLK6WvXyGT2L2P1x36yrhgQjLdjVANA&s', 'image'),
(15, 'https://youtu.be/5sLb_qUhXGs?si=9GMOcTEglpMbCHFO', 'video')
--Thêm dữ liệu vào bảng Review
INSERT INTO Review (ReviewID, UserID, CourseID, Content, Star, ImageURL) VALUES
(1, 4, 1, N'Khóa học Java rất hay và dễ hiểu.', 5, 'review-images/java1.jpg'),
(2, 4, 2, N'MySQL được giảng giải rõ ràng, dễ tiếp cận.', 4, 'review-images/mysql1.png'),
(3, 4, 3, N'React còn hơi khó với người mới, cần ví dụ thực tế hơn.', 3, 'review-images/react-feedback.jpg'),
(4, 1, 4, N'Nội dung marketing khá thực tế, áp dụng được.', 4, NULL),
(5, 2, 5, N'Mô hình Agile giúp tôi cải thiện quy trình làm việc rất nhiều.', 5, 'review-images/agile-review.png'),
(6, 3, 1, N'Khóa Java quá cơ bản, nên mở rộng thêm.', 3, NULL),
(7, 1, 3, N'Tôi thích cách truyền đạt của giảng viên React.', 4, 'review-images/react-teacher.jpg'),
(8, 2, 1, N'Khóa học khá ổn.', 5, NULL);

-- Thêm dữ liệu vào bảng PricePackage
INSERT INTO PricePackage (PackageID, CourseID, Name, AccessDuration, ListPrice, SalePrice, Status, Description) VALUES
(1, 1, N'Gói cơ bản', 30, 410000.00, 320000.00, 1, N'Truy cập khóa học trong 30 ngày'),
(2, 5, N'Gói mở rộng', 90, 980000.00, 870000.00, 1, N'Truy cập khóa học trong 90 ngày + tài liệu'),
(3, 2, N'Gói tiêu chuẩn', 60, 710000.00, 605000.00, 1, N'Truy cập khóa học trong 60 ngày'),
(4, 3, N'Gói cơ bản', 45, 445000.00, 355000.00, 1, N'Truy cập khóa học trong 45 ngày'),
(5, 4, N'Gói premium', 120, 1320000.00, 1110000.00, 1, N'Truy cập không giới hạn '),
(6, 6, N'Gói cơ bản', 30, 395000.00, 305000.00, 1, N'Truy cập khóa học trong 30 ngày'),
(7, 7, N'Gói mở rộng', 90, 970000.00, 860000.00, 1, N'Truy cập khóa học trong 90 ngày + tài liệu'),
(8, 8, N'Gói tiêu chuẩn', 60, 695000.00, 598000.00, 1, N'Truy cập khóa học trong 60 ngày'),
(9, 9, N'Gói cơ bản', 45, 460000.00, 340000.00, 1, N'Truy cập khóa học trong 45 ngày'),
(10, 10, N'Gói premium', 120, 1285000.00, 1090000.00, 1, N'Truy cập không giới hạn '),
(11, 12, N'Gói cơ bản', 30, 405000.00, 310000.00, 1, N'Truy cập khóa học trong 30 ngày'),
(12, 11, N'Gói mở rộng', 90, 990000.00, 875000.00, 1, N'Truy cập khóa học trong 90 ngày + tài liệu'),
(13, 14, N'Gói tiêu chuẩn', 60, 725000.00, 615000.00, 1, N'Truy cập khóa học trong 60 ngày'),
(14, 13, N'Gói cơ bản', 45, 435000.00, 345000.00, 1, N'Truy cập khóa học trong 45 ngày'),
(15, 15, N'Gói premium', 120, 1310000.00, 1105000.00, 1, N'Truy cập không giới hạn');

-- Thêm dữ liệu vào bảng Registration
INSERT INTO Registration (RegistrationID, UserID, CourseID, PackageID, ApprovedBy, Status, ValidFrom, ValidTo) VALUES
(1, 1, 1, 1, 1, 'Approved', '2024-05-31', '2024-05-01'),
(2, 2, 2, 3, 1, 'Approved', '2024-07-04', '2024-05-05'),
(3, 4, 3, 4, 1, 'Approved', '2024-06-24', '2024-05-10'),
(4, 4, 4, 5, 1, 'NotApproved', '2024-09-12', '2024-05-15'),
(5, 2, 1, 2, 1, 'Approved', '2025-07-24', '2025-07-26'),
(6, 1, 1, 1, 1, 'Approved', '2025-07-24', '2025-07-26'),
(7, 2, 2, 2, 1, 'Approved', '2025-07-25', '2025-07-26'),
(8, 3, 1, 1, 1, 'Approved', '2025-07-25', '2025-07-26'),
(9, 4, 2, 2, 1, 'Approved', '2025-07-26', '2025-07-26'),
(10, 2, 2, 3, 1, 'Approved', '2025-07-26', '2025-07-26'),
(11, 1, 1, 1, 1, 'Approved', '2025-07-27', '2025-07-26'),
(12, 2, 2, 2, 1, 'Approved', '2025-07-27', '2025-07-26'),
(13, 4, 5, 1, 1, 'NotApproved', '2025-07-28', '2025-07-26'),
(14, 2, 2, 3, 1, 'Approved', '2025-07-29', '2025-07-26');

-- Thêm dữ liệu vào bảng CourseSection
INSERT INTO CourseSection (SectionID, CourseID, SectionTitle) VALUES
(1, 1, N'Section 1: Tổng quan dự án'),
(2, 1, N'Section 2: Cơ bản về Java'),
(3, 1, N'Section 3: Ứng dụng thực tế'),
(4, 2, N'Section 1: Thiết kế cơ bản'),
(5, 2, N'Section 2: Quan hệ và chuẩn hóa'),
(6, 2, N'Section 3: Thực hành nâng cao'),
(7, 3, N'Section 1: Làm quen với React'),
(8, 3, N'Section 2: Component và Props'),
(9, 3, N'Section 3: State và vòng đời'),
(10, 4, N'Section 1: Tổng quan Digital Marketing'),
(11, 4, N'Section 2: Các kênh phổ biến'),
(12, 4, N'Section 3: Phân tích chiến dịch'),
(13, 5, N'Section 1: Tổng quan Agile'),
(14, 5, N'Section 2: Scrum Framework'),
(15, 5, N'Section 3: Agile trong thực tiễn');

-- Thêm dữ liệu vào bảng SectionModule
INSERT INTO SectionModule (ModuleID, SectionID, ModuleTitle) VALUES
(1, 1, N'Module 1: Giới thiệu & Mở đầu'),
(2, 1, N'Module 2: Mục tiêu học tập'),
(3, 2, N'Module 1: Cấu trúc chương trình Java'),
(4, 2, N'Module 2: Biến và kiểu dữ liệu'),
(5, 2, N'Module 3: Câu lệnh điều kiện'),
(6, 3, N'Module 1: Viết ứng dụng Console'),
(7, 3, N'Module 2: Đọc ghi file'),
(8, 4, N'Module 1: Giới thiệu về MySQL'),
(9, 4, N'Module 2: Cài đặt và cấu hình'),
(10, 5, N'Module 1: Thiết kế bảng'),
(11, 5, N'Module 2: Mối quan hệ giữa bảng'),
(12, 6, N'Module 1: Truy vấn nâng cao'),
(13, 7, N'Module 1: React là gì?'),
(14, 7, N'Module 2: Cài đặt môi trường'),
(15, 8, N'Module 1: Component cơ bản'),
(16, 8, N'Module 2: Props và Event'),
(17, 9, N'Module 1: State và useState'),
(18, 9, N'Module 2: Vòng đời component'),
(19, 10, N'Module 1: Marketing truyền thống vs số'),
(20, 10, N'Module 2: Xu hướng hiện tại'),
(21, 11, N'Module 1: SEO và SEM'),
(22, 11, N'Module 2: Social Media Marketing'),
(23, 12, N'Module 1: Đánh giá hiệu quả'),
(24, 13, N'Module 1: Nguyên lý Agile'),
(25, 13, N'Module 2: Agile Manifesto'),
(26, 14, N'Module 1: Scrum Roles'),
(27, 14, N'Module 2: Scrum Events'),
(28, 15, N'Module 1: Triển khai Agile'),
(29, 15, N'Module 2: Công cụ hỗ trợ');

-- Thêm dữ liệu vào bảng Lesson
INSERT INTO Lesson (LessonID, ModuleID, LessonTitle, LessonDetails, Status, URLLesson, [Order]) VALUES
(1, 1, N'Bài 1: Giới thiệu khóa học', N'Giới thiệu tổng quan về khóa học Java', 1, 'https://www.youtube.com/watch?v=3gtOAlcovoQ&list=PL33lvabfss1yGrOutFR03OZoqm91TSsvs', 1),
(2, 1, N'Bài 2: Mục tiêu học tập', N'Những điều bạn sẽ học được sau khóa học', 1, 'https://www.youtube.com/watch?v=pTB0EiLXUC8', 2),
(3, 2, N'Bài 1: Hướng dẫn học hiệu quả', N'Cách tận dụng khóa học tối đa', 1, 'https://www.youtube.com/watch?v=T2MCd1Pyho4', 1),
(4, 2, N'Bài 2: Kế hoạch học tập', N'Hướng dẫn lập kế hoạch học tập hiệu quả', 1, 'https://www.youtube.com/watch?v=3gtOAlcovoQ', 2),
(5, 2, N'Bài 3: Tài nguyên hỗ trợ', N'Tổng hợp tài liệu và công cụ học Java', 1, '/lesson-resources/java/Module2_Bai3.html', 3),
(6, 3, N'Bài 1: Hàm main và cú pháp cơ bản', N'Giới thiệu hàm main()', 1, 'https://www.youtube.com/watch?v=grEKMHGYyns', 1),
(7, 3, N'Bài 2: Tệp .java và .class', N'Cách chương trình Java được biên dịch', 1, 'https://www.youtube.com/watch?v=5Srjptsbd4Y', 2),
(8, 4, N'Bài 1: Kiểu dữ liệu cơ bản', N'int, float, String...', 1, 'https://www.youtube.com/watch?v=cgp5ulbsdJ0', 1),
(9, 4, N'Bài 2: Khai báo và gán giá trị', N'Kỹ thuật khai báo biến', 1, 'https://www.youtube.com/watch?v=N6aWNLVoh1g', 2),
(10, 4, N'Bài 3: Biến hằng số', N'Sử dụng final trong Java', 1, 'https://www.youtube.com/watch?v=mPCuI972gSA', 3),
(11, 5, N'Bài 1: if/else', N'Cấu trúc điều kiện trong Java', 1, 'https://www.youtube.com/watch?v=y4rSZ-5HCho', 1),
(12, 5, N'Bài 2: switch/case', N'Sử dụng switch để tối ưu code', 1, 'https://www.youtube.com/watch?v=Om3qzMoaIUo', 2),
(13, 6, N'Bài 1: In ra màn hình', N'Dùng System.out.print()', 1, 'https://www.youtube.com/watch?v=t_sKbkJaFso', 1),
(14, 6, N'Bài 2: Nhập từ bàn phím', N'Scanner class', 1, 'https://www.youtube.com/watch?v=ODZMrStNjyU', 2),
(15, 7, N'Bài 1: FileWriter và FileReader', N'Đọc ghi file văn bản đơn giản', 1, 'https://www.youtube.com/watch?v=xvSLLXyBm9Q', 1),
(16, 7, N'Bài 2: BufferedReader và BufferedWriter', N'Cách dùng BufferedReader/BufferedWriter để đọc ghi file nhanh', 1, 'https://www.youtube.com/watch?v=dE4jYQ4oKao', 2),
(17, 7, N'Bài 3: Xử lý File CSV', N'Hướng dẫn đọc/viết định dạng CSV trong Java', 1, '/lesson-resources/java/Lesson17.html', 3),
(18, 8, N'Bài 1: Lịch sử và ứng dụng của MySQL', N'Tại sao MySQL phổ biến', 1, 'https://www.youtube.com/watch?v=7S_tz1z_5bA', 1),
(19, 8, N'Bài 2: Ưu điểm và Nhược điểm của MySQL', N'Phân tích ưu và nhược điểm khi sử dụng MySQL', 1, 'https://www.youtube.com/watch?v=Ke90Tje7VS0', 2),
(20, 8, N'Bài 3: Tối ưu truy vấn', N'Kỹ thuật tối ưu câu lệnh SELECT và Indexing', 1, 'http://localhost:8080/G3_SWP/userPages/mysql/1-3.html', 3),
(21, 9, N'Bài 1: Cài đặt trên Windows', N'Tải về và cài đặt MySQL', 1, 'https://www.youtube.com/watch?v=7kEp8o4Y30E', 1),
(22, 9, N'Bài 2: Cấu hình ban đầu', N'Tạo user, cấp quyền', 1, 'https://www.youtube.com/watch?v=3yYrpBS_fcc', 2),
(23, 10, N'Bài 1: Các kiểu dữ liệu phổ biến', N'VARCHAR, INT, DATE...', 1, 'https://www.youtube.com/watch?v=9ylj9NR0Lcg', 1),
(24, 10, N'Bài 2: Ràng buộc bảng (Constraints)', N'Tìm hiểu các loại ràng buộc: PRIMARY, UNIQUE, CHECK,…', 1, 'https://www.youtube.com/watch?v=ENrzD9HAZK4', 2),
(25, 10, N'Bài 3: Thiết kế ERD cơ bản', N'Hướng dẫn vẽ sơ đồ quan hệ thực thể với ERD tool', 1, 'https://www.tutorialspoint.com/erd/erd_overview.html', 3),
(26, 11, N'Bài 1: Primary Key & Foreign Key', N'Tạo mối quan hệ giữa bảng', 1, 'https://www.youtube.com/watch?v=1tI5Kb_C1Mw', 1),
(27, 11, N'Bài 2: Cascade và JOIN', N'Áp dụng cascade khi xoá/sửa khoá và cách dùng JOIN nâng cao', 1, 'https://www.youtube.com/watch?v=I6ypD7qv3Z8', 2),
(28, 11, N'Bài 3: Transactions và Locking', N'Quản lý transaction và locking trong MySQL', 1, 'http://localhost:8080/G3_SWP/userPages/mysql/5-3.html', 3),
(29, 12, N'Bài 1: JOIN các bảng', N'LEFT JOIN, INNER JOIN...', 1, 'https://www.youtube.com/watch?v=9yeOJ0ZMUYw', 1),
(30, 12, N'Bài 2: Subquery', N'Sử dụng lồng câu truy vấn', 1, 'https://www.youtube.com/watch?v=2KmfA86Dpmk', 2),
(31, 12, N'Bài 3: Stored Procedures', N'Viết và gọi Stored Procedure trong MySQL', 1, 'http://localhost:8080/G3_SWP/userPages/mysql/7-3.html', 3),
(32, 13, N'Bài 1: Giới thiệu ReactJS', N'Lịch sử và ưu điểm của React', 1, 'https://www.youtube.com/watch?v=Ke90Tje7VS0', 1),
(33, 13, N'Bài 2: Virtual DOM và JSX', N'Giải thích cơ chế Virtual DOM và cách viết JSX trong React', 1, 'https://www.youtube.com/watch?v=Ke90Tje7VS0', 2),
(34, 13, N'Bài 3: Thiết lập React Router', N'Cấu hình điều hướng SPA với React Router', 1, 'https://www.tutorialspoint.com/reactjs/reactjs_router.html', 3),
(35, 14, N'Bài 1: Cài đặt NodeJS & npm', N'Thiết lập môi trường cho React', 1, 'https://www.youtube.com/watch?v=ENrzD9HAZK4', 1),
(36, 14, N'Bài 2: Thiết lập IDE và Extension', N'Hướng dẫn cấu hình VSCode/WebStorm, cài extension cần thiết', 1, 'https://www.youtube.com/watch?v=ENrzD9HAZK4', 2),
(37, 14, N'Bài 3: Tích hợp ESLint & Prettier', N'Cấu hình linting và định dạng code tự động', 1, 'https://www.digitalocean.com/community/tutorials/js-eslint-prettier', 3),
(38, 15, N'Bài 1: Tạo component đầu tiên', N'Dùng function component', 1, 'https://www.youtube.com/watch?v=I6ypD7qv3Z8', 1),
(39, 15, N'Bài 2: Props là gì?', N'Truyền dữ liệu giữa component', 1, 'https://www.youtube.com/watch?v=0mYOSjWc0-M', 2),
(40, 16, N'Bài 1: Xử lý sự kiện', N'onClick, onChange...', 1, 'https://www.youtube.com/watch?v=dd7XkO8YM98', 1),
(41, 16, N'Bài 2: Truyền Props nâng cao', N'Kỹ thuật truyền Props sâu và validate với PropTypes', 1, 'https://www.youtube.com/watch?v=I6ypD7qv3Z8', 2),
(42, 16, N'Bài 3: Context API cơ bản', N'Sử dụng Context để chia sẻ state toàn ứng dụng', 1, 'https://reactjs.org/docs/context.html', 3),
(43, 17, N'Bài 1: useState Hook', N'Tạo state trong function component', 1, 'https://www.youtube.com/watch?v=O6P86uwfdR0', 1),
(44, 17, N'Bài 2: Quản lý state với nhiều biến', N'Kỹ thuật tách state thành nhiều biến con hiệu quả', 1, 'https://www.youtube.com/watch?v=9ylj9NR0Lcg', 2),
(45, 17, N'Bài 3: useReducer Hook', N'Sử dụng useReducer để quản lý state phức tạp', 1, 'https://reactjs.org/docs/hooks-reference.html#usereducer', 3),
(46, 18, N'Bài 1: useEffect Hook', N'Thực hiện hành động khi render', 1, 'https://www.youtube.com/watch?v=0ZJgIjIuY7U', 1),
(47, 19, N'Bài 1: So sánh mô hình cũ và mới', N'Phân biệt hai phương pháp', 1, 'https://www.youtube.com/watch?v=YQGzXHUSOY8', 1),
(48, 20, N'Bài 1: Marketing trên TikTok', N'Chiến lược nội dung video ngắn', 1, 'https://www.youtube.com/watch?v=rEgN4vycvTY', 1),
(49, 21, N'Bài 1: Tối ưu hóa từ khóa', N'Cách SEO giúp tăng traffic', 1, 'https://www.youtube.com/watch?v=hF515-0Tduk', 1),
(50, 22, N'Bài 1: Facebook Ads cơ bản', N'Chạy quảng cáo trên Facebook', 1, 'https://www.youtube.com/watch?v=Kc5Y1l-rsaw', 1),
(51, 23, N'Bài 1: Chỉ số đo lường ROI', N'Cách xác định hiệu quả chiến dịch', 1, 'https://www.youtube.com/watch?v=lEEW5Ma_cJs', 1),
(52, 24, N'Bài 1: Agile Manifesto', N'4 giá trị cốt lõi của Agile', 1, 'https://www.youtube.com/watch?v=Z9QbYZh1YXY', 1),
(53, 25, N'Bài 1: Các nguyên lý Agile', N'12 nguyên lý trong Agile Manifesto', 1, 'https://www.youtube.com/watch?v=doqYY2xCXWU', 1),
(54, 26, N'Bài 1: Product Owner', N'Trách nhiệm và vai trò', 1, 'https://www.youtube.com/watch?v=6x1A8K8UHoe', 1),
(55, 26, N'Bài 2: Scrum Master', N'Đảm bảo quy trình Scrum vận hành tốt', 1, 'https://www.youtube.com/watch?v=UeQHdQ7U5RM', 2),
(56, 27, N'Bài 1: Sprint Planning', N'Lên kế hoạch cho Sprint', 1, 'https://www.youtube.com/watch?v=zaxPG4uDfr4', 1),
(57, 28, N'Bài 1: Agile tại doanh nghiệp', N'Ví dụ triển khai thực tế', 1, 'https://www.youtube.com/watch?v=3HZWxsxaYNc', 1),
(58, 29, N'Bài 1: Sử dụng Jira', N'Theo dõi tiến độ trong Agile', 1, 'https://www.youtube.com/watch?v=EOTXYa8qgJ0', 1);

-- Thêm dữ liệu vào bảng Quiz
INSERT INTO Quiz (QuizID, SectionID, QuizName, PassRate, QuizType, QuizDuration, QuizLevel, Status) VALUES
(1, 1, N'Kiểm tra Java cơ bản', 70.00, N'Multiple Choice', 30, N'Beginner', 1),
(2, 4, N'Quiz thiết kế Database', 75.00, N'Mixed', 45, N'Intermediate', 1),
(3, 7, N'React Fundamentals Test', 65.00, N'Multiple Choice', 25, N'Beginner', 1),
(4, 10, N'Digital Marketing Quiz', 80.00, N'True/False', 20, N'Intermediate', 1),
(5, 13, N'Agile Methodology Test', 85.00, N'Mixed', 40, N'Advanced', 1);

-- Thêm dữ liệu vào bảng Question
INSERT INTO Question (QuestionContent, QuestionType, Status, QuestionLevel, CreatedBy, CreatedAt, SubjectID, LessonID) VALUES
(N'Java là ngôn ngữ lập trình thuộc loại nào?', 1, 1, 1, 2, GETDATE(), 1, 1),
(N'Khóa chính (Primary Key) trong database có tác dụng gì?', 1, 1, 1, 3, GETDATE(), 2, 2),
(N'JSX là gì trong React?', 1, 1, 1, 2, GETDATE(), 3, 3),
(N'SEO viết tắt của từ nào?', 1, 1, 1, 3, GETDATE(), 4, 4),
(N'Scrum là một framework của phương pháp nào?', 1, 1, 2, 2, GETDATE(), 5, 5),
(N'Trong Java, từ khóa "static" có ý nghĩa gì?', 1, 1, 2, 2, GETDATE(), 1, 6),
(N'Chuẩn hóa database (Database Normalization) là gì?', 1, 1, 2, 3, GETDATE(), 2, 7),
(N'Thẻ div trong HTML dùng để làm gì?', 1, 1, 1, 2, GETDATE(), 3, 8),
(N'CSS box model bao gồm những thành phần nào?', 1, 1, 1, 3, GETDATE(), 3, 9),
(N'API là viết tắt của từ gì?', 1, 1, 1, 2, GETDATE(), 1, 10),
(N'Cú pháp khai báo biến trong JavaScript là gì?', 1, 1, 1, 3, GETDATE(), 3, 11),
(N'Phương thức GET và POST trong HTTP khác nhau như thế nào?', 1, 1, 2, 2, GETDATE(), 4, 12),
(N'Làm thế nào để tạo một class trong Python?', 1, 1, 1, 3, GETDATE(), 5, 13),
(N'SQL Injection là loại tấn công gì?', 1, 1, 2, 2, GETDATE(), 2, 14),
(N'Mô hình MVC trong phát triển web có ý nghĩa gì?', 1, 1, 2, 3, GETDATE(), 1, 15),
(N'Docker là gì và nó dùng để làm gì?', 1, 1, 2, 2, GETDATE(), 5, 16),
(N'HTTPS an toàn hơn HTTP ở điểm nào?', 1, 1, 1, 3, GETDATE(), 4, 17),
(N'Big O notation dùng để làm gì trong giải thuật?', 1, 1, 3, 2, GETDATE(), 1, 18),
(N'Thế nào là polymorphism trong OOP?', 1, 1, 2, 3, GETDATE(), 1, 19),
(N'Sự khác biệt giữa INNER JOIN và LEFT JOIN trong SQL?', 1, 1, 2, 2, GETDATE(), 2, 20),
(N'Callback function trong JavaScript là gì?', 1, 1, 2, 3, GETDATE(), 3, 21),
(N'Microservices architecture là gì?', 1, 1, 3, 2, GETDATE(), 5, 22),
(N'CI/CD là viết tắt của gì trong DevOps?', 1, 1, 2, 3, GETDATE(), 5, 23),
(N'Hashing và Encryption khác nhau như thế nào?', 1, 1, 3, 2, GETDATE(), 4, 24),
(N'Ưu điểm của sử dụng Git là gì?', 1, 1, 1, 3, GETDATE(), 5, 25),
(N'Mô hình OSI có bao nhiêu tầng?', 1, 1, 2, 2, GETDATE(), 4, 26),
(N'Cache là gì và lợi ích của nó?', 1, 1, 2, 3, GETDATE(), 1, 27);

-- Thêm dữ liệu vào bảng QuestionDimension
INSERT INTO QuestionDimension (QuestionID, DimensionID) VALUES
(1, 1), 
(1, 2),
(3, 1),
(4, 2), 
(5, 2), 
(6, 3), 
(7, 4); 

-- Thêm dữ liệu vào bảng QuestionAnswer
INSERT INTO QuestionAnswer (AnswerDetail, Explanation, IsCorrect, QuestionID) VALUES
(N'Ngôn ngữ lập trình hướng đối tượng', N'Java là ngôn ngữ lập trình hướng đối tượng, hỗ trợ các khái niệm như kế thừa, đóng gói, đa hình.', 1, 1),
(N'Ngôn ngữ lập trình thủ tục', N'Không đúng, Java không phải là ngôn ngữ lập trình thủ tục như C.', 0, 1),
(N'Ngôn ngữ lập trình hàm', N'Không đúng, Java không phải là ngôn ngữ lập trình hàm thuần túy.', 0, 1),
(N'Ngôn ngữ assembly', N'Không đúng, Java là ngôn ngữ cấp cao, không phải ngôn ngữ assembly.', 0, 1),
(N'Định danh duy nhất cho mỗi bản ghi trong bảng', N'Khóa chính đảm bảo mỗi bản ghi trong bảng có một định danh duy nhất.', 1, 2),
(N'Tăng tốc độ truy vấn dữ liệu', N'Không đúng, khóa chính không trực tiếp tăng tốc độ truy vấn, nhưng có thể hỗ trợ thông qua chỉ mục.', 0, 2),
(N'Mã hóa dữ liệu trong bảng', N'Không đúng, khóa chính không liên quan đến mã hóa dữ liệu.', 0, 2),
(N'Sao lưu dữ liệu tự động', N'Không đúng, khóa chính không liên quan đến sao lưu dữ liệu.', 0, 2),
(N'JavaScript XML - cú pháp mở rộng cho JavaScript', N'JSX là cú pháp mở rộng cho JavaScript, cho phép viết HTML trong React.', 1, 3),
(N'Java Syntax Extension', N'Không đúng, JSX không liên quan đến Java.', 0, 3),
(N'JSON eXtended', N'Không đúng, JSX không phải là JSON.', 0, 3),
(N'JavaScript eXecutable', N'Không đúng, JSX không phải là JavaScript thực thi.', 0, 3),
(N'Search Engine Optimization', N'SEO là kỹ thuật tối ưu hóa công cụ tìm kiếm để tăng thứ hạng website.', 1, 4),
(N'System Engineering Operations', N'Không đúng, SEO không liên quan đến kỹ thuật hệ thống.', 0, 4),
(N'Software Engineering Organization', N'Không đúng, SEO không liên quan đến tổ chức kỹ thuật phần mềm.', 0, 4),
(N'Security Enhancement Options', N'Không đúng, SEO không liên quan đến bảo mật.', 0, 4),
(N'Agile methodology', N'Scrum là một framework thuộc phương pháp Agile, tập trung vào phát triển lặp đi lặp lại.', 1, 5),
(N'Waterfall methodology', N'Không đúng, Scrum không thuộc mô hình Waterfall.', 0, 5),
(N'DevOps methodology', N'Không đúng, Scrum không phải là một phần của DevOps.', 0, 5),
(N'Lean methodology', N'Không đúng, mặc dù Lean và Agile có một số điểm tương đồng, Scrum thuộc Agile.', 0, 5),
(N'Thuộc về lớp chứ không thuộc về đối tượng cụ thể', N'Từ khóa static trong Java chỉ định rằng một thành viên thuộc về lớp, không cần tạo đối tượng.', 1, 6),
(N'Biến không thể thay đổi giá trị', N'Không đúng, đó là từ khóa final, không phải static.', 0, 6),
(N'Phương thức chỉ có thể gọi một lần', N'Không đúng, static không giới hạn số lần gọi phương thức.', 0, 6),
(N'Biến được khởi tạo tự động', N'Không đúng, static không tự động khởi tạo biến.', 0, 6),
(N'Quá trình tổ chức dữ liệu để giảm thiểu redundancy', N'Chuẩn hóa database giúp loại bỏ dư thừa dữ liệu và đảm bảo tính nhất quán.', 1, 7),
(N'Quá trình tăng tốc độ truy vấn database', N'Không đúng, chuẩn hóa không trực tiếp tăng tốc độ truy vấn.', 0, 7),
(N'Quá trình mã hóa dữ liệu trong database', N'Không đúng, chuẩn hóa không liên quan đến mã hóa.', 0, 7),
(N'Quá trình sao lưu database định kỳ', N'Không đúng, chuẩn hóa không liên quan đến sao lưu.', 0, 7);

-- Thêm dữ liệu vào bảng QuestionMedia
INSERT INTO QuestionMedia (MediaURL,MediaType,MediaDescription, QuestionID) VALUES
('Screenshot 2025-07-02 000231.png', 1, N'Test image', 1),
('2637-161442811_tiny.mp4', 2, N'Test video', 1),
('131442-750559816_tiny.mp4', 2, N'Test video', 1),
('Recording_147.m4a', 2, N'Test audio', 1);

-- Thêm dữ liệu vào bảng QuizQuestion
INSERT INTO QuizQuestion (QuizQuestionID, QuizID, QuestionID, QuestionOrder, Points) VALUES
(1, 1, 1, 1, 2.0),
(2, 1, 6, 2, 3.0),
(3, 2, 2, 1, 2.5),
(4, 2, 7, 2, 3.5),
(5, 3, 3, 1, 2.0),
(6, 4, 4, 1, 2.0),
(7, 5, 5, 1, 4.0);

-- Thêm dữ liệu vào bảng QuizAttempt
INSERT INTO QuizAttempt (AttemptID, UserID, QuizID, StartTime, EndTime, TotalScore) VALUES
(1, 4, 1, '2024-05-15 10:00:00', '2024-05-15 10:25:00', 4.0),
(2, 4, 2, '2024-05-16 14:30:00', '2024-05-16 15:10:00', 5.5),
(3, 4, 3, '2024-05-17 09:00:00', '2024-05-17 09:20:00', 2.0),
(4, 4, 4, '2024-05-18 16:00:00', '2024-05-18 16:15:00', 2.0),
(5, 4, 1, '2024-05-19 11:30:00', '2024-05-19 11:55:00', 3.5);

-- Thêm dữ liệu vào bảng UserAnswer
INSERT INTO UserAnswer (UserAnswerID, QuestionID, AttemptID, UserAnswerContent, IsCorrect) VALUES
(1, 1, 1, N'Ngôn ngữ lập trình hướng đối tượng', 1),
(2, 6, 1, N'Thuộc về lớp chứ không thuộc về đối tượng cụ thể', 1),
(3, 2, 2, N'Định danh duy nhất cho mỗi bản ghi trong bảng', 1),
(4, 7, 2, N'Quá trình tổ chức dữ liệu để giảm thiểu redundancy', 1),
(5, 3, 3, N'JavaScript XML - cú pháp mở rộng cho JavaScript', 1),
(6, 4, 4, N'Search Engine Optimization', 1),
(7, 5, 5, N'Agile methodology', 1);

-- Thêm dữ liệu vào bảng Setting
INSERT INTO Setting (SettingID, UserID, SettingType, SettingValue, SettingOrder, SettingDecription, SettingStatus) VALUES
(1, 1, N'System', N'Online Learning Platform', 1, N'Tên hệ thống', 1),
(2, 1, N'Email', N'admin@olit.edu.vn', 2, N'Email hệ thống', 1),
(3, 1, N'Theme', N'Blue', 3, N'Màu chủ đạo giao diện', 1),
(4, 1, N'Language', N'Vietnamese', 4, N'Ngôn ngữ mặc định', 1),
(5, 1, N'Timezone', N'Asia/Ho_Chi_Minh', 5, N'Múi giờ hệ thống', 1);

-- Thêm dữ liệu vào bảng Slider
INSERT INTO Slider (SliderID, UserID, CourseID, Title, ImageURL, Backlink, Status, Notes, DisplayOrder, ValidFrom) VALUES
(1, 1, 1, N'Khóa học Java mới', 'https://aptech.fpt.edu.vn/wp-content/uploads/2022/06/java-la-ngon-ngu-lap-trinh-rat-da-dung.jpg', '/course/java-basic', 1, N'Slider quảng cáo khóa Java', 1, '2024-05-01'),
(2, 1, 2, N'Ưu đãi 50% khóa Database', 'https://vtiacademy.edu.vn/upload/images/data-analyst-26.png', '/course/database-design', 1, N'Slider khuyến mãi', 2, '2024-05-05'),
(3, 1, 3, N'Khai giảng React Course', 'https://vtiacademy.edu.vn/upload/images/artboard-1-copy-16-100.jpg', '/course/react-beginners', 1, N'Thông báo khai giảng', 3, '2024-05-10');


