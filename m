From: Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 4/6] arm64/ls1043a: add DTS for Freescale LS1043A SoC
Date: Wed, 23 Sep 2015 03:05:20 +0000
Message-ID: <CY1PR0301MB07805FA01ACAF84648C806138B440@CY1PR0301MB0780.namprd03.prod.outlook.com>
References: <1442838158-2964-1-git-send-email-B48286@freescale.com>
 <1442838158-2964-5-git-send-email-B48286@freescale.com>
 <20150922012403.GA1535@svinekod>
 <CY1PR0301MB078008B10188504C951076498B450@CY1PR0301MB0780.namprd03.prod.outlook.com>
 <DM2PR0301MB07342356008C1A50AB26FEFFBA450@DM2PR0301MB0734.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <DM2PR0301MB07342356008C1A50AB26FEFFBA450-Cwg/PA1lyPnRfvLtmsd4/5wN6zqB+hSMnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
Content-Language: en-US
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Li Leo <LeoLi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "marc.zyngier-5wv7dgnIgG8@public.gmane.org" <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Shaohui Xie <Shaohui.Xie-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "corbet-T1hC0tSOHrs@public.gmane.org" <corbet-T1hC0tSOHrs@public.gmane.org>, Sharma Bhupesh <bhupesh.sharma-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org" <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org" <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Wenbin Song <Wenbin.Song-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Hu Vincent <Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGkgWWFuZy1MZW8tUjU4
NDcyDQo+IFNlbnQ6IDIwMTXE6jnUwjIzyNUgMToyMw0KPiBUbzogSG91IFpoaXFpYW5nLUI0ODI4
NjsgTWFyayBSdXRsYW5kOyBtYXJjLnp5bmdpZXJAYXJtLmNvbQ0KPiBDYzogbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBDYXRhbGluIE1hcmluYXM7IFdpbGwgRGVhY29uOw0K
PiBsaW51eC1pMmNAdmdlci5rZXJuZWwub3JnOyBsaW51eC13YXRjaGRvZ0B2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LQ0KPiBkb2NAdmdlci5rZXJuZWwub3JnOyBsaW51eC1jbGtAdmdlci5rZXJuZWwu
b3JnOyBYaWUgU2hhb2h1aS1CMjE5ODk7DQo+IGNvcmJldEBsd24ubmV0OyBTaGFybWEgQmh1cGVz
aC1CNDUzNzA7IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOyB3c2FAdGhlLQ0KPiBkcmVhbXMuZGU7
IHNib3lkQGNvZGVhdXJvcmEub3JnOyB3aW1AaWd1YW5hLmJlOyBTb25nIFdlbmJpbi1CNTM3NDc7
IFdvb2QNCj4gU2NvdHQtQjA3NDIxOyBIdSBNaW5na2FpLUIyMTI4NA0KPiBTdWJqZWN0OiBSRTog
W1BBVENIIDQvNl0gYXJtNjQvbHMxMDQzYTogYWRkIERUUyBmb3IgRnJlZXNjYWxlIExTMTA0M0Eg
U29DDQo+IA0KPiA+ID4NCj4gPiA+IEhpLA0KPiA+ID4NCj4gPiA+ID4gKy9tZW1yZXNlcnZlLyAw
eDgwMDAwMDAwIDB4MDAwMTAwMDA7DQo+ID4gPg0KPiA+ID4gV2h5IGlzIHRoaXMgbmVjZXNzYXJ5
Pw0KPiA+DQo+ID4gVGhpcyBtZW1vcnkgcmVnaW9uIGlzIHByZS1yZXNlcnZlZCBmb3IgdGhlIHNw
aW4tdGFibGUvcHNjaSwgYWx0aG91Z2gNCj4gPiBkaWRuJ3QgYWRkIEVuYWJsZSBtZXRob2Qgb2Yg
c2Vjb25kYXJ5IGNvcmVzLg0KPiANCj4gQ2FuIHRoaXMgYmUgcmVzZXJ2ZWQgYnkgYm9vdGxvYWRl
cj8NCg0KWWVzLCB0aGUgbWVtb3J5IGZvciBwc2NpIHdhcyByZXNlcnZlZCBieSB1LWJvb3QgY29k
ZS4gQnV0IGR1ZSB0byBzcGluLXRhYmxlDQpuZWVkIHRoZSByZWxlYXNlIGFkZHJlc3MsIGlzIGl0
IGJldHRlciBhZGRpbmcgdGhlIC9tZW1yZXNlcnZlLyBpbiBkdHMgZmlsZT8NCk9yIGFkZCBpdCBi
eSBib290bG9hZGVyIGFuZCBmaXggdGhlIHJlbGVhc2UgYWRkcmVzcyBhY2NvcmRpbmdseT8NCg0K
PiANCj4gPg0KPiA+ID4gSWYgdGhpcyBpcyBuZWNlc3NhcnksIHBsZWFzZSBhZGQgYSBjb21tZW50
IHN0YXRpbmcgd2hhdCB0aGlzIGlzIGZvci4NCj4gPiA+DQo+ID4gPiA+ICsgICAgICAgICAgICAg
ICBjcHVAMyB7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGRldmljZV90eXBlID0g
ImNwdSI7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYXJt
LGNvcnRleC1hNTMiOw0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHgw
IDB4Mz47DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGNsb2NrcyA9IDwmY2xvY2tn
ZW4gMSAwPjsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIH07DQo+ID4gPg0KPiA+ID4gTWlzc2lu
ZyBlbmFibGUtbWV0aG9kIHByb3BlcnRpZXMgb24gYWxsIHRoZSBzZWNvbmRhcnkgQ1BVcy4NCj4g
PiA+DQo+ID4NCj4gPiBUaGVyZSBhcmUgdHdvIG1ldGhvZHMgKHNwaW4tdGFibGUgYW5kIHBzY2kp
IHRvIGJyaW5nIHVwIHNlY29uZGFyeQ0KPiA+IGNvcmVzLCB3aGljaCBvbmUgZG8geW91IHRoaW5r
IGlzIGJldHRlcj8NCj4gDQo+IERvIHdlIGhhdmUgdGhlIFBTQ0kgc3VwcG9ydCByZWFkeSBpbiBi
b3RoIFVFRkkgYW5kIHUtYm9vdD8gIElmIG5vdCwgd2UNCj4gc2hvdWxkIHVzZSBzcGluLXRhYmxl
IGZvciBub3cuDQo+DQoNCm91ciBpbnRlcm5hbCB1LWJvb3Qgc3VwcG9ydHMgUFNDSSBidXQgb3Bl
bnNvdXJjZSBkb2Vzbid0IHN1cHBvcnQgaXQgZm9yIEFSTXY4Lg0KDQpUaGFua3MsDQpaaGlxaWFu
Zw0K
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
