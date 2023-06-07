#import "template.typ": *

// 加载数据
#let data = toml("main.toml")

#let (name, email, phone, website, birthday) = data.cv;
#show: cv.with(
  name: name, 
  email: email, 
  phone: phone, 
  website: website, 
  birthday: birthday,
)

#educations(data.educations)
#projects(data.projects)
#internships(data.internships)
#awards(data.awards)
#skills(data.skills)