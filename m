From: Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: [PATCH 1/2] i2c: mxs: use devm_platform_ioremap_resource() to
 simplify code
Date: Wed, 17 Jul 2019 10:21:47 +0000
Message-ID: <AM0PR04MB4211E8DCEC24D6D1D7848A6A80C90@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190717084017.30987-1-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190717084017.30987-1-Anson.Huang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-i2c@vger.kernel.org

PiBGcm9tOiBBbnNvbi5IdWFuZ0BueHAuY29tIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiBTZW50
OiBXZWRuZXNkYXksIEp1bHkgMTcsIDIwMTkgNDo0MCBQTQ0KPiANCj4gVXNlIHRoZSBuZXcgaGVs
cGVyIGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZSgpIHdoaWNoIHdyYXBzIHRoZQ0KPiBw
bGF0Zm9ybV9nZXRfcmVzb3VyY2UoKSBhbmQgZGV2bV9pb3JlbWFwX3Jlc291cmNlKCkgdG9nZXRo
ZXIsIHRvIHNpbXBsaWZ5DQo+IHRoZSBjb2RlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5zb24g
SHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQoNClJldmlld2VkLWJ5OiBEb25nIEFpc2hlbmcg
PGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KDQpSZWdhcmRzDQpBaXNoZW5nDQoNCj4gLS0tDQo+ICBk
cml2ZXJzL2kyYy9idXNzZXMvaTJjLW14cy5jIHwgNCArLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9pMmMvYnVzc2VzL2kyYy1teHMuYyBiL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtbXhzLmMgaW5k
ZXgNCj4gN2Q3OTMxNy4uODkyMjQ5MSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pMmMvYnVzc2Vz
L2kyYy1teHMuYw0KPiArKysgYi9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLW14cy5jDQo+IEBAIC04
MDIsNyArODAyLDYgQEAgc3RhdGljIGludCBteHNfaTJjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UNCj4gKnBkZXYpDQo+ICAJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4g
IAlzdHJ1Y3QgbXhzX2kyY19kZXYgKmkyYzsNCj4gIAlzdHJ1Y3QgaTJjX2FkYXB0ZXIgKmFkYXA7
DQo+IC0Jc3RydWN0IHJlc291cmNlICpyZXM7DQo+ICAJaW50IGVyciwgaXJxOw0KPiANCj4gIAlp
MmMgPSBkZXZtX2t6YWxsb2MoZGV2LCBzaXplb2YoKmkyYyksIEdGUF9LRVJORUwpOyBAQCAtODE0
LDggKzgxMyw3DQo+IEBAIHN0YXRpYyBpbnQgbXhzX2kyY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KQ0KPiAgCQlpMmMtPmRldl90eXBlID0gZGV2aWNlX2lkLT5kcml2ZXJfZGF0
YTsNCj4gIAl9DQo+IA0KPiAtCXJlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JF
U09VUkNFX01FTSwgMCk7DQo+IC0JaTJjLT5yZWdzID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKCZw
ZGV2LT5kZXYsIHJlcyk7DQo+ICsJaTJjLT5yZWdzID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jl
c291cmNlKHBkZXYsIDApOw0KPiAgCWlmIChJU19FUlIoaTJjLT5yZWdzKSkNCj4gIAkJcmV0dXJu
IFBUUl9FUlIoaTJjLT5yZWdzKTsNCj4gDQo+IC0tDQo+IDIuNy40DQoNCg==
