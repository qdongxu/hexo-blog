---
title: REST API 设计常见问题
tags:
	- api
categories:
    - 编程
---

# REST API 设计常见问题

服务间的通讯方式，经历了IPC/RPC, CORBA, SOAP 等远程协议后， REST API 成为了事实标准。但是由于一些思维惯性，在实践中没有抓住 REST 理念的的精髓。主要有以下的一些问题：

## 1.  使用动词或动名词设计 URL

以一个订单的API 设计为例， 对一创建订单的 URL 写为：

    /xxx_domain/create_order

这里使用了create_order 。 这里延用了函数的命名规则, 将 API 对应到了函数的调用。事实上 REST 理念以资源为中心设计，每一个  URL 应该对应一类资源，这里是订单 order 。 通过 HTTP Method  表达对资源的增删改查等操作。一个创建订单的REST API 应该设计为：

    POST /xxx_domain/order 

这里 POST 表达创建， order 表达资源。HTTP Method 和 URL 两者构成 API 的整体。

REST API 通常使用的 HTTP Method：

- GET 查询/获取 资源，该 API 应该是幂等的，是一个只读操作，不改变资源的状态。
- POST 创建 新的资源，该 API 不保证是幂等的，重复调用可能创建重复的资源。服务端和客户端自行协商如何控测和避免创建重复的资源。
- PUT 更新 资源状态， 该 API 应保证操作是幂等的，重复调用多次的效果和调用一次的效果相同。 
- PATCH 更新 资源状态， 对 PUT 操作对比，PATCH 不保证是幂等的。通常应该优先选择 PUT 操作。
- DELETE 删除资源，该 API 应该是幂等的，调用多次和调用一次效果相同。

## 2. 只使用 GET 操作，只返回 200 状态码

在项目中一个非常普遍的现象是只使用 GET 动词 （也有只使用 POST的）。 通常给出的原因有如下几种：

   1. GET 操作更安全。因为对外部来说 GET 看起来是一个只读操作。 

   2. 容易统一标准，前端容易处理。

   3. 早期的互联网接入提供商会拦截非 200 状态码，返回广告页面。

在只返回 200 状态码的情况下，对请求响应返回体中包含如下三项：

```json
{

   “code”: 100,

   "message": "",

   "data": { "xx": "..." }

}
```

客户端首先检查返回状态码是 200， 否则表求网络请求超时了。然后获取响应体，检查 “code” 是否达成功，这里的“error_code”通常是各业务部门自定，没有统一的标准。如果不成功，显示 “message”；成功则提取“data”，走正常的业务逻辑。

```java
try {

    HttpResponse response = httpClient.createOrder();

    if ( response.statusCode == 200 ) {

　　    if ( response.body.errorCode == 100 ) {

            Order order = unmarshal(response.body.data);

         } else {

            print( response.body.errorCode, response.body.errorMessage )

        }

    }  else {

      // ... 

    }

} catch ( Exception e ) {

    log( "error", e);

}
```

按照 REST 理念 HTTP Status Code 应该直接表达 API 操作是否成功， 并使用 HTTP status code 的标准语义， 比如：

- 200 操作成功
- 400 客户端错误（在 REST API里指参数错误）
- 401 用户未认证（登录）
- 403 用户未授权
- 404 资源不存在
- 500 服务内部错误
- 503 上游服务错误

对于响应返回体，如果操作成功，应该直接返回业务对象

```json
{

“xx”: "..."

}
```

如果操作不成功，应该返回错误信息：

```json
{

  "code" : "1000",

  "message": "xxxxxxxxx"

}
```

这样表达表面看起来响应体有两种，前端要分别处理。实际上前端代码更简洁，因为不管是前端 javascript http 函数，还是后端 OpenFeign 等框架，绝大部分都使用了异常机制，当 http code 不是 2xx， 就抛异常了。所以前端只需要写如下类似的代码(伪代码)

```java
try {

    Order order = httpClient.createOrder();

} catch ( BizException e ) {

    log( e.Code() , e.Message()); 

}
``` 

## 3. 返回 API 职责以外的信息
对于 API 职责划分不清，比如创建订单成功的返回体还携带了额外的附加信息。

```json
{

   "code": 1001,

    "message": "缺货待补",

    "data" : {"orderId": 123}

}
```
## 4. URL 中使用下划线"_"分隔 

比如前文的 create_order， 事实上 URL 中推荐用减号"-"分隔。 