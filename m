From: Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 6/6] dts/ls1043a: add LS1043ARDB board support
Date: Tue, 22 Sep 2015 09:51:57 +0000
Message-ID: <CY1PR0301MB0780643BCCE3A5C6BAEA22218B450@CY1PR0301MB0780.namprd03.prod.outlook.com>
References: <1442838158-2964-1-git-send-email-B48286@freescale.com>
	 <1442838158-2964-7-git-send-email-B48286@freescale.com>
 <1442877225.19102.207.camel@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442877225.19102.207.camel-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Content-Language: en-US
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "catalin.marinas-5wv7dgnIgG8@public.gmane.org" <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org" <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, "corbet-T1hC0tSOHrs@public.gmane.org" <corbet-T1hC0tSOHrs@public.gmane.org>, "mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org" <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Hu Vincent <Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shaohui Xie <Shaohui.Xie-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Wenbin Song <Wenbin.Song-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Sharma Bhupesh <bhupesh.sharma-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Li Leo <LeoLi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

SGkgU2NvdHQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBT
Y290dC1CMDc0MjENCj4gU2VudDogMjAxNeW5tDnmnIgyMuaXpSA3OjE0DQo+IFRvOiBIb3UgWmhp
cWlhbmctQjQ4Mjg2DQo+IENjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOw0KPiB3aWxsLmRlYWNvbkBhcm0uY29tOyBsaW51eC1p
MmNAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gd2F0Y2hkb2dAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1kb2NAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gY2xrQHZnZXIua2VybmVsLm9yZzsg
d3NhQHRoZS1kcmVhbXMuZGU7IHdpbUBpZ3VhbmEuYmU7IGNvcmJldEBsd24ubmV0Ow0KPiBtdHVy
cXVldHRlQGJheWxpYnJlLmNvbTsgc2JveWRAY29kZWF1cm9yYS5vcmc7IEh1IE1pbmdrYWktQjIx
Mjg0OyBYaWUNCj4gU2hhb2h1aS1CMjE5ODk7IFNvbmcgV2VuYmluLUI1Mzc0NzsgU2hhcm1hIEJo
dXBlc2gtQjQ1MzcwOyBMaSBZYW5nLUxlby0NCj4gUjU4NDcyDQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggNi82XSBkdHMvbHMxMDQzYTogYWRkIExTMTA0M0FSREIgYm9hcmQgc3VwcG9ydA0KPiANCj4g
T24gTW9uLCAyMDE1LTA5LTIxIGF0IDIwOjIyICswODAwLCBaaGlxaWFuZyBIb3Ugd3JvdGU6DQo+
IA0KPiA+ICsgICAgICAgICAgICAgY3BsZDogYm9hcmQtY29udHJvbEAyLDAgew0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImZzbCxsczEwNDNhcmRiLWNwbGQiLCAic2lt
cGxlLWJ1cyI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweDIgMHgwIDB4MDAw
MDEwMD47DQo+ID4gKyAgICAgICAgICAgICB9Ow0KPiANCj4gQWdhaW4sIHdoeSAic2ltcGxlLWJ1
cyI/DQoNClRoYW5rcyBhbmQgd2lsbCByZW1vdmUgaXQgaW4gdjIuDQoNClRoYW5rcywNClpoaXFp
YW5nDQo=
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
