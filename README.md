# ANFuYouAPI
富友支付移动版接口封装，可替换官方 SDK，减小体积/审核风险/优化用户体验/自定义支付界面，并且支持 bitcode 👍。

## Requirements

* iOS 10.0+
* Xcode 10
* Swift 4.2

## Support

* 订单生成、验证码发送、银行卡扣款。

## Examples

```swift
import Alamofire
import ANBaseNetwork
import ANFuYouAPI

// STEP 1: 构造商户订单（通常由服务端提供所有字段）

let order = MerchantOrder(...)

// SETP 2: 调用订单生成接口

let api1 = FYMobileService.Order(order: order, 
                                 environment: .develop)

request(api: api1) { [weak self] result1 in
    switch result1 {
    case .success(let orderResponse):
        print(orderResponse)
    case .failure(let error):
        print(error)
    }
}

// SETP 3: 界面输入手机号，调用验证码发送接口

let api2 = FYMobileService.OneTimeCode(mobile: mobile, 
                                       order: order, 
                                       orderResponse: orderResponse, 
                                       environment: .develop)

request(api: api2) { [weak self] result2 in
    switch result2 {
    case .success(let oneTimeCodeResponse):
        print(oneTimeCodeResponse)
    case .failure(let error):
        print(error)
    }
}

// SETP 4: 界面输入验证码，调用支付接口

let api3 = FYMobileService.Payment(mobile: mobile, 
                                   oneTimeCode: oneTimeCode, 
                                   order: order, 
                                   orderRespone: orderRespone, 
                                   oneTimeCodeResponse: oneTimeCodeResponse, 
                                   environment: .develop)

request(api: api3) { [weak self] result3 in
    switch result3 {
    case .success(let paymentResponse):
        print(paymentResponse)
    case .failure(let error):
        print(error)
    }
}
```

## Installation

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate ANFuYouAPI into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "anotheren/ANFuYouAPI" ~> 1.1
```

## License

ANFuYouAPI is released under the MIT license. See LICENSE for details.
