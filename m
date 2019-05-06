From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [EXT] Re: [PATCH 1/2] i2c: imx: I2C Driver doesn't consider
 I2C_IPGCLK_SEL RCW bit when using ls1046a SoC
Date: Mon, 6 May 2019 09:37:35 +0200
Message-ID: <20190506073735.ctzybytamu44pbvv@pengutronix.de>
References: <20190430044719.30720-1-chuanhua.han@nxp.com>
 <20190430125043.weqwzim4gpsvtkfe@pengutronix.de>
 <AM6PR04MB43571B8D52C1FE9ED20DBA1D97360@AM6PR04MB4357.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <AM6PR04MB43571B8D52C1FE9ED20DBA1D97360@AM6PR04MB4357.eurprd04.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chuanhua Han <chuanhua.han@nxp.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sumit Batra <sumit.batra@nxp.com>, "eha@deif.com" <eha@deif.com>, "festevam@gmail.com" <festevam@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Leo Li <leoyang.li@nxp.com>, "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "linux@rempel-privat.de" <linux@rempel-privat.de>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "peda@axentia.se" <peda@axentia.se>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-i2c@vger.kernel.org

T24gU2F0LCBNYXkgMDQsIDIwMTkgYXQgMDk6Mjg6NDhBTSArMDAwMCwgQ2h1YW5odWEgSGFuIHdy
b3RlOgo+IAo+IAo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPiA+IEZyb206IFNhc2No
YSBIYXVlciA8cy5oYXVlckBwZW5ndXRyb25peC5kZT4KPiA+IFNlbnQ6IDIwMTnlubQ05pyIMzDm
l6UgMjA6NTEKPiA+IFRvOiBDaHVhbmh1YSBIYW4gPGNodWFuaHVhLmhhbkBueHAuY29tPgo+ID4g
Q2M6IHNoYXduZ3VvQGtlcm5lbC5vcmc7IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPjsgcm9i
aCtkdEBrZXJuZWwub3JnOwo+ID4gbWFyay5ydXRsYW5kQGFybS5jb207IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7Cj4gPiBsaW51eC1pMmNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7Cj4gPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsgZmVzdGV2YW1AZ21haWwuY29tOyBkbC1saW51eC1pbXgKPiA+IDxsaW51eC1pbXhAbnhwLmNv
bT47IHdzYStyZW5lc2FzQHNhbmctZW5naW5lZXJpbmcuY29tOwo+ID4gdS5rbGVpbmUta29lbmln
QHBlbmd1dHJvbml4LmRlOyBlaGFAZGVpZi5jb207IGxpbnV4QHJlbXBlbC1wcml2YXQuZGU7Cj4g
PiBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOyBwZWRhQGF4ZW50aWEuc2U7IFN1bWl0IEJhdHJhCj4g
PiA8c3VtaXQuYmF0cmFAbnhwLmNvbT4KPiA+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0ggMS8y
XSBpMmM6IGlteDogSTJDIERyaXZlciBkb2Vzbid0IGNvbnNpZGVyCj4gPiBJMkNfSVBHQ0xLX1NF
TCBSQ1cgYml0IHdoZW4gdXNpbmcgbHMxMDQ2YSBTb0MKPiA+IAo+ID4gQ2F1dGlvbjogRVhUIEVt
YWlsCj4gPiAKPiA+IE9uIFR1ZSwgQXByIDMwLCAyMDE5IGF0IDEyOjQ3OjE4UE0gKzA4MDAsIENo
dWFuaHVhIEhhbiB3cm90ZToKPiA+ID4gVGhlIGN1cnJlbnQga2VybmVsIGRyaXZlciBkb2VzIG5v
dCBjb25zaWRlciBJMkNfSVBHQ0xLX1NFTCAoNDI0IGJpdCBvZgo+ID4gPiBSQ1cpIGluIGRlY2lk
aW5nICBpMmNfY2xrX3JhdGUgaW4gZnVuY3Rpb24gaTJjX2lteF9zZXRfY2xrKCkgeyAwCj4gPiA+
IFBsYXRmb3JtIGNsb2NrLzQsIDEgUGxhdGZvcm0gY2xvY2svMn0uCj4gPiA+Cj4gPiA+IFdoZW4g
dXNpbmcgbHMxMDQ2YSBTb0MsIHRoaXMgcG9wdWxhdGVzIGluY29ycmVjdCB2YWx1ZSBpbiBJQkZE
Cj4gPiA+IHJlZ2lzdGVyIGlmIEkyQ19JUEdDTEtfU0VMID0gMCwgd2hpY2ggZ2VuZXJhdGVzIGhh
bGYgb2YgdGhlIGRlc2lyZWQgQ2xvY2suCj4gPiA+Cj4gPiA+IFRoZXJlZm9yZSwgaWYgbHMxMDQ2
YSBTb0MgaXMgdXNlZCwgd2UgbmVlZCB0byBzZXQgdGhlIGkyYyBjbG9jawo+ID4gPiBhY2NvcmRp
bmcgdG8gdGhlIGNvcnJlc3BvbmRpbmcgUkNXLgo+ID4gCj4gPiBTbyB0aGUgY2xvY2sgZHJpdmVy
IHJlcG9ydHMgdGhlIHdyb25nIGNsb2NrLiBQbGVhc2UgZml4IHRoZSBjbG9jayBkcml2ZXIgdGhl
bi4KPiBObywgdGhpcyBpcyBhIHByb2JsZW0gd2l0aCB0aGUgaTJjIGRyaXZlci4gSXQgaXMgbm90
IGEgcHJvYmxlbSB3aXRoCj4gdGhlIGNsb2NrIGRyaXZlciwgc28gdGhlIGkyYyBkcml2ZXIgbmVl
ZHMgdG8gYmUgbW9kaWZpZWQuCgpTbyBob3cgZG9lcyB0aGlzIFJDVyBiaXQgZ2V0IGV2YWx1YXRl
ZD8gQWNjb3JkaW5nIHRvIHRoZSByZWZlcmVuY2UKbWFudWFsIG9ubHkgb25lIGNsb2NrIGdvZXMg
dG8gdGhlIGkyYyBtb2R1bGUgKGRlc2NyaWJlZCBhcyAxLzIgUGxhdGZvcm0KQ2xvY2spIGFuZCB0
aGUgaTJjIG1vZHVsZSBvbmx5IHRha2VzIG9uZSBjbG9jay4gU28gaXQgc2VlbXMgdGhlcmUgbXVz
dApiZSBhIC8yIGRpdmlkZXIgc29tZXdoZXJlLCBlaXRoZXIgaW4gZWFjaCBpMmMgbW9kdWxlIG9y
IHNvbWV3aGVyZQpvdXRzaWRlLiBDYW4geW91ciBJQyBndXlzIHRlbGwgeW91IHdoZXJlIGl0IGlz
PwoKT25lIHJlYXNvbiBJIHN1Z2dlc3RlZCB0aGUgY2xvY2sgZHJpdmVyIGlzIHRoYXQgdGhlIGNs
b2NrIGRyaXZlcgpjb250YWlucyBTb0Mgc3BlY2lmaWMgY29kZSBhbHJlYWR5LCBzbyBpdCBzaG91
bGQgYmUgZWFzaWVyIHRvIGludGVncmF0ZQp0aGVyZS4KClNhc2NoYQoKCi0tIApQZW5ndXRyb25p
eCBlLksuICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfApJbmR1c3RyaWFsIExpbnV4IFNvbHV0aW9ucyAgICAgICAgICAgICAgICAgfCBodHRw
Oi8vd3d3LnBlbmd1dHJvbml4LmRlLyAgfApQZWluZXIgU3RyLiA2LTgsIDMxMTM3IEhpbGRlc2hl
aW0sIEdlcm1hbnkgfCBQaG9uZTogKzQ5LTUxMjEtMjA2OTE3LTAgICAgfApBbXRzZ2VyaWNodCBI
aWxkZXNoZWltLCBIUkEgMjY4NiAgICAgICAgICAgfCBGYXg6ICAgKzQ5LTUxMjEtMjA2OTE3LTU1
NTUgfAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGlu
dXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
YXJtLWtlcm5lbAo=
