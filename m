From: Chuanhua Han <chuanhua.han@nxp.com>
Subject: RE: [EXT] Re: [PATCH 1/2] i2c: imx: I2C Driver doesn't consider
 I2C_IPGCLK_SEL RCW bit when using ls1046a SoC
Date: Sat, 4 May 2019 09:28:48 +0000
Message-ID: <AM6PR04MB43571B8D52C1FE9ED20DBA1D97360@AM6PR04MB4357.eurprd04.prod.outlook.com>
References: <20190430044719.30720-1-chuanhua.han@nxp.com>
 <20190430125043.weqwzim4gpsvtkfe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190430125043.weqwzim4gpsvtkfe@pengutronix.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sumit Batra <sumit.batra@nxp.com>, "eha@deif.com" <eha@deif.com>, "festevam@gmail.com" <festevam@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Leo Li <leoyang.li@nxp.com>, "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "linux@rempel-privat.de" <linux@rempel-privat.de>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "peda@axentia.se" <peda@axentia.se>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-i2c@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2FzY2hhIEhhdWVyIDxz
LmhhdWVyQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiAyMDE5xOo01MIzMMjVIDIwOjUxDQo+IFRv
OiBDaHVhbmh1YSBIYW4gPGNodWFuaHVhLmhhbkBueHAuY29tPg0KPiBDYzogc2hhd25ndW9Aa2Vy
bmVsLm9yZzsgTGVvIExpIDxsZW95YW5nLmxpQG54cC5jb20+OyByb2JoK2R0QGtlcm5lbC5vcmc7
DQo+IG1hcmsucnV0bGFuZEBhcm0uY29tOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0K
PiBsaW51eC1pMmNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBmZXN0ZXZhbUBnbWFpbC5j
b207IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+OyB3c2ErcmVuZXNhc0BzYW5n
LWVuZ2luZWVyaW5nLmNvbTsNCj4gdS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlOyBlaGFA
ZGVpZi5jb207IGxpbnV4QHJlbXBlbC1wcml2YXQuZGU7DQo+IGwuc3RhY2hAcGVuZ3V0cm9uaXgu
ZGU7IHBlZGFAYXhlbnRpYS5zZTsgU3VtaXQgQmF0cmENCj4gPHN1bWl0LmJhdHJhQG54cC5jb20+
DQo+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0ggMS8yXSBpMmM6IGlteDogSTJDIERyaXZlciBk
b2Vzbid0IGNvbnNpZGVyDQo+IEkyQ19JUEdDTEtfU0VMIFJDVyBiaXQgd2hlbiB1c2luZyBsczEw
NDZhIFNvQw0KPiANCj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+IA0KPiBPbiBUdWUsIEFwciAzMCwg
MjAxOSBhdCAxMjo0NzoxOFBNICswODAwLCBDaHVhbmh1YSBIYW4gd3JvdGU6DQo+ID4gVGhlIGN1
cnJlbnQga2VybmVsIGRyaXZlciBkb2VzIG5vdCBjb25zaWRlciBJMkNfSVBHQ0xLX1NFTCAoNDI0
IGJpdCBvZg0KPiA+IFJDVykgaW4gZGVjaWRpbmcgIGkyY19jbGtfcmF0ZSBpbiBmdW5jdGlvbiBp
MmNfaW14X3NldF9jbGsoKSB7IDANCj4gPiBQbGF0Zm9ybSBjbG9jay80LCAxIFBsYXRmb3JtIGNs
b2NrLzJ9Lg0KPiA+DQo+ID4gV2hlbiB1c2luZyBsczEwNDZhIFNvQywgdGhpcyBwb3B1bGF0ZXMg
aW5jb3JyZWN0IHZhbHVlIGluIElCRkQNCj4gPiByZWdpc3RlciBpZiBJMkNfSVBHQ0xLX1NFTCA9
IDAsIHdoaWNoIGdlbmVyYXRlcyBoYWxmIG9mIHRoZSBkZXNpcmVkIENsb2NrLg0KPiA+DQo+ID4g
VGhlcmVmb3JlLCBpZiBsczEwNDZhIFNvQyBpcyB1c2VkLCB3ZSBuZWVkIHRvIHNldCB0aGUgaTJj
IGNsb2NrDQo+ID4gYWNjb3JkaW5nIHRvIHRoZSBjb3JyZXNwb25kaW5nIFJDVy4NCj4gDQo+IFNv
IHRoZSBjbG9jayBkcml2ZXIgcmVwb3J0cyB0aGUgd3JvbmcgY2xvY2suIFBsZWFzZSBmaXggdGhl
IGNsb2NrIGRyaXZlciB0aGVuLg0KTm8sIHRoaXMgaXMgYSBwcm9ibGVtIHdpdGggdGhlIGkyYyBk
cml2ZXIuIEl0IGlzIG5vdCBhIHByb2JsZW0gd2l0aCB0aGUgY2xvY2sgZHJpdmVyLCBzbyB0aGUg
aTJjIGRyaXZlciBuZWVkcyB0byBiZSBtb2RpZmllZC4NCj4gDQo+IFNhc2NoYQ0KPiANCj4gLS0N
Cj4gUGVuZ3V0cm9uaXggZS5LLiAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4gfA0KPiBJ
bmR1c3RyaWFsIExpbnV4IFNvbHV0aW9ucyAgICAgICAgICAgICAgICAgfA0KPiBodHRwczovL2V1
cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRnd3
dy5wZQ0KPiBuZ3V0cm9uaXguZGUlMkYmYW1wO2RhdGE9MDIlN0MwMSU3Q2NodWFuaHVhLmhhbiU0
MG54cC5jb20lN0MyYmINCj4gYTg5YzkwOGZiNGJkMzdiNjcwOGQ2Y2Q2YTdmZjclN0M2ODZlYTFk
M2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNQ0KPiAlN0MwJTdDMCU3QzYzNjkyMjI1NDYyNTQ3MjAz
NyZhbXA7c2RhdGE9ZUM0YkdETkFPaEV1MjR4dDlGMGgNCj4ga3hFJTJCMWZmb29DWjRDVXI0bzBn
UUdENCUzRCZhbXA7cmVzZXJ2ZWQ9MCAgfA0KPiBQZWluZXIgU3RyLiA2LTgsIDMxMTM3IEhpbGRl
c2hlaW0sIEdlcm1hbnkgfCBQaG9uZTogKzQ5LTUxMjEtMjA2OTE3LTANCj4gfA0KPiBBbXRzZ2Vy
aWNodCBIaWxkZXNoZWltLCBIUkEgMjY4NiAgICAgICAgICAgfCBGYXg6DQo+ICs0OS01MTIxLTIw
NjkxNy01NTU1IHwNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LWFybS1rZXJuZWwK
