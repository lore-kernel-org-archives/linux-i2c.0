From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v5 6/8] i2c: demux: Use changeset helpers for clarity
Date: Thu, 22 Feb 2018 10:26:44 +0100
Message-ID: <CAMuHMdVy9=e5eZZTdV6E=apvHxL3n5Qqob2JE+FsON3RG-JWWg@mail.gmail.com>
References: <20180222000531.19448-1-laurent.pinchart+renesas@ideasonboard.com>
 <20180222000531.19448-7-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180222000531.19448-7-laurent.pinchart+renesas@ideasonboard.com>
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
Cc: Marek Vasut <marex@denx.de>, Wolfram Sang <wsa@the-dreams.de>, Koen Kooi <koen@dominion.thruhere.net>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>, Matt Porter <mporter@konsulko.com>, Frank Rowand <frowand.list@gmail.com>, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-i2c@vger.kernel.org

SGkgTGF1cmVudCwKCk9uIFRodSwgRmViIDIyLCAyMDE4IGF0IDE6MDUgQU0sIExhdXJlbnQgUGlu
Y2hhcnQKPGxhdXJlbnQucGluY2hhcnQrcmVuZXNhc0BpZGVhc29uYm9hcmQuY29tPiB3cm90ZToK
PiBGcm9tOiBQYW50ZWxpcyBBbnRvbmlvdSA8cGFudGVsaXMuYW50b25pb3VAa29uc3Vsa28uY29t
Pgo+Cj4gVGhlIGNoYW5nZXNldCBoZWxwZXJzIGFyZSBlYXNpZXIgdG8gdXNlLCB1c2UgdGhlbSBp
bnN0ZWFkIG9mCj4gdXNpbmcgdGhlIHN0YXRpYyBwcm9wZXJ0eS4KPgo+IFNpZ25lZC1vZmYtYnk6
IFBhbnRlbGlzIEFudG9uaW91IDxwYW50ZWxpcy5hbnRvbmlvdUBrb25zdWxrby5jb20+Cj4gQWNr
ZWQtYnk6IFdvbGZyYW0gU2FuZyA8d3NhQHRoZS1kcmVhbXMuZGU+Cj4gWyJva2F5IiAtPiAib2si
XQoKV2h5PyBlUEFQUiBzYXlzICJva2F5IiwgImRpc2FibGVkIiwgImZhaWwiLCBvciAiZmFpbC1z
c3MiLgoKU29ycnkgZm9yIG1pc3NpbmcgdGhpcyBpbiB0aGUgcHJldmlvdXMgcm91bmQuCgpHcntv
ZXRqZSxlZXRpbmd9cywKCiAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0CgotLQpHZWVydCBV
eXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0
QGxpbnV4LW02OGsub3JnCgpJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2Fs
IHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0CndoZW4gSSdtIHRhbGtpbmcgdG8g
am91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhh
dC4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcwpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFp
bGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
