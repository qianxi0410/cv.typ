// url预处理
#let url(url) = {
  let prefix = regex("http[s]?://")

  // url必须以http:// 或 https://开头
  if not url.starts-with(prefix) {
    panic("url must start with http:// or https://")
  }

  url = url.replace(prefix, "")
  // 去掉末尾的/
  if url.ends-with("/") {
    url = url.slice(0, url.len() - 1)
  }

  if url.starts-with("github.com/") {
    url = url.replace("github.com/", "")
  }

  return url
}

// github 链接
#let github(url-str) = {
  let prefix = regex("http[s]?://github.com/")
  if not url-str.starts-with(prefix) {
    panic("github url must start with http[s]://github.com/")
  }

  return link(url-str)[
    #set box(height: 1em)
    #box(image("./icons/github.svg"), baseline: 0.75pt)
    #text(weight: "regular")[
      #url(url-str)
    ]
  ]
}

// 个人信息
#let info(phone: "", email: "", birth: "", website: "") = {
  set align(center)
  set text(size: 0.9em, weight: "regular")
  set box(baseline: 0.1em, height: 1em)

  grid(
    columns: (auto, auto, auto, auto, auto, auto, auto),
    column-gutter: 0.8em,
    link("")[
      #box(image("./icons/phone.svg"))
      #phone
    ],
    text(weight: "regular", baseline: 2pt)[
      ·
    ],
    link("mailto:" + email)[
      #box(image("./icons/envelope.svg"))
      #email
    ],
    text(weight: "regular", baseline: 2pt)[
      ·
    ],
    link("")[
      #box(image("./icons/birth.svg"))
      #birth
    ],
    text(weight: "regular", baseline: 2pt)[
      ·
    ],
    link(website)[
      #box(image("./icons/website.svg"))
      #url(website)
    ]
  )
}


// 分节信息
#let section-header(title: "", icon: "") = {
  grid(
    columns: (1fr),
    row-gutter: 6pt,
    align(left)[
      #if icon != "" {
        box(image(icon), height: 1.4em, baseline: 2pt)
        h(1pt)
      }
      #text(weight: "black", 1.4em, title)
    ],
    line(stroke: 0.5pt+gray, length: 100%)
  )
}


#let cv(name: "", phone: "", email: "", birthday: "", website: "", body) = {
  set document(title: name)
  set page(paper: "a4", margin: (x: 2.1cm, y: 1.2cm))
  set text(font: "LXGW WenKai", 0.9em, weight: "regular");
  set par(justify: true, linebreaks: "optimized")

  align(center)[
    #block(text(weight: "black", 2.4em, name))
    #info(
      phone: phone,
      email: email,
      birth: birthday,
      website: website
    )
  ]
  body
}

// 教育背景
#let educations(educations) = {
  section-header(title: "教育背景", icon: "./icons/education.svg")
  set text(1em, font: "LXGW WenKai", weight: "regular")

  grid(
    columns: (1fr),
    row-gutter: 0.65em,
    ..educations.map(education => [
      #strong(education.school)`,`
      #h(3pt)
      #education.major
      #h(1fr)
      #text(weight: "thin", emph(education.degree))
      #h(3pt)
      #text(weight: "thin", emph(education.date))
    ])
  )
}

// 项目经历
#let projects(projects) = {
  section-header(title: "项目经历", icon: "./icons/project.svg")

  grid(
    columns: (1fr),
    row-gutter: 0.65em,
    ..projects.map(project => [
        #text(1.25em, weight: "black")[
          #emph(project.name + ":")
        ]
        #h(3pt)
        #if project.url != "" {
          github(project.url)
        } else {
          text("未开源")
        }
        #h(1fr)
        #text(weight: "thin", emph(project.date))

        #if project.desc != "" {
          v(-5pt)
          text(weight: "black", project.desc)
        }

        #v(-3pt)
        #if project.points.len() != 0 {
          grid(
            columns: (1fr),
            row-gutter: 0.65em,
            ..project.points.map(point => [
              #set list(indent: 1em, tight: false)
              #list(point)
            ])
          )
        }

        #v(3pt)
    ])
  )
}

// 实习经历
#let internships(internships) = {
  section-header(title: "实习经历", icon: "./icons/internship.svg")

  grid(
    columns: (1fr),
    row-gutter: 0.65em,
    ..internships.map(internship => [
      #text(1.25em, weight: "black")[
        #emph(internship.company + ":")
      ]
      #h(3pt)
      #internship.jobtitle
      #h(1fr)
      #text(weight: "thin", emph(internship.date))
      
      #grid(
        columns: (1fr),
        row-gutter: 0.65em,
        ..internship.points.map(point => [
          #set list(indent: 1em, tight: false)
          #list(point)
        ])
      )

      #v(3pt)
    ])
  )
}

// 荣誉奖项
#let awards(awards) = {
  section-header(title: "荣誉奖项", icon: "./icons/award.svg")

  grid(
    columns: (1fr),
    row-gutter: 0.65em,
    ..awards.map(award => [
      #award.name
      #h(1fr)
      #text(weight: "thin", emph(award.date))
      #v(2pt)
    ])
  )
}

// 个人技能
#let skills(skills) = {
  section-header(title: "个人技能", icon: "./icons/skill.svg")

  grid(
    columns: (1fr),
    row-gutter: 0.65em,
    ..skills.map(skill => [
      #skill.name
      #h(1fr)
      #text(weight: "thin", emph(skill.desc))
      #v(2pt)
    ])
  )
}