#!/usr/bin/env ruby
require 'socket'
require 'optparse'

opcoes = { ip: '0.0.0.0', porta: 5000, resposta: '0000FBIPI9999922' }

OptionParser.new do |opts|
  opts.on('-i IP', '--ip IP', 'Endereço IP') { |v| opcoes[:ip] = v }
  opts.on('-p PORTA', '--porta PORTA', Integer, 'Porta') { |v| opcoes[:porta] = v }
  opts.on('-r RESPOSTA', '--resposta RESPOSTA', 'Resposta') { |v| opcoes[:resposta] = v }
end.parse!

ip, porta, resposta = opcoes[:ip], opcoes[:porta], opcoes[:resposta]

server = TCPServer.new(ip, porta)
puts "Servidor em #{ip}:#{porta}"
puts "Pressione Ctrl+C para parar\n\n"

trap('INT') { puts "\nServidor parado."; exit }

loop do
  client = server.accept

  begin
    recebido = client.recv(1024)

    unless recebido.empty?
      puts "Recebido: #{recebido}"
      client.write(resposta)
      puts "Resposta: #{resposta}\n\n"
    end
  rescue IOError, Errno::ECONNRESET => e
    puts "Erro na conexão: #{e.message}"
  ensure
    client.close
  end
end