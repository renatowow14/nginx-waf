# Nginx + ModSecurity + Cron Scheduler on Docker  [![license](https://img.shields.io/github/license/mashape/apistatus.svg?maxAge=2592000)](https://github.com/renatowow14/nginx-waf/blob/main/LICENSE)

![image](https://www.nginx.com/wp-content/uploads/2017/08/blog-fm-2017-modsecurity-featured-500x300.png)

## What is ModSecurity ?

ModSecurity is an open source, cross platform Web Application Firewall (WAF) engine for Apache, IIS and Nginx. It has a robust event-based programming language which provides protection from a range of attacks against web applications and allows for HTTP traffic monitoring, logging and real-time analysis.

## What is Nginx ?

NGINX is open source software for web serving, reverse proxying, caching, load balancing, media streaming, and more. It started out as a web server designed for maximum performance and stability. In addition to its HTTP server capabilities, NGINX can also function as a proxy server for email (IMAP, POP3, and SMTP) and a reverse proxy and load balancer for HTTP, TCP, and UDP servers.

## What is Cron ?

The cron command-line utility is a job scheduler on Unix-like operating systems. Users who set up and maintain software environments use cron to schedule jobs (commands or shell scripts), also known as cron jobs,to run periodically at fixed times, dates, or intervals.It typically automates system maintenance or administration—though its general-purpose nature makes it useful for things like downloading files from the Internet and downloading email at regular intervals.

### Custom Nginx Definitions

| ⚠️ WARNING          |
|:---------------------------|
| Nginx based images are now based on upstream nginx. This changed the way the config file for nginx is generated.  |

If using the [Nginx environment variables](https://github.com/coreruleset/modsecurity-docker#nginx-env-variables) is not enough for your use case, you can mount your own `nginx.conf` file as the new template for generating the base config.

An example can be seen in the [docker-compose](https://github.com/coreruleset/modsecurity-docker/blob/master/docker-compose.yml) file.

> 💬 What happens if I want to make changes in a different file, like `/etc/nginx/conf.d/default.conf`?
> You mount your local file, e.g. `nginx/default.conf` as the new template: `/etc/nginx/templates/conf.d/default.conf.template`. You can do this similarly with other files. Files in the templates directory will be copied and subdirectories will be preserved.

## How to use this image

1. Set your custom cron schedules in :

```
   src/etc/cron.d/crontab == Definition of scheduling
   src/etc/cron.d/entrypoint.sh == Shell Script that will be run on schedule
   Note: By default the schedule was just starting nginx
```

2. Create a Dockerfile in your project and copy your code into container.
```
   docker-compose up -d 
```
3. Visit http://localhost:80 and your page.

### Nginx ENV Variables

| Name     | Description|
| -------- | ------------------------------------------------------------------- |
| ACCESSLOG  | A string value indicating the location of the access log file (Default: `/var/log/nginx/access.log`) | 
| BACKEND  | A string indicating the partial URL for the remote server of the `proxy_pass` directive (Default: `http://localhost:80`) | 
| DNS_SERVER  | A string indicating the name servers used to resolve names of upstream servers into addresses. For localhost backend this value should not be defined (Default: *not defined*) | 
| ERRORLOG  | A string value indicating the location of the error log file (Default: `/proc/self/fd/2`) | 
| LOGLEVEL  | A string value controlling the number of messages logged to the error_log (Default: `warn`) | 
| METRICS_ALLOW_FROM  | A string indicating a single range of IP adresses that can access the metrics (Default: `127.0.0.0/24`) | 
| METRICS_DENY_FROM  | A string indicating a range of IP adresses that cannot access the metrics (Default: `all`) | 
| METRICSLOG  | A string value indicating the location of metrics log file (Default: `/dev/null`) | 
| NGINX_ALWAYS_TLS_REDIRECT | A string value indicating if http should redirect to https (Allowed values: `on`, `off`. Default: `off`) | 
| PORT  | An integer value indicating the port where the webserver is listening to (Default: `80`) | 
| SET_REAL_IP_FROM | A string of comma separated IP, CIDR, or UNIX domain socket addresses that are trusted to replace addresses in `REAL_IP_HEADER` (Default: `127.0.0.1`). See [set_real_ip_from](http://nginx.org/en/docs/http/ngx_http_realip_module.html#set_real_ip_from) |
| REAL_IP_HEADER | Name of the header containing the real IP value(s) (Default: `X-REAL-IP`). See [real_ip_header](http://nginx.org/en/docs/http/ngx_http_realip_module.html#real_ip_header) |
| REAL_IP_RECURSIVE | A string value indicating whether to use recursive reaplacement on addresses in `REAL_IP_HEADER` (Allowed values: `on`, `off`. Default: `on`). See [real_ip_recursive](http://nginx.org/en/docs/http/ngx_http_realip_module.html#real_ip_recursive) |
| PROXY_SSL_CERT  | A string value indicating the path to the server PEM-encoded X.509 certificate data file or token value identifier (Default: `/etc/nginx/conf/server.crt`) | 
| PROXY_SSL_CERT_KEY  | A string value indicating the path to the server PEM-encoded private key file (Default: `/etc/nginx/conf/server.key`) | 
| PROXY_SSL_CIPHERS | A String value indicating the enabled ciphers. The ciphers are specified in the format understood by the OpenSSL library. (Default: `ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384;`|
| PROXY_SSL_DH_BITS | A numeric value indicating the size (in bits) to use for the generated DH-params file (Default 2048) |
| PROXY_SSL_OCSP_STAPLING | A string value indicating if ssl_stapling and ssl_stapling_verify should be enabled (Allowed values: `on`, `off`. Default: `off`) |
| PROXY_SSL_PREFER_CIPHERS | A string value indicating if the server ciphers should be preferred over client ciphers when using the SSLv3 and TLS protocols (Allowed values: `on`, `off`. Default: `off`)|
| PROXY_SSL_PROTOCOLS | A string value indicating the ssl protocols to enable (default: `TTLSv1.2 TLSv1.3`)|
| PROXY_SSL_VERIFY  | A string value indicating if the client certificates should be verified (Allowed values: `on`, `off`. Default: `off`) | 
| PROXY_TIMEOUT  | Number of seconds for proxied requests to time out connections (Default: `60s`) | 
| SSL_PORT  | Port number where the SSL enabled webserver is listening (Default: `443`) | 
| TIMEOUT  | Number of seconds for a keep-alive client connection to stay open on the server side (Default: `60s`) | 
| WORKER_CONNECTIONS  | Maximum number of simultaneous connections that can be opened by a worker process (Default: `1024`) | 

### ModSecurity ENV Variables

All these variables impact in configuration directives in the modsecurity engine running inside the container. The [reference manual](https://github.com/SpiderLabs/ModSecurity/wiki/Reference-Manual-(v2.x)) has the extended documentation, and for your reference we list the specific directive we change when you modify the ENV variables for the container.

| Name     | Description|
| -------- | ------------------------------------------------------------------- |
| MODSEC_AUDIT_ENGINE  | A string used to configure the audit engine, which logs complete transactions (Default: `RelevantOnly`). Accepted values: `On`, `Off`, `RelevantOnly`. See [SecAuditEngine](https://github.com/SpiderLabs/ModSecurity/wiki/Reference-Manual-%28v2.x%29#SecAuditEngine) for additional information. | 
| MODSEC_AUDIT_LOG  | A string indicating the path to the main audit log file or the concurrent logging index file (Default: `/dev/stdout`) | 
| MODSEC_AUDIT_LOG_FORMAT  | A string indicating the output format of the AuditLogs (Default: `JSON`). Accepted values: `JSON`, `Native`. See [SecAuditLogFormat](https://github.com/SpiderLabs/ModSecurity/wiki/Reference-Manual-%28v2.x%29#SecAuditLogFormat) for additional information. | 
| MODSEC_AUDIT_LOG_TYPE  | A string indicating the type of audit logging mechanism to be used (Default: `Serial`). Accepted values: `Serial`, `Concurrent` (`HTTPS` works only on Nginx - v3). See [SecAuditLogType](https://github.com/SpiderLabs/ModSecurity/wiki/Reference-Manual-%28v2.x%29#secauditlogtype) for additional information. | 
| MODSEC_AUDIT_LOG_PARTS  | A string that defines which parts of each transaction are going to be recorded in the audit log (Default: `'ABIJDEFHZ'`). See [SecAuditLogParts](https://github.com/SpiderLabs/ModSecurity/wiki/Reference-Manual-(v2.x)#secauditlogparts) for the accepted values. | 
| MODSEC_AUDIT_STORAGE  | A string indicating the directory where concurrent audit log entries are to be stored (Default: `/var/log/modsecurity/audit/`) | 
| MODSEC_DATA_DIR  | A string indicating the path where persistent data (e.g., IP address data, session data, and so on) is to be stored (Default: `/tmp/modsecurity/data`) | 
| MODSEC_DEBUG_LOG  | A string indicating the path to the ModSecurity debug log file (Default: `/dev/null`) | 
| MODSEC_DEBUG_LOGLEVEL  | An integer indicating the verboseness of the debug log data (Default: `0`). Accepted values: `0` - `9`. See [SecDebugLogLevel](https://github.com/SpiderLabs/ModSecurity/wiki/Reference-Manual-(v2.x)#secdebugloglevel). | 
| MODSEC_PCRE_MATCH_LIMIT  | An integer value indicating the limit for the number of internal executions in the PCRE function (Default: `100000`) (Only valid for Apache - v2). See [SecPcreMatchLimit](https://github.com/SpiderLabs/ModSecurity/wiki/Reference-Manual-(v2.x)#SecPcreMatchLimit) | 
| MODSEC_PCRE_MATCH_LIMIT_RECURSION  | An integer value indicating the limit for the depth of recursion when calling PCRE function (Default: `100000`) | 
| MODSEC_REQ_BODY_ACCESS  | A string value allowing ModSecurity to access request bodies (Default: `On`). Allowed values: `On`, `Off`. See [SecRequestBodyAccess](https://github.com/SpiderLabs/ModSecurity/wiki/Reference-Manual-(v2.x)#secrequestbodyaccess) for more information. | 
| MODSEC_REQ_BODY_LIMIT  | An integer value indicating the maximum request body size  accepted for buffering (Default: `13107200`). See [SecRequestBodyLimit](https://github.com/SpiderLabs/ModSecurity/wiki/Reference-Manual-(v2.x)#secrequestbodylimit) for additional information. | 
| MODSEC_REQ_BODY_LIMIT_ACTION  | A string value for the action when `SecRequestBodyLimit` is reached (Default: `Reject`). Accepted values: `Reject`, `ProcessPartial`. See [SecRequestBodyLimitAction](https://github.com/SpiderLabs/ModSecurity/wiki/Reference-Manual-(v2.x)#secrequestbodylimitaction) for additional information. | 
| MODSEC_REQ_BODY_JSON_DEPTH_LIMIT | An integer value indicating the maximun JSON request depth (Default: `512`). See [SecRequestBodyJsonDepthLimit](https://github.com/SpiderLabs/ModSecurity/wiki/Reference-Manual-%28v2.x%29#SecRequestBodyJsonDepthLimit) for additional information. | 
| MODSEC_REQ_BODY_NOFILES_LIMIT  | An integer indicating the maximum request body size ModSecurity will accept for buffering (Default: `131072`). See [SecRequestBodyNoFilesLimit](https://github.com/SpiderLabs/ModSecurity/wiki/Reference-Manual-(v2.x)#secrequestbodynofileslimit) for more information. | 
| MODSEC_RESP_BODY_ACCESS  | A string value allowing ModSecurity to access response bodies (Default: `On`). Allowed values: `On`, `Off`. See [SecResponseBodyAccess](https://github.com/SpiderLabs/ModSecurity/wiki/Reference-Manual-%28v2.x%29#secresponsebodyaccess) for more information. | 
| MODSEC_RESP_BODY_LIMIT  | An integer value indicating the maximum response body size accepted for buffering (Default: `1048576`) | 
| MODSEC_RESP_BODY_LIMIT_ACTION  | A string value for the action when `SecResponseBodyLimit` is reached (Default: `ProcessPartial`). Accepted values: `Reject`, `ProcessPartial`. See [SecResponseBodyLimitAction](https://github.com/SpiderLabs/ModSecurity/wiki/Reference-Manual-(v2.x)#secresponsebodylimitaction) for additional information. | 
| MODSEC_RESP_BODY_MIMETYPE  | A string with the list of mime types that will be analyzed in the response (Default: `'text/plain text/html text/xml'`). You might consider adding `application/json` documented [here](https://github.com/SpiderLabs/ModSecurity/wiki/Reference-Manual-\(v2.x\)#secresponsebodymimetype). | 
| MODSEC_RULE_ENGINE  | A string value enabling ModSecurity itself (Default: `On`). Accepted values: `On`, `Off`, `DetectionOnly`. See [SecRuleEngine](https://github.com/SpiderLabs/ModSecurity/wiki/Reference-Manual-%28v2.x%29#secruleengine) for additional information. | 
| MODSEC_STATUS_ENGINE  | A string used to configure the status engine, which sends statistical information (Default: `Off`). Accepted values: `On`, `Off`. See [SecStatusEngine](https://github.com/SpiderLabs/ModSecurity/wiki/Reference-Manual-%28v2.x%29#SecStatusEngine) for additional information. | 
| MODSEC_TAG  | A string indicating the default tag action, which will be inherited by the rules in the same configuration context (Default: `modsecurity`) | 
| MODSEC_TMP_DIR  | A string indicating the path where temporary files will be created (Default: `/tmp/modsecurity/tmp`) | 
| MODSEC_TMP_SAVE_UPLOADED_FILES  | A string indicating if temporary uploaded files are saved (Default: `On`) (only relevant in Apache - ModSecurity v2) | 
| MODSEC_UPLOAD_DIR  | A string indicating the path where intercepted files will be stored (Default: `/tmp/modsecurity/upload`) | 
| MODSEC_DEFAULT_PHASE1_ACTION | ModSecurity string with the contents for the default action in phase 1 (Default: `'phase:1,log,auditlog,pass,tag:\'\${MODSEC_TAG}\''`) |
| MODSEC_DEFAULT_PHASE2_ACTION | ModSecurity string with the contents for the default action in phase 2 (Default: `'phase:2,log,auditlog,pass,tag:\'\${MODSEC_TAG}\''`) |

### Referencies

 ```
https://github.com/coreruleset/modsecurity-docker
 ```
 ``` 
https://github.com/coreruleset/coreruleset
 ```
 ```
 https://github.com/coreruleset/modsecurity-crs-docker
 ```
