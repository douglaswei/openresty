local arg = ngx.req.get_post_args()

data = arg["data"]
md5 = arg["md5"]
ngx.var.rdata = data
-- todo: md5 check
-- if md5 is wrong: rewrite 400
--
-- todo : just return 200, ok
ngx.say(string.format("[%s][%s]", data, md5))
