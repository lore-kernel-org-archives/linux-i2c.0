From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 04/16] of: changesets: Introduce changeset helper
 methods
Date: Wed, 21 Feb 2018 09:23:44 -0600
Message-ID: <CAL_JsqJA=2JLqRfERJ1hN=ErUqw+xT8OhZVMjSVeRH4mgrE36Q@mail.gmail.com>
References: <20180220231046.32638-1-laurent.pinchart+renesas@ideasonboard.com>
 <20180220231046.32638-5-laurent.pinchart+renesas@ideasonboard.com>
 <CAMuHMdVJfKXWNFaN259JQ1bOVZQSbC-=u4Kmys2PE+HLa=xQKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAMuHMdVJfKXWNFaN259JQ1bOVZQSbC-=u4Kmys2PE+HLa=xQKw@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marek Vasut <marex@denx.de>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Wolfram Sang <wsa@the-dreams.de>, Koen Kooi <koen@dominion.thruhere.net>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>, Matt Porter <mporter@konsulko.com>, Frank Rowand <frowand.list@gmail.com>, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-i2c@vger.kernel.org

T24gV2VkLCBGZWIgMjEsIDIwMTggYXQgNDoyMSBBTSwgR2VlcnQgVXl0dGVyaG9ldmVuCjxnZWVy
dEBsaW51eC1tNjhrLm9yZz4gd3JvdGU6Cj4gSGkgTGF1cmVudCwKPgo+IE9uIFdlZCwgRmViIDIx
LCAyMDE4IGF0IDEyOjEwIEFNLCBMYXVyZW50IFBpbmNoYXJ0Cj4gPGxhdXJlbnQucGluY2hhcnQr
cmVuZXNhc0BpZGVhc29uYm9hcmQuY29tPiB3cm90ZToKPj4gRnJvbTogUGFudGVsaXMgQW50b25p
b3UgPHBhbnRlbGlzLmFudG9uaW91QGtvbnN1bGtvLmNvbT4KPj4KPj4gQ2hhbmdlc2V0cyBhcmUg
dmVyeSBwb3dlcmZ1bCwgYnV0IHRoZSBsYWNrIG9mIGEgaGVscGVyIEFQSQo+PiBtYWtlcyB1c2lu
ZyB0aGVtIGN1bWJlcnNvbWUuIEludHJvZHVjZSBhIHNpbXBsZSBjb3B5IGJhc2VkCj4+IEFQSSB0
aGF0IG1ha2VzIHRoaW5ncyBjb25zaWRlcmFibHkgZWFzaWVyLgo+Pgo+PiBUbyB3aXQsIGFkZGlu
ZyBhIHByb3BlcnR5IHVzaW5nIHRoZSByYXcgQVBJLgo+Pgo+PiAgICAgICAgIHN0cnVjdCBwcm9w
ZXJ0eSAqcHJvcDsKPj4gICAgICAgICBwcm9wID0ga3phbGxvYyhzaXplb2YoKnByb3ApKSwgR0ZQ
X0tFUk5FTCk7Cj4+ICAgICAgICAgcHJvcC0+bmFtZSA9IGtzdHJkdXAoImNvbXBhdGlibGUiKTsK
Pj4gICAgICAgICBwcm9wLT52YWx1ZSA9IGtzdHJkdXAoImZvbyxiYXIiKTsKPj4gICAgICAgICBw
cm9wLT5sZW5ndGggPSBzdHJsZW4ocHJvcC0+dmFsdWUpICsgMTsKPj4gICAgICAgICBvZl9jaGFu
Z2VzZXRfYWRkX3Byb3BlcnR5KG9jcywgbnAsIHByb3ApOwo+Pgo+PiB3aGlsZSB1c2luZyB0aGUg
aGVscGVyIEFQSQo+Pgo+PiAgICAgICAgIG9mX2NoYW5nZXNldF9hZGRfcHJvcGVydHlfc3RyaW5n
KG9jcywgbnAsICJjb21wYXRpYmxlIiwKPj4gICAgICAgICAgICAgICAgICAgICAgICAgImZvbyxi
YXIiKTsKPj4KPj4gU2lnbmVkLW9mZi1ieTogUGFudGVsaXMgQW50b25pb3UgPHBhbnRlbGlzLmFu
dG9uaW91QGtvbnN1bGtvLmNvbT4KPj4gW0ZpeGVkIG1lbW9yeSBsZWFrIGluIF9fb2ZfY2hhbmdl
c2V0X2FkZF91cGRhdGVfcHJvcGVydHlfY29weSgpXQo+PiBTaWduZWQtb2ZmLWJ5OiBMYXVyZW50
IFBpbmNoYXJ0IDxsYXVyZW50LnBpbmNoYXJ0K3JlbmVzYXNAaWRlYXNvbmJvYXJkLmNvbT4KPgo+
IFlvdSBtaXNzZWQgb25lIGZpeCBJIGhhdmUgaW4gbXkgdG9waWMvb3ZlcmxheXMgYnJhbmNoCj4g
aHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvZ2VlcnQvcmVu
ZXNhcy1kcml2ZXJzLmdpdC9jb21taXQvP2g9dG9waWMvb3ZlcmxheXMmaWQ9MTUwZjk1YjlkZWM3
N2NlMzcxYzIyOWY3YWM0ZDZkZDg2MjBiZWY0YQoKQXJlIHlvdSBwbGFubmluZyB0byB0cnkgdG8g
dXBzdHJlYW0gYWxsIHRoaXM/IElmIG5vdCwgSSdsbCBnZXQgRnJhbmsKdG8ga2VlcCBjaGFuZ2lu
ZyB0aGUgb3ZlcmxheSBBUEkgdG8gbWFrZSBjYXJyeWluZyBpdCBvdXQgb2YgdHJlZSBtb3JlCnBh
aW5mdWwuIDopCgpSb2IKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRl
dmVsCg==
