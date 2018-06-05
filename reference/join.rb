#!/usr/bin/env ruby
# coding: utf-8

docs = Dir["*.html"]

content = docs.map do |fn|
  File.read(fn).split("</header>")[1].split("<footer>")[0].sub(/<div(.*?)col-md-3((.|\n)*?)<\/div>/, "")
end

open("reference.html", "w").write(content.join("\n"))

system "pandoc reference.html -o reference.md"
system "pandoc reference.md -o _reference.tex"
system "rm -f reference.html reference.md"

subs = {
  '{"' => "{``",
  '"}' => "''}",
  "@{}ll@{}" => "@{}>{\\small}p{3cm}>{\\raggedright}p{12.5cm}@{}",
  /(?<=.)#>/ => "\n#>",
  "begin{verbatim}" => "begin{minted}[frame=none]{R}",
  "end{verbatim}" => "end{minted}",
  /\\begin\{minipage\}(.*?)strut/ => "",
  "\\strut\\end\{minipage\}" => ""
}

doc = File.read("_reference.tex")

doc = subs.reduce(doc) do |acc, args|
  acc.gsub(*args)
end

File.open("reference.tex", "w").write(doc)
