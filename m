From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v5 6/8] i2c: demux: Use changeset helpers for clarity
Date: Thu, 22 Feb 2018 12:19:32 +0200
Message-ID: <2195898.2J8Qfnu3DQ@avalon>
References: <20180222000531.19448-1-laurent.pinchart+renesas@ideasonboard.com>
 <20180222000531.19448-7-laurent.pinchart+renesas@ideasonboard.com>
 <CAMuHMdVy9=e5eZZTdV6E=apvHxL3n5Qqob2JE+FsON3RG-JWWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAMuHMdVy9=e5eZZTdV6E=apvHxL3n5Qqob2JE+FsON3RG-JWWg@mail.gmail.com>
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
Cc: Marek Vasut <marex@denx.de>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Wolfram Sang <wsa@the-dreams.de>, Koen Kooi <koen@dominion.thruhere.net>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>, Matt Porter <mporter@konsulko.com>, Frank Rowand <frowand.list@gmail.com>, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-i2c@vger.kernel.org

SGkgR2VlcnQsCgpPbiBUaHVyc2RheSwgMjIgRmVicnVhcnkgMjAxOCAxMToyNjo0NCBFRVQgR2Vl
cnQgVXl0dGVyaG9ldmVuIHdyb3RlOgo+IE9uIFRodSwgRmViIDIyLCAyMDE4IGF0IDE6MDUgQU0s
IExhdXJlbnQgUGluY2hhcnQgd3JvdGU6Cj4gPiBGcm9tOiBQYW50ZWxpcyBBbnRvbmlvdSA8cGFu
dGVsaXMuYW50b25pb3VAa29uc3Vsa28uY29tPgo+ID4gCj4gPiBUaGUgY2hhbmdlc2V0IGhlbHBl
cnMgYXJlIGVhc2llciB0byB1c2UsIHVzZSB0aGVtIGluc3RlYWQgb2YKPiA+IHVzaW5nIHRoZSBz
dGF0aWMgcHJvcGVydHkuCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IFBhbnRlbGlzIEFudG9uaW91
IDxwYW50ZWxpcy5hbnRvbmlvdUBrb25zdWxrby5jb20+Cj4gPiBBY2tlZC1ieTogV29sZnJhbSBT
YW5nIDx3c2FAdGhlLWRyZWFtcy5kZT4KPiA+IFsib2theSIgLT4gIm9rIl0KPiAKPiBXaHk/IGVQ
QVBSIHNheXMgIm9rYXkiLCAiZGlzYWJsZWQiLCAiZmFpbCIsIG9yICJmYWlsLXNzcyIuCj4gCj4g
U29ycnkgZm9yIG1pc3NpbmcgdGhpcyBpbiB0aGUgcHJldmlvdXMgcm91bmQuCgpUaGF0IHdhcyBw
ZXIgV29sZnJhbSdzIHJlcXVlc3QsIGFuZCBiZWNhdXNlIHRoZSBleGlzdGluZyBjb2RlIHVzZXMg
Im9rIi4gSSdtIApwZXJzb25hbGx5IGZpbmUgd2l0aCBhbnkuCgotLSAKUmVnYXJkcywKCkxhdXJl
bnQgUGluY2hhcnQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZl
bAo=
