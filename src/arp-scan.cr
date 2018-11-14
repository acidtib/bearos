require "json"

io = IO::Memory.new
status = Process.run("arp-scan -l", shell: true, output: io, error: io)
io.close

data = io.to_s.chomp

if status.success?
  puts "200"

  data_lines = data.lines

  data_lines.each do |line|
    if line.includes?("\t")
      l = line.split("\t")
      puts l[2] if l[2] == "VMware, Inc."
    end
  end

else
  puts "500"
end