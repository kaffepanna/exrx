$:.unshift File.dirname(__FILE__)

require 'open-uri'
require 'hpricot'
require 'models.rb'

URL = "http://exrx.net/"

def collect_muscles(lis)
  lis.map do |li|
    puts "\t\t"+li.inner_text.split.join(" ")
    Muscle.find_or_create_by_name((li/"a").inner_text.split.join(" "))
  end  
end

def parse_exercises(doc, ex_obj)
  (doc/"p").each do |p| 
    case p.inner_text.split.join(" ")
    when /Dynamic Stabilizers/
      puts "\tDynamic Stabilizers"
      ex_obj.dynamic_stabilizers = collect_muscles(p.next_sibling/"li")
    when /Stabilizers/
      puts "\tStabilizers"
      ex_obj.stabilizers = collect_muscles(p.next_sibling/"li")
    when /Target/
      puts "\tTargets"
      ex_obj.targets = collect_muscles(p.next_sibling/"li")
    when /Synergists/
      puts "\tSynergists"
      ex_obj.synergists = collect_muscles(p.next_sibling/"li")
    end
  end
end

def parse_exercise(path)
  sleep(0.3)
  doc = open(path) { |f| Hpricot(f) } 
  title = (doc/"h1/a").first
  if title
    puts title.inner_text.split().join(" ")
    ex_obj = Exercise.new(name: title.inner_text.split().join(" "))
    parse_exercises(doc, ex_obj)
    ex_obj.save
  end
end

def parse_muscle_group(path)
  doc = open(path) {|f| Hpricot(f) }
  (doc/"li/a").each do |a|
    parse_exercise(URI.join(path, a['href']).to_s) unless a['href'] =~ /Stretches/
  end
end

def parse_exercise_index()
  path = URI.join(URL, "Lists/Directory.html").to_s
  doc = open(path) {|f| Hpricot(f) }
  (doc/"ul").first.search("/li").each do |li|
    parse_muscle_group(URI.join(path, (li/"/a").first['href']))
  end
end


parse_exercise_index()

