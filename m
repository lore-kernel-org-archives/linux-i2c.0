From: Tang Yuantian-B29983 <B29983-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH] i2c/busses: (mpc) Add support for SMBUS_READ_BLOCK_DATA
Date: Fri, 18 Nov 2011 03:15:39 +0000
Message-ID: <3C06C26914DACA4BB3A368F78CA0B3A712BAB1@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1321338462-6138-1-git-send-email-guenter.roeck@ericsson.com>
	 <CAOZdJXUPO5PyMkAw-2EPvy_qSUuqsgUA7Gr8mKUX7HyShoXk3g@mail.gmail.com>
	 <E6AF40B3BFC8A9428EACB47497F0F4B62DC687@039-SN1MPN1-002.039d.mgd.msft.net>
	 <ECEE0D23-8F53-402C-A97F-4DB0F0E9C79B@freescale.com>
	 <1321464509.7847.41.camel@oslab-l1>
	 <1321464968.2309.384.camel@groeck-laptop>
	 <1321466135.7847.55.camel@oslab-l1>
	 <20111116190954.67c846fc@endymion.delvare>
	 <1321467638.7847.73.camel@oslab-l1>
	 <20111116201048.4b7877dd@endymion.delvare>
	 <1321470915.7847.122.camel@oslab-l1>
	 <20111116201847.6b11dc7f@endymion.delvare>
	 <1321471473.7847.126.camel@oslab-l1> <1321553924.2730.7.camel@groeck-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1321553924.2730.7.camel@groeck-laptop>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org" <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Tabi Timur-B04825 <B04825-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, sun york-R58495 <R58495-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

SSBoYXZlIHRlc3RlZCB0aGlzIHBhdGNoLiBJdCB3b3JrcyBvbiBwMTAyMmRzIHBsYXRmb3JtLg0K
VGhhbmtzLg0KDQpSZWdhcmRzLA0KWXVhbnRpYW4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiBGcm9tOiBHdWVudGVyIFJvZWNrIFttYWlsdG86Z3VlbnRlci5yb2Vja0Blcmljc3Nv
bi5jb21dDQo+IFNlbnQ6IDIwMTHlubQxMeaciDE45pelIDI6MTkNCj4gVG86IHN1biB5b3JrLVI1
ODQ5NQ0KPiBDYzogSmVhbiBEZWx2YXJlOyBUYWJpIFRpbXVyLUIwNDgyNTsgbGludXgtaTJjQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFRhbmcgWXVh
bnRpYW4tQjI5OTgzDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGkyYy9idXNzZXM6IChtcGMpIEFk
ZCBzdXBwb3J0IGZvcg0KPiBTTUJVU19SRUFEX0JMT0NLX0RBVEENCj4gDQo+IElmIHlvdSBsb29r
IGNsb3NlbHksIHlvdSBtYXkgcmVhbGl6ZSB0aGF0IHRoZSBtcGNfcmVhZCBhbHNvIGRvZXNuJ3QN
Cj4gdmFsaWRhdGUgb2YgYW55IG9mIHRoZSBvdGhlciBwYXJhbWV0ZXJzLiBBcmUgeW91IGdvaW5n
IHRvIHJlcXVlc3QgdGhhdA0KPiBzdWNoIHZhbGlkYXRpb25zIGJlIGFkZGVkIGFzIHdlbGwgPyBI
b3cgYWJvdXQgdGhlIG90aGVyIGZ1bmN0aW9ucyBpbiB0aGlzDQo+IGRyaXZlciA/IFNob3VsZCBl
YWNoIGZ1bmN0aW9uIGFsc28gdmFsaWRhdGUgZWFjaCBvZiBpdHMgcGFyYW1ldGVycyA/IElmDQo+
IG5vdCwgd2hlcmUgZG8geW91IGRyYXcgdGhlIGxpbmUgPw0KPiANCj4gQmVzaWRlcywgdGhlIGNh
bGxlciBpcyB0aGUgU01CdXMgYmxvY2sgcmVhZCBmdW5jdGlvbiwgd2hpY2ggZG9lcyBrbm93DQo+
IHRoYXQgU01CdXMgYmxvY2sgcmVhZHMgYXJlIGxpbWl0ZWQgdG8gMzIgYnl0ZXMgKHBsdXMgbGVu
Z3RoKS4NCj4gDQo+IEd1ZW50ZXINCj4gDQo+IA0KDQo=
