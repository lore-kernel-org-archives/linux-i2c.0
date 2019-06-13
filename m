From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 1/8] i2c: i2c-qcom-geni: Provide support for ACPI
Date: Thu, 13 Jun 2019 09:52:04 +0100
Message-ID: <20190613085204.GF4660@dell>
References: <20190610084213.1052-1-lee.jones@linaro.org>
 <20190612103453.ccet2pneairnlpcc@ninjato>
 <20190612104011.GA4660@dell>
 <20190612104459.gvji3qxym5s4odfq@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190612104459.gvji3qxym5s4odfq@ninjato>
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

T24gV2VkLCAxMiBKdW4gMjAxOSwgV29sZnJhbSBTYW5nIHdyb3RlOgoKPiAKPiA+IFRoZXJlIGFy
ZSBubyBjcm9zcy1zdWJzeXN0ZW0gYnVpbGQgZGVwZW5kZW5jaWVzIG9uIGFueSBvZiB0aGVzZQo+
ID4gcGF0Y2hlcy4gIFRoZSBvbmx5IHJlYXNvbiB0aGV5IGFyZSBidW5kbGVkIHRvZ2V0aGVyIGlu
IHRoZSBzYW1lCj4gPiBwYXRjaC1zZXQgaXMgZm9yIGNyb3NzLXN1YnN5c3RlbSB2aXNpYmlsaXR5
IGFuZCB1bmRlcnN0YW5kaW5nLgo+ID4gCj4gPiBUaGVyZSBpcyB3aWRlIGludGVyZXN0IGluIHRo
ZXNlIGRldmljZXMuCj4gCj4gSSBzZWUuIFRoYXQgd291bGQgaGF2ZSBiZWVuIGEgZ3JlYXQgY292
ZXItbGV0dGVyLCBMZWUgOykgVGhhbmtzIGZvciB0aGUKPiBoZWFkcyB1cCEKCjopCgo+ID4gPiBB
bHNvLCB0aGUgY3VycmVudCBtYWludGFpbmVyIGVudHJ5IGZvciB0aGlzIGRyaXZlciBsb29rcyBs
aWtlOgo+ID4gPiAKPiA+ID4gZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1xY29tLWdlbmkuYzoKPiA+
ID4gICAgICAgICBBbmR5IEdyb3NzIDxhZ3Jvc3NAa2VybmVsLm9yZz4gKG1haW50YWluZXI6QVJN
L1FVQUxDT01NIFNVUFBPUlQpCj4gPiA+ICAgICAgICAgRGF2aWQgQnJvd24gPGRhdmlkLmJyb3du
QGxpbmFyby5vcmc+IChtYWludGFpbmVyOkFSTS9RVUFMQ09NTSBTVVBQT1JUKQo+ID4gPiAgICAg
ICAgIEFsb2sgQ2hhdWhhbiA8YWxva2NAY29kZWF1cm9yYS5vcmc+IChzdXBwb3J0ZXI6UVVBTENP
TU0gR0VORVJJQyBJTlRFUkZBQ0UgSTJDIERSSVZFUikKPiA+ID4gCj4gPiA+IEkgZGlkbid0IGhl
YXIgZnJvbSB0aG9zZSBwZW9wbGUgeWV0LCB3b3VsZCBiZSBncmVhdCB0byBoYXZlIHRoZWlyIGFj
a3MuCj4gPiAKPiA+IEkgd2lsbCBzZWUgaWYgSSBjYW4gcm91c2UgdGhlbSBmcm9tIHRoZWlyIHNs
dW1iZXIuCj4gCj4gUGxlYXNlIGRvLiBJZiB0aGV5IGFyZSBub3QgdG8gcmVhY2gsIHdlIHByb2Jh
Ymx5IG5lZWQgdG8gdXBkYXRlIHRoZQo+IGVudHJ5Li4uCgpJIGNvbnRhY3RlZCBib3RoIG9mIHRo
ZW0uCgogQW5keSBkb2Vzbid0IHRvdWNoIGFueXRoaW5nIHRoYXQgaXNuJ3QgUVVQIGJhc2VkICg4
OTk0IGFuZCBvbGRlcikuCgogRGF2aWQgZG9lc24ndCBkZWFsIHdpdGggTVNNIHBsYXRmb3JtcyBp
ZiBBbmR5IGlzIGF2YWlsYWJsZS4gCgpTbyBJIGd1ZXNzIHRoZSBkZWNpc2lvbiBpcyB5b3Vycy4g
IFNlZWluZyBhdCB0aGlzIHBhdGNoIGlzIHByZXR0eQp0cml2aWFsIGFuZCBoYXMgb3VyIEFDUEkg
ZXhwZXJ0J3MgQWNrLCB0aGUgZGVjaXNpb24gc2hvdWxkbid0IGJlIGEKZGlmZmljdWx0IG9uZS4K
Ci0tIApMZWUgSm9uZXMgW+adjueQvOaWr10KTGluYXJvIFNlcnZpY2VzIFRlY2huaWNhbCBMZWFk
CkxpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29DcwpGb2xsb3cg
TGluYXJvOiBGYWNlYm9vayB8IFR3aXR0ZXIgfCBCbG9nCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAps
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
