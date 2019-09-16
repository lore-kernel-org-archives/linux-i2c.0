From: "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
Subject: Re: [PATCH] i801_smbus: clear SMBALERT status bit and disable
 SMBALERT interrupt
Date: Mon, 16 Sep 2019 09:29:27 +0000
Message-ID: <d7dce94a-d857-dc1e-1917-d715940bc356@nokia.com>
References: <1565577634-18264-1-git-send-email-lingyan.xu@nokia-sbell.com>
 <20190828155822.7cb13a7b@endymion>
 <a6cd1872effd46c7ba088f28402b32b8@nokia-sbell.com>
 <20190905145716.137e155a@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190905145716.137e155a@endymion>
Content-Language: en-US
Content-ID: <21C9BBA62CE96C4F957140A2A0952C3E@eurprd07.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>, "Xu, Lingyan (NSB - CN/Hangzhou)" <lingyan.xu@nokia-sbell.com>
Cc: "Adamski, Krzysztof (Nokia - PL/Wroclaw)" <krzysztof.adamski@nokia.com>, "Wiebe, Wladislav (Nokia - DE/Ulm)" <wladislav.wiebe@nokia.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

SGkgSmVhbiwNCg0KT24gMDUvMDkvMjAxOSAxNDo1NywgSmVhbiBEZWx2YXJlIHdyb3RlOg0KPiBJ
ZiB0aGlzIGlzIG9mIGFueSB2YWx1ZSB0byB5b3UsIEkgdHJpZWQgaW1wbGVtZW50aW5nIGl0IGlu
IGkyYy1pODAxIGENCj4gZmV3IGRheXMgYWdvLiBJIGNhbid0IHJlYWxseSB0ZXN0IGl0IHRob3Vn
aCBhcyBJIGRvbid0IGhhdmUgYW55IGRldmljZQ0KPiB3aGljaCB0cmlnZ2VycyBhbiBhbGVydCBv
biBteSBzeXN0ZW0sIGJ1dCBJIGFtIHNoYXJpbmcgaXQgd2l0aCB5b3UgaWYNCj4geW91IHdhbnQg
dG8gZ2l2ZSBpdCBhIHRyeS4gWW91IHdvdWxkIHN0aWxsIG5lZWQgdG8gd3JpdGUgdGhlIGNvZGUg
aW4NCj4gdGhlIHNsYXZlIGRyaXZlci4NCg0KYW5kIEkgZm9yZ290IGFub3RoZXIgaXNzdWU6DQoN
Cj4gQEAgLTE4OTcsOCArMTk1NiwxMCBAQCBzdGF0aWMgdm9pZCBpODAxX3JlbW92ZShzdHJ1Y3Qg
cGNpX2RldiAqDQo+ICAJcG1fcnVudGltZV9mb3JiaWQoJmRldi0+ZGV2KTsNCj4gIAlwbV9ydW50
aW1lX2dldF9ub3Jlc3VtZSgmZGV2LT5kZXYpOw0KPiAgDQo+IC0JaTgwMV9kaXNhYmxlX2hvc3Rf
bm90aWZ5KHByaXYpOw0KPiArCWk4MDFfcmVzdG9yZV9zbHZjbWQocHJpdik7DQo+ICAJaTgwMV9k
ZWxfbXV4KHByaXYpOw0KPiArCWlmIChwcml2LT5hcmEpDQo+ICsJCWkyY191bnJlZ2lzdGVyX2Rl
dmljZShwcml2LT5hcmEpOw0KDQp0byBtZSBpdCBsb29rcyBsaWtlIGEgcmFjZSB3aXRoIElSUSBo
YW5kbGVyIChJUlEgaXMgb25seSBkaXNhYmxlZCAqYWZ0ZXIqDQpyZW1vdmUoKSksIGl0IGNhbiBz
dGlsbCBhdHRlbXB0IHRvIHVzZSBmcmVlZCBBUkEgZGV2aWNlIGFmdGVyIHRoaXMgbGluZS4gDQoN
Cj4gIAlpMmNfZGVsX2FkYXB0ZXIoJnByaXYtPmFkYXB0ZXIpOw0KPiAgCWk4MDFfYWNwaV9yZW1v
dmUocHJpdik7DQo+ICAJcGNpX3dyaXRlX2NvbmZpZ19ieXRlKGRldiwgU01CSFNUQ0ZHLCBwcml2
LT5vcmlnaW5hbF9oc3RjZmcpOw0KDQotLSANCkJlc3QgcmVnYXJkcywNCkFsZXhhbmRlciBTdmVy
ZGxpbi4NCg==
