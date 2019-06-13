From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 1/8] i2c: i2c-qcom-geni: Provide support for ACPI
Date: Thu, 13 Jun 2019 09:52:54 +0100
Message-ID: <20190613085254.GA16364@dell>
References: <20190610084213.1052-1-lee.jones@linaro.org>
 <20190612103453.ccet2pneairnlpcc@ninjato>
 <20190612104011.GA4660@dell>
 <20190612104459.gvji3qxym5s4odfq@ninjato>
 <20190613085204.GF4660@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190613085204.GF4660@dell>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: balbi@kernel.org, linux-usb@vger.kernel.org, wsa+renesas@sang-engineering.com, gregkh@linuxfoundation.org, linus.walleij@linaro.org, ard.biesheuvel@linaro.org, linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org, david.brown@linaro.org, alokc@codeaurora.org, linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, andy.gross@linaro.org, jlhugo@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

T24gVGh1LCAxMyBKdW4gMjAxOSwgTGVlIEpvbmVzIHdyb3RlOgoKPiBPbiBXZWQsIDEyIEp1biAy
MDE5LCBXb2xmcmFtIFNhbmcgd3JvdGU6Cj4gCj4gPiAKPiA+ID4gVGhlcmUgYXJlIG5vIGNyb3Nz
LXN1YnN5c3RlbSBidWlsZCBkZXBlbmRlbmNpZXMgb24gYW55IG9mIHRoZXNlCj4gPiA+IHBhdGNo
ZXMuICBUaGUgb25seSByZWFzb24gdGhleSBhcmUgYnVuZGxlZCB0b2dldGhlciBpbiB0aGUgc2Ft
ZQo+ID4gPiBwYXRjaC1zZXQgaXMgZm9yIGNyb3NzLXN1YnN5c3RlbSB2aXNpYmlsaXR5IGFuZCB1
bmRlcnN0YW5kaW5nLgo+ID4gPiAKPiA+ID4gVGhlcmUgaXMgd2lkZSBpbnRlcmVzdCBpbiB0aGVz
ZSBkZXZpY2VzLgo+ID4gCj4gPiBJIHNlZS4gVGhhdCB3b3VsZCBoYXZlIGJlZW4gYSBncmVhdCBj
b3Zlci1sZXR0ZXIsIExlZSA7KSBUaGFua3MgZm9yIHRoZQo+ID4gaGVhZHMgdXAhCj4gCj4gOikK
PiAKPiA+ID4gPiBBbHNvLCB0aGUgY3VycmVudCBtYWludGFpbmVyIGVudHJ5IGZvciB0aGlzIGRy
aXZlciBsb29rcyBsaWtlOgo+ID4gPiA+IAo+ID4gPiA+IGRyaXZlcnMvaTJjL2J1c3Nlcy9pMmMt
cWNvbS1nZW5pLmM6Cj4gPiA+ID4gICAgICAgICBBbmR5IEdyb3NzIDxhZ3Jvc3NAa2VybmVsLm9y
Zz4gKG1haW50YWluZXI6QVJNL1FVQUxDT01NIFNVUFBPUlQpCj4gPiA+ID4gICAgICAgICBEYXZp
ZCBCcm93biA8ZGF2aWQuYnJvd25AbGluYXJvLm9yZz4gKG1haW50YWluZXI6QVJNL1FVQUxDT01N
IFNVUFBPUlQpCj4gPiA+ID4gICAgICAgICBBbG9rIENoYXVoYW4gPGFsb2tjQGNvZGVhdXJvcmEu
b3JnPiAoc3VwcG9ydGVyOlFVQUxDT01NIEdFTkVSSUMgSU5URVJGQUNFIEkyQyBEUklWRVIpCj4g
PiA+ID4gCj4gPiA+ID4gSSBkaWRuJ3QgaGVhciBmcm9tIHRob3NlIHBlb3BsZSB5ZXQsIHdvdWxk
IGJlIGdyZWF0IHRvIGhhdmUgdGhlaXIgYWNrcy4KPiA+ID4gCj4gPiA+IEkgd2lsbCBzZWUgaWYg
SSBjYW4gcm91c2UgdGhlbSBmcm9tIHRoZWlyIHNsdW1iZXIuCj4gPiAKPiA+IFBsZWFzZSBkby4g
SWYgdGhleSBhcmUgbm90IHRvIHJlYWNoLCB3ZSBwcm9iYWJseSBuZWVkIHRvIHVwZGF0ZSB0aGUK
PiA+IGVudHJ5Li4uCj4gCj4gSSBjb250YWN0ZWQgYm90aCBvZiB0aGVtLgo+IAo+ICBBbmR5IGRv
ZXNuJ3QgdG91Y2ggYW55dGhpbmcgdGhhdCBpc24ndCBRVVAgYmFzZWQgKDg5OTQgYW5kIG9sZGVy
KS4KPiAKPiAgRGF2aWQgZG9lc24ndCBkZWFsIHdpdGggTVNNIHBsYXRmb3JtcyBpZiBBbmR5IGlz
IGF2YWlsYWJsZS4gCj4gCj4gU28gSSBndWVzcyB0aGUgZGVjaXNpb24gaXMgeW91cnMuICBTZWVp
bmcgYXQgdGhpcyBwYXRjaCBpcyBwcmV0dHkKPiB0cml2aWFsIGFuZCBoYXMgb3VyIEFDUEkgZXhw
ZXJ0J3MgQWNrLCB0aGUgZGVjaXNpb24gc2hvdWxkbid0IGJlIGEKPiBkaWZmaWN1bHQgb25lLgoK
QlRXLCB2NCBoYXMgY29sbGVjdGVkIEFja3MgYW5kIGEgY292ZXItbGV0dGVyLiA6KQoKLS0gCkxl
ZSBKb25lcyBb5p2O55C85pavXQpMaW5hcm8gU2VydmljZXMgVGVjaG5pY2FsIExlYWQKTGluYXJv
Lm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCkZvbGxvdyBMaW5hcm86
IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
