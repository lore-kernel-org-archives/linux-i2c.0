From: Li Leo <LeoLi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 4/6] arm64/ls1043a: add DTS for Freescale LS1043A SoC
Date: Tue, 22 Sep 2015 22:39:16 +0000
Message-ID: <DM2PR0301MB07348FE1F1D12B19FF5084EEBA450@DM2PR0301MB0734.namprd03.prod.outlook.com>
References: <1442838158-2964-1-git-send-email-B48286@freescale.com>
 <1442838158-2964-5-git-send-email-B48286@freescale.com>
 <20150922012403.GA1535@svinekod>
 <CY1PR0301MB078008B10188504C951076498B450@CY1PR0301MB0780.namprd03.prod.outlook.com>
 <20150922221504.GA1497@svinekod>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150922221504.GA1497@svinekod>
Content-Language: en-US
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Kushwaha Prabhakar <prabhakar-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Shaohui Xie <Shaohui.Xie-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "corbet-T1hC0tSOHrs@public.gmane.org" <corbet-T1hC0tSOHrs@public.gmane.org>, Sharma Bhupesh <bhupesh.sharma-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org" <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org" <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Wenbin Song <Wenbin.Song-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Hu Vincent <Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

DQo+ID4gPiA+ICsgICAgICAgaWZjOiBpZmNAMTUzMDAwMCB7DQo+ID4gPiA+ICsgICAgICAgICAg
ICAgICBjb21wYXRpYmxlID0gImZzbCxpZmMiLCAic2ltcGxlLWJ1cyI7DQo+ID4gPiA+ICsgICAg
ICAgICAgICAgICByZWcgPSA8MHgwIDB4MTUzMDAwMCAweDAgMHgxMDAwMD47DQo+ID4gPiA+ICsg
ICAgICAgICAgICAgICBpbnRlcnJ1cHRzID0gPDAgNDMgMHg0PjsNCj4gPiA+ID4gKyAgICAgICB9
Ow0KPiA+ID4NCj4gPiA+IFdoeSBzaW1wbGUtYnVzPw0KPiA+DQo+ID4gVGhlcmUgYXJlIDMgY2hp
bGQgbm9kZSBsb2NhdGVkIGluIGR0c2kgZmlsZSB0aGF0IHNob3VsZCBiZSBjcmVhdGVkIGFuZA0K
PiA+IGFkZGVkIHRvIHBsYXRmb3JtIGRldmljZSBsaXN0Lg0KPiANCj4gQXJlIHRoZXkgdXNhYmxl
IGV2ZW4gaWYgdGhlIGtlcm5lbCBrbmV3IG5vdGhpbmcgYWJvdXQgdGhlIElGQyBub2RlPyBJZiBu
b3QsIHRoZQ0KPiBJRkMgZHJpdmVyIHNob3VsZCBwcm9iZSB0aGVtLCBhbmQgc2ltcGxlLWJ1cyBz
aG91bGQgZ28uDQoNCkFkZGluZyB0aGUgSUZDIGRyaXZlciBvd25lciB0byB0aGUgbG9vcC4NCg0K
UmVnYXJkcywNCkxlbw0K
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
