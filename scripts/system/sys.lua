-- lua_register(L,"C_senddata",		C_senddata);
-- lua_register(L,"C_broadcast",		C_broadcast);
-- lua_register(L,"C_broadcastall",		C_broadcastall);
-- lua_register(L,"C_connect",		C_connect);
-- lua_register(L,"C_listen",		C_listen);
-- lua_register(L,"C_connectmysql",		C_connectmysql);
-- lua_register(L,"C_query",		C_query);
-- lua_register(L,"C_escapedStr",		C_escapedStr);
local C_senddata,C_broadcast,C_broadcastall,C_connect,C_listen,C_connectmysql,C_query,C_escapedStr,pack,cjson,table,cbFunc
	= C_senddata,C_broadcast,C_broadcastall,C_connect,C_listen,C_connectmysql,C_query,C_escapedStr,pack,cjson,table,cbFunc

module "system.sys"



function callClient(sockId, funcName, ...)
	return C_senddata(sockId, 1, pack(funcName,...))
end

function callNc(sockId, funcName, ...)
	return C_senddata(sockId, 2, pack(funcName,...))
end

-- sockList
-- 	{sockId,-}
function broadCastToSockList( sockList,  funcName, ...)
	return C_broadcast(sockList, 1, pack(funcName,...))
end

function broadcastToAll( funcName, ... )
	return C_broadcastall(1, pack(funcName,...))
end

-- 异步
function connect( ip,sockId )
	return C_connect(ip,sockId)
end

function listen( port )
	return C_listen(port)
end

function dbConnect( server,user,pass,database,port )
	return C_connectmysql(server,user,pass,database,port)
end

-- 异步
function dbQuery( sql,cb )
	table.insert(cbFunc, cb)
	return C_query(sql)
end

function escapedStr( str )
	return C_escapedStr(str)
end