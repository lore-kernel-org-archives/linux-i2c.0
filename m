From: Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH V3 4/6] arm64/ls1043a: add DTS for Freescale LS1043A SoC
Date: Thu, 15 Oct 2015 07:34:12 +0000
Message-ID: <CY1PR0301MB0780F8F64723E9FE9EFEB0DD8B3E0@CY1PR0301MB0780.namprd03.prod.outlook.com>
References: <1444822498-16477-1-git-send-email-B48286@freescale.com>
	 <1444822498-16477-5-git-send-email-B48286@freescale.com>
 <1444881407.5185.232.camel@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444881407.5185.232.camel-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Content-Language: en-US
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "catalin.marinas-5wv7dgnIgG8@public.gmane.org" <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Hu Vincent <Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shaohui Xie <Shaohui.Xie-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Sharma Bhupesh <bhupesh.sharma-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Li Leo <LeoLi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org" <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, "corbet-T1hC0tSOHrs@public.gmane.org" <corbet-T1hC0tSOHrs@public.gmane.org>, "mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org" <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Wenbin Song <Wenbin.Song-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0
MjENCj4gU2VudDogMjAxNeW5tDEw5pyIMTXml6UgMTE6NTcNCj4gVG86IEhvdSBaaGlxaWFuZy1C
NDgyODYNCj4gQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgY2F0YWxp
bi5tYXJpbmFzQGFybS5jb207DQo+IHdpbGwuZGVhY29uQGFybS5jb207IGxpbnV4LWkyY0B2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiB3YXRjaGRvZ0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWRv
Y0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBjbGtAdmdlci5rZXJuZWwub3JnOyBtYXJrLnJ1
dGxhbmRAYXJtLmNvbTsgSHUgTWluZ2thaS1CMjEyODQ7IFhpZQ0KPiBTaGFvaHVpLUIyMTk4OTsg
U2hhcm1hIEJodXBlc2gtQjQ1MzcwOyBMaSBZYW5nLUxlby1SNTg0NzI7IHdzYUB0aGUtDQo+IGRy
ZWFtcy5kZTsgd2ltQGlndWFuYS5iZTsgY29yYmV0QGx3bi5uZXQ7IG10dXJxdWV0dGVAYmF5bGli
cmUuY29tOw0KPiBzYm95ZEBjb2RlYXVyb3JhLm9yZzsgU29uZyBXZW5iaW4tQjUzNzQ3DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggVjMgNC82XSBhcm02NC9sczEwNDNhOiBhZGQgRFRTIGZvciBGcmVl
c2NhbGUgTFMxMDQzQQ0KPiBTb0MNCj4gDQo+IE9uIFdlZCwgMjAxNS0xMC0xNCBhdCAxOTozNCAr
MDgwMCwgWmhpcWlhbmcgSG91IHdyb3RlOg0KPiA+IEZyb206IE1pbmdrYWkgSHUgPE1pbmdrYWku
SHVAZnJlZXNjYWxlLmNvbT4NCj4gPg0KPiA+IExTMTA0M2EgaXMgYW4gU29DIHdpdGggNCBBUk12
OCBBNTMgY29yZXMgYW5kIG1vc3Qgb3RoZXIgSVAgYmxvY2tzDQo+ID4gc2ltaWxhciB0byBMUzEw
MjFhIHdoaWNoIGNvbXBsaWVzIHRvIENoYXNzaXMgMi4xIHNwZWMuDQo+ID4NCj4gPiBGb2xsb3dp
bmcgbGV2ZWxzIG9mIERUU0kvRFRTIGZpbGVzIGhhdmUgYmVlbiBjcmVhdGVkIGZvciB0aGUgTFMx
MDQzQQ0KPiA+IFNvQyBmYW1pbHk6DQo+ID4NCj4gPiAtIGZzbC1sczEwNDNhLmR0c2k6DQo+ID4g
ICBEVFMtSW5jbHVkZSBmaWxlIGZvciBGU0wgTFMxMDQzQSBTb0MuDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBMaSBZYW5nIDxsZW9saUBmcmVlc2NhbGUuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IEhvdSBaaGlxaWFuZyA8QjQ4Mjg2QGZyZWVzY2FsZS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTog
TWluZ2thaSBIdSA8TWluZ2thaS5IdUBmcmVlc2NhbGUuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFdlbmJpbiBTb25nIDxXZW5iaW4uU29uZ0BmcmVlc2NhbGUuY29tPg0KPiA+IC0tLQ0KPiA+IFYz
Og0KPiA+ICAtIEFkZCBkZXZpY2UgdHJlZSBub2RlIGZvciBTQVRBLg0KPiA+ICAtIFJlbW92ZSBw
cm9wZXJpdHkgZW5hYmxlLW1ldGhvZCBmb3IgYWxsIGNwdSBub2RlLg0KPiA+ICAgIFJlbW92ZSBy
ZXNlcnZlZCBtZW1vcnkgcmVnaW9uIGZvciBzcGluLXRhYmxlLg0KPiA+DQo+ID4gVjI6DQo+ID4g
IC0gQWRkIHNlY29uZGFyeSBjb3JlIGJvb3QgbWV0aG9kLg0KPiA+ICAtIE1vdmUgb3V0IHRoZSBz
eXNjbGsgbm9kZSBmcm9tIHRoZSBjbG9ja2dlbiBub2RlLg0KPiA+ICAtIENvcnJlY3QgdGhlIHJl
ZyBzaXplIG9mIEdJQ0MuDQo+ID4NCj4gPiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
ZnNsLWxzMTA0M2EuZHRzaSB8IDUxMw0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysNCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDUxMyBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEw
MDY0NCBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDQzYS5kdHNpDQo+IA0K
PiBPbiB0aGUgbHMyMDh4IGRldmljZSB0cmVlIHdlIHdlcmUgYXNrZWQgdG8gcHV0IGRldmljZXMg
dW5kZXIgYSBidXMgbm9kZSwNCj4gc3VjaCBhcyBhbiBzb2Mgbm9kZSB3aXRoIGEgc2ltcGxlLWJ1
cyBjb21wYXRpYmxlLg0KPiANCg0KVGhhbmtzLCB3aWxsIHJlZm9ybS4NCg0KVGhhbmtzLA0KWmhp
cWlhbmcNCg==
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
