From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 04/16] of: changesets: Introduce changeset helper
 methods
Date: Wed, 21 Feb 2018 17:14:51 -0600
Message-ID: <CAL_JsqKHc=PtLTeihg0wk5o3YxHvLAGA44xCp5jpSXm=Wcit3A@mail.gmail.com>
References: <20180220231046.32638-1-laurent.pinchart+renesas@ideasonboard.com>
 <20180220231046.32638-5-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180220231046.32638-5-laurent.pinchart+renesas@ideasonboard.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Koen Kooi <koen@dominion.thruhere.net>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:MEDIA DRIVERS FOR RENESAS - FCP" <linux-renesas-soc@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>, Matt Porter <mporter@konsulko.com>, Frank Rowand <frowand.list@gmail.com>, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-i2c@vger.kernel.org

T24gVHVlLCBGZWIgMjAsIDIwMTggYXQgNToxMCBQTSwgTGF1cmVudCBQaW5jaGFydAo8bGF1cmVu
dC5waW5jaGFydCtyZW5lc2FzQGlkZWFzb25ib2FyZC5jb20+IHdyb3RlOgo+IEZyb206IFBhbnRl
bGlzIEFudG9uaW91IDxwYW50ZWxpcy5hbnRvbmlvdUBrb25zdWxrby5jb20+Cj4KPiBDaGFuZ2Vz
ZXRzIGFyZSB2ZXJ5IHBvd2VyZnVsLCBidXQgdGhlIGxhY2sgb2YgYSBoZWxwZXIgQVBJCj4gbWFr
ZXMgdXNpbmcgdGhlbSBjdW1iZXJzb21lLiBJbnRyb2R1Y2UgYSBzaW1wbGUgY29weSBiYXNlZAo+
IEFQSSB0aGF0IG1ha2VzIHRoaW5ncyBjb25zaWRlcmFibHkgZWFzaWVyLgo+Cj4gVG8gd2l0LCBh
ZGRpbmcgYSBwcm9wZXJ0eSB1c2luZyB0aGUgcmF3IEFQSS4KPgo+ICAgICAgICAgc3RydWN0IHBy
b3BlcnR5ICpwcm9wOwo+ICAgICAgICAgcHJvcCA9IGt6YWxsb2Moc2l6ZW9mKCpwcm9wKSksIEdG
UF9LRVJORUwpOwo+ICAgICAgICAgcHJvcC0+bmFtZSA9IGtzdHJkdXAoImNvbXBhdGlibGUiKTsK
PiAgICAgICAgIHByb3AtPnZhbHVlID0ga3N0cmR1cCgiZm9vLGJhciIpOwo+ICAgICAgICAgcHJv
cC0+bGVuZ3RoID0gc3RybGVuKHByb3AtPnZhbHVlKSArIDE7Cj4gICAgICAgICBvZl9jaGFuZ2Vz
ZXRfYWRkX3Byb3BlcnR5KG9jcywgbnAsIHByb3ApOwo+Cj4gd2hpbGUgdXNpbmcgdGhlIGhlbHBl
ciBBUEkKPgo+ICAgICAgICAgb2ZfY2hhbmdlc2V0X2FkZF9wcm9wZXJ0eV9zdHJpbmcob2NzLCBu
cCwgImNvbXBhdGlibGUiLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICJmb28sYmFyIik7Cj4K
PiBTaWduZWQtb2ZmLWJ5OiBQYW50ZWxpcyBBbnRvbmlvdSA8cGFudGVsaXMuYW50b25pb3VAa29u
c3Vsa28uY29tPgo+IFtGaXhlZCBtZW1vcnkgbGVhayBpbiBfX29mX2NoYW5nZXNldF9hZGRfdXBk
YXRlX3Byb3BlcnR5X2NvcHkoKV0KPiBTaWduZWQtb2ZmLWJ5OiBMYXVyZW50IFBpbmNoYXJ0IDxs
YXVyZW50LnBpbmNoYXJ0K3JlbmVzYXNAaWRlYXNvbmJvYXJkLmNvbT4KPiAtLS0KPiAgZHJpdmVy
cy9vZi9keW5hbWljLmMgfCAyMjIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+
ICBpbmNsdWRlL2xpbnV4L29mLmggICB8IDMyOCArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysKPiAgMiBmaWxlcyBjaGFuZ2VkLCA1NTAgaW5zZXJ0aW9u
cygrKQoKT3RoZXIgdGhhbiB3aGF0IEdlZXJ0IHBvaW50ZWQgb3V0LAoKUmV2aWV3ZWQtYnk6IFJv
YiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2RyaS1kZXZlbAo=
