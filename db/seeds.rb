site_one = Site.create(title: "first site", host: "one.codehog.com")
layout = site_one.layouts.create(title: "layout one", body: "this is the layout <%= yield %> foot")
page = site_one.pages.create(title: "page one", path: "/",  body: "home page for site one", layout_id: layout.id)



site_two = Site.create(title: "second site", host: "two.codehog.com")
site_two.pages.create(title: "page two", path:  "/", body: "home page for site two")
