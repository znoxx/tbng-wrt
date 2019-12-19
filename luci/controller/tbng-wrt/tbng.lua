module("luci.controller.tbng-wrt.tbng", package.seeall)

function index()
    entry({"admin", "tbng"}, firstchild(), "TBNG-WRT", 60).dependent=false
    entry({"admin", "tbng", "direct"}, call("action_alldirect"), "Direct traffic", 2).dependent=false
    entry({"admin", "tbng", "tor"}, call("action_alltor"), "TOR traffic", 1).dependent=false
    entry({"admin", "tbng", "halt"}, call("action_halt"), "Halt system", 3).dependent=false
end
 
function action_alldirect()
    luci.sys.exec("/usr/local/bin/tbng_direct.sh")
    local tbng_result="Direct traffic mode set"
    luci.template.render("tbng-wrt/tbng", {tbng_result=tbng_result})
end

function action_alltor()                                                                                                                                          
    luci.sys.exec("/usr/local/bin/tbng_tor.sh")                                                                                                                   
    local tbng_result="TOR traffic mode set"
    luci.template.render("tbng-wrt/tbng", {tbng_result=tbng_result})
end 

function action_halt()                       
    luci.http.prepare_content("text/plain")
    luci.http.write("Halting system...")
    luci.sys.exec("/bin/sync")
    luci.sys.exec("/sbin/halt")
end 
