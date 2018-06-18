From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 2/2] i2c: algos: bit: mention our experience about initial
 states
Date: Mon, 18 Jun 2018 12:03:22 -0400
Message-ID: <CADnq5_Nfee+r-FC_c94-ByWqC9GBONr+Acr15ATb+5yAw_bWMA@mail.gmail.com>
References: <20180616133757.5994-1-wsa+renesas@sang-engineering.com>
 <20180616133757.5994-3-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180616133757.5994-3-wsa+renesas@sang-engineering.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Sergey Larin <cerg2010cerg2010@mail.ru>, Linux I2C <linux-i2c@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>
List-Id: linux-i2c@vger.kernel.org

T24gU2F0LCBKdW4gMTYsIDIwMTggYXQgOTozNyBBTSwgV29sZnJhbSBTYW5nCjx3c2ErcmVuZXNh
c0BzYW5nLWVuZ2luZWVyaW5nLmNvbT4gd3JvdGU6Cj4gU28sIGlmIHNvbWVib2R5IHdhbnRzIHRv
IHJlLWltcGxlbWVudCB0aGlzIGluIHRoZSBmdXR1cmUsIHdlIHBpbnBvaW50IHRvCj4gYSBwcm9i
bGVtIGNhc2UuCj4KPiBTaWduZWQtb2ZmLWJ5OiBXb2xmcmFtIFNhbmcgPHdzYStyZW5lc2FzQHNh
bmctZW5naW5lZXJpbmcuY29tPgoKU2VyaWVzIGlzOgpBY2tlZC1ieTogQWxleCBEZXVjaGVyIDxh
bGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgoKPiAtLS0KPiAgZHJpdmVycy9pMmMvYWxnb3MvaTJj
LWFsZ28tYml0LmMgfCA1ICsrKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykK
Pgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2kyYy9hbGdvcy9pMmMtYWxnby1iaXQuYyBiL2RyaXZl
cnMvaTJjL2FsZ29zL2kyYy1hbGdvLWJpdC5jCj4gaW5kZXggMGMwZWIxNmQ3MTBmLi42ZWM2NWFk
YWJhNDkgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9pMmMvYWxnb3MvaTJjLWFsZ28tYml0LmMKPiAr
KysgYi9kcml2ZXJzL2kyYy9hbGdvcy9pMmMtYWxnby1iaXQuYwo+IEBAIC02NDcsNiArNjQ3LDEx
IEBAIHN0YXRpYyBpbnQgX19pMmNfYml0X2FkZF9idXMoc3RydWN0IGkyY19hZGFwdGVyICphZGFw
LAo+ICAgICAgICAgaWYgKGJpdF9hZGFwLT5nZXRzY2wgPT0gTlVMTCkKPiAgICAgICAgICAgICAg
ICAgYWRhcC0+cXVpcmtzID0gJmkyY19iaXRfcXVpcmtfbm9fY2xrX3N0cmV0Y2g7Cj4KPiArICAg
ICAgIC8qCj4gKyAgICAgICAgKiBXZSB0cmllZCBmb3JjaW5nIFNDTC9TREEgdG8gYW4gaW5pdGlh
bCBzdGF0ZSBoZXJlLiBCdXQgdGhhdCBjYXVzZWQgYQo+ICsgICAgICAgICogcmVncmVzc2lvbiwg
c2FkbHkuIENoZWNrIEJ1Z3ppbGxhICMyMDAwNDUgZm9yIGRldGFpbHMuCj4gKyAgICAgICAgKi8K
PiArCj4gICAgICAgICByZXQgPSBhZGRfYWRhcHRlcihhZGFwKTsKPiAgICAgICAgIGlmIChyZXQg
PCAwKQo+ICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Owo+IC0tCj4gMi4xMS4wCj4KPiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGRyaS1kZXZlbCBt
YWlsaW5nIGxpc3QKPiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcg
bGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
