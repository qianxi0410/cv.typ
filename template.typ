// url预处理
#let url(url-str) = {
  let prefix = regex("http[s]?://")

  // url必须以http:// 或 https://开头
  if not url-str.starts-with(prefix) {
    panic("url must start with http:// or https://")
  }

  url-str = url-str.replace(prefix, "")
  // 去掉末尾的/
  if url-str.ends-with("/") {
    url-str = url-str.slice(0, url.len() - 1)
  }

  if url-str.starts-with("github.com/") {
    url-str = url-str.replace("github.com/", "")
  }

  return url-str
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
    // 名字
    #let name-size = 2.4em
    #text(weight: "black", name-size, name)
    #v(-(name-size - 0.4em))

    // 其他信息
    #set text(size: 0.9em)
    #set box(baseline: 0.1em, height: 1em)
    #grid(
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
        #birthday
      ],
      text(weight: "regular", baseline: 2pt)[
        ·
      ],
      link(website)[
        #box(image("./icons/website.svg"))
        #url(website)
      ]
    )
  ]
  body
}

// 教育背景
#let educations(educations) = {
  section-header(title: "教育背景", icon: "./icons/education.svg")
  set text(1.05em)

  for education in educations {
    block[
      #text(weight: "black", education.school + ",")
      #h(3pt)
      #education.major
      #h(1fr)
      #text(education.degree)
      #h(3pt)
      #text(0.9em, weight: "thin", emph(education.date))
      #v(-4pt)
    ]
  }

  v(3pt)
}

// 项目经历
#let projects(projects) = {
  section-header(title: "项目经历", icon: "./icons/project.svg")

  set list(indent: 1em, tight: true)

  for project in projects {
    block[
      #text(1.25em, weight: "black", project.name)
      #if project.url != "" {
        h(3pt)
        github(project.url)
      }
      #h(1fr)
      #text(weight: "thin", emph(project.date))

      #if project.desc != "" {
        v(-5pt)
        text(weight: "black", project.desc)
      }

      #for point in project.points {
        list(point)
      }
      #v(3pt)
    ]
  }
}

// 实习经历
#let internships(internships) = {
  section-header(title: "实习经历", icon: "./icons/internship.svg")
  set list(indent: 1em, tight: true)

  for internship in internships {
    block[
      #text(1.25em, weight: "black", internship.company)
      #h(3pt)
      #internship.jobtitle
      #h(1fr)
      #text(weight: "thin", emph(internship.date))
      
      #for point in internship.points {
        list(point)
      }

      #v(3pt)
    ]
  }
}

// 荣誉奖项
#let awards(awards) = {
  section-header(title: "荣誉奖项", icon: "./icons/award.svg")
  set list(tight: true, marker: none, body-indent: 0pt)

  for award in awards {
    list[
      #award.name
      #h(1fr)
      #text(weight: "thin", emph(award.date))
      #v(2pt)
    ]
  }
}

// 个人技能
#let skills(skills) = {
  section-header(title: "个人技能", icon: "./icons/skill.svg")
  set list(tight: true, marker: none, body-indent: 0pt)

  for skill in skills {
    list[
      #skill.name
      #h(1fr)
      #text(weight: "regular", emph(skill.desc))
      #v(2pt)
    ]
  }
}