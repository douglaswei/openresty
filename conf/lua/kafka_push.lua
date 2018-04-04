if ngx.var.flag == 0 then
    return
end

-- 引入lua所有api  
local cjson = require "cjson"  
local producer = require "resty.kafka.producer"  
-- 定义kafka broker地址，ip需要和kafka的host.name配置一致  
local broker_list = {  
    { host = KAFKA_HOST, port = KAFKA_PORT },  
}  
-- 定义json便于日志数据整理收集  
local log_json = {}  
--log_json["uri"]=ngx.var.uri  
log_json["args"]=ngx.var.args  
log_json["host"]=ngx.var.host  
--log_json["request_body"]=ngx.var.request_body  
log_json["remote_addr"] = ngx.var.remote_addr  
log_json["remote_user"] = ngx.var.remote_user  
log_json["time_local"] = ngx.localtime()
--log_json["status"] = ngx.var.status  
log_json["body_bytes_sent"] = ngx.var.body_bytes_sent  
log_json["http_referer"] = ngx.var.http_referer  
--log_json["http_user_agent"] = ngx.var.http_user_agent  
--log_json["http_x_forwarded_for"] = ngx.var.http_x_forwarded_for  
--log_json["upstream_response_time"] = ngx.var.upstream_response_time  
--log_json["request_time"] = ngx.var.request_time  
log_json["data"] = cjson.decode(ngx.var.rdata)
-- 转换json为字符串  
local message = cjson.encode(log_json);  
-- 定义kafka异步生产者  
local bp = producer:new(broker_list, { producer_type = "async" })  
-- 发送日志消息,send第二个参数key,用于kafka路由控制:  
-- key为nill(空)时，一段时间向同一partition写入数据  
            -- 指定key，按照key的hash写入到对应的partition  
local ok, err = bp:send("ngx", nil, message)  

if not ok then  
    ngx.log(ngx.ERR, "kafka send err:", err)  
    return  
end  

