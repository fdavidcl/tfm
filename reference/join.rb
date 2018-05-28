#!/usr/bin/env ruby

docs = Dir["*.html"]

content = docs.map do |fn|
  File.read(fn).split("</header>")[1].split("<footer>")[0].sub(/<div(.*?)col-md-3((.|\n)*?)<\/div>/, "")
end

open("reference.html", "w").write(content.join("\n"))

system "pandoc reference.html -o reference.md"
system "pandoc reference.md -o reference.tex"
system "rm -f reference.html reference.md"
