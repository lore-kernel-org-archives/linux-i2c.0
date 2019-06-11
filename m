From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] i2c: mux: Use struct_size() in devm_kzalloc()
Date: Tue, 11 Jun 2019 07:12:04 +0000
Message-ID: <a7851536-52dc-367e-ffc2-88f49f96bd00@axentia.se>
References: <20190529162014.GA27389@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190529162014.GA27389@embeddedor>
Content-Language: en-US
Content-ID: <BB133A1904977940BF87507E3FC30B92@eurprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

T24gMjAxOS0wNS0yOSAxODoyMCwgR3VzdGF2byBBLiBSLiBTaWx2YSB3cm90ZToNCj4gT25lIG9m
IHRoZSBtb3JlIGNvbW1vbiBjYXNlcyBvZiBhbGxvY2F0aW9uIHNpemUgY2FsY3VsYXRpb25zIGlz
IGZpbmRpbmcNCj4gdGhlIHNpemUgb2YgYSBzdHJ1Y3R1cmUgdGhhdCBoYXMgYSB6ZXJvLXNpemVk
IGFycmF5IGF0IHRoZSBlbmQsIGFsb25nDQo+IHdpdGggbWVtb3J5IGZvciBzb21lIG51bWJlciBv
ZiBlbGVtZW50cyBmb3IgdGhhdCBhcnJheS4gRm9yIGV4YW1wbGU6DQo+IA0KPiBzdHJ1Y3QgZm9v
IHsNCj4gICAgIGludCBzdHVmZjsNCj4gICAgIHN0cnVjdCBib28gZW50cnlbXTsNCj4gfTsNCj4g
DQo+IGluc3RhbmNlID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKHN0cnVjdCBmb28pICsgY291
bnQgKiBzaXplb2Yoc3RydWN0IGJvbyksIEdGUF9LRVJORUwpOw0KPiANCj4gSW5zdGVhZCBvZiBs
ZWF2aW5nIHRoZXNlIG9wZW4tY29kZWQgYW5kIHByb25lIHRvIHR5cGUgbWlzdGFrZXMsIHdlIGNh
bg0KPiBub3cgdXNlIHRoZSBuZXcgc3RydWN0X3NpemUoKSBoZWxwZXI6DQo+IA0KPiBpbnN0YW5j
ZSA9IGRldm1fa3phbGxvYyhkZXYsIHN0cnVjdF9zaXplKGluc3RhbmNlLCBlbnRyeSwgY291bnQp
LCBHRlBfS0VSTkVMKTsNCj4gDQo+IFRoaXMgY29kZSB3YXMgZGV0ZWN0ZWQgd2l0aCB0aGUgaGVs
cCBvZiBDb2NjaW5lbGxlLg0KDQpUaGFua3MsIHBhdGNoIGFwcGxpZWQgdG8gaTJjLW11eC9mb3It
bmV4dA0KDQpDaGVlcnMsDQpQZXRlcg0K
