import asyncdispatch
import asyncnet
import strutils
import osproc


type Person = tuple
  name: string
  age: uint8


type People = object
  people: seq[Person]


proc newPeople(): People =
  return People(people: newSeq[Person]())


proc add(p: var People, person: Person) = 
    p.people.add(person)


proc show(p: People) = 
  for person in p.people:
    echo person.name, " ", person.age



proc processClient(client: AsyncSocket) {.async.} =
  let proc_uptime = execProcess("uptime")
  asyncCheck client.recvLine(maxLength=1024)
  #line = line.strip()
  # if line.len == 0: break
  #let  lhash = line.hash()
  await client.send("HTTP/1.1 200 OK\nContent-Type: text/html\n\nUptime: " & proc_uptime & "\n")

  client.close()

proc startServer() {.async.} =
  let s = newAsyncSocket()
  s.setSockOpt(OptReuseAddr, true)
  s.setSockOpt(OptReusePort, true)
  s.bindAddr(Port(9090), "")
  s.listen()


  while true:
    let client = await s.accept()
    asyncCheck processClient(client)

proc runServer() = 
  asyncCheck startServer()
  runForever()

when isMainModule:
  var p = newPeople()
  p.add(("Engin", 35.uint8))
  p.add(("Mehmet", 34.uint8))
  p.show()


