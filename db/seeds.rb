# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

TicketList.delete_all
AssignTicket.delete_all

Comment.delete_all
Chat.delete_all

Tag.delete_all
TagList.delete_all

PerformanceReport.delete_all

User.delete_all

Ticket.delete_all

u=User.create email:"aaaaa@gmail.com",name:"Juan",last_name:"Carrera",phone:"12345", password:"hiitsme", profile:0
u1=User.create email:"use@gmail.com",name:"Carmen",last_name:"Quiroz",phone:"87421", password:"notpassword", profile:0
u2=User.create email:"example@gmail.com",name:"Angela",last_name:"Garcia",phone:"43872", password:"mimascot", profile:0
puts "User ready"

exe=User.create email:"exe@gmail.com",name:"Pedro",last_name:"Valdez",phone:"13245", password:"password", profile:1
exe1=User.create email:"exe1@gmail.com",name:"Daniel",last_name:"Opazo",phone:"51240", password:"clavesecreta", profile:1
puts "Executive ready"

sup=User.create email:"sup@gmail.com",name:"Diego",last_name:"Castro",phone:"14325", password:"answer", profile:2
adm=User.create email:"add@gmail.com",name:"Miguel",last_name:"Perez",phone:"15432", password:"secret", profile:3
puts "Administrator & supervisor ready"

t=Ticket.create [
    {title:"No me permite crear un usuario", incident_description:"Intente crear de nuevo mi cuenta utilizando un mail ya utilizado", state:1},
    {title:"Nadie quiere solucionar mi problema", incident_description:"COmo es posible que nadie pueda solucionar un problema tan simple",state:1},
    {title:"Nose como resumir", incident_description:"Tengo el problema de que no se como hacer que rails use bootstrap bien",state:1},
    {title:" Vacio ", incident_description:" vacio otra vez",state:1},
    {title:"UN ejemplo", incident_description:"esto no es nada mas que un ejemplo",state:1}
]
puts "Ticket ready"

tl=TicketList.create [
    {user:u,ticket:t.first},
    {user:u1,ticket:t.second},
    {user:u2,ticket:t.third},
    {user:u,ticket:t.fourth},
    {user:u2,ticket:t.last}
]
puts "TicketList ready"


 at=AssignTicket.create [
    {user:exe1 ,ticket:t.first},
    {user:exe ,ticket:t.second},
    {user:exe ,ticket:t.third},
    {user:exe1 ,ticket:t.fourth},
    {user:exe ,ticket:t.last}
 ]
puts "AssignTicket ready"

tgl=TagList.create [
    {ticket:t.first},
    {ticket:t.second},
    {ticket:t.third},
    {ticket:t.fourth},
    {ticket:t.last}
]
puts "Taglist ready"

tg=Tag.create [
    {name:"capa 8",tag_list:tgl.first},
    {name:"Not method", tag_list:tgl.second},
    {name:"capa 8",tag_list:tgl.last},
    {name:"not answer",tag_list:tgl.second},
    {name:"ask error", tag_list:tgl.third}
]
puts "Tags ready"

ch=Chat.create [
    {ticket:t.first},
    {ticket:t.second},
    {ticket:t.third},
    {ticket:t.fourth},
    {ticket:t.last}
]
puts "Chat ready"

cm=Comment.create [
    {text:"buen ejemplo de comentario",writer:"⚙️ "+adm.name + " " + adm.last_name,chat:ch.first},
    {text:"problema para el que sigue", writer:"🐾 "+exe1.name + " " + exe1.last_name,chat:ch.second},
    {text:"No deberias de decir eso",writer:"🌀 "+sup.name + " " + sup.last_name,chat:ch.second},
    {text:"otro ejemplo",writer:"🐾 "+exe.name + " " + exe.last_name,chat:ch.last},
    {text:"No se que responder",writer:"🐾 "+exe1.name + " " + exe1.last_name,chat:ch.fourth}
]
puts "Comments ready"


puts "Reports should be made in the webpage"