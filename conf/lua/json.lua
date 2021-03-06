local arg = ngx.req.get_post_args()

data = arg["data"]
md5 = arg["md5"]
ngx.var.rdata = data
ngx.var.fmt_localtime = ngx.localtime()
-- md5 check
-- if md5 is wrong: rewrite 400
md5_check = ngx.md5(data .. "xws123")
if (not(md5 == md5_check)) 
then
    ngx.say(string.format("{\"code\":-1, md5:[%s]}", md5_check))
    return
end
--
-- todo : just return 200, ok
ngx.var.flag = 0
ngx.say(string.format("{\"code\":200, \"data\":%s}", data))
