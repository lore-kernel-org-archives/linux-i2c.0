From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v7 3/4] arm64: dts: marvell: Add I2C definitions for the
 Armada 3700
Date: Tue, 03 Jan 2017 16:20:34 +0100
Message-ID: <8760lwgofx.fsf@free-electrons.com>
References: <20161201110440.27530-1-romain.perier@free-electrons.com>
 <20161201110440.27530-4-romain.perier@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161201110440.27530-4-romain.perier@free-electrons.com> (Romain
 Perier's message of "Thu, 1 Dec 2016 12:04:39 +0100")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Romain Perier <romain.perier@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Yahuda Yitschak <yehuday@marvell.com>, Omri Itach <omrii@marvell.com>, Jason Cooper <jason@lakedaemon.net>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Igal Liberman <igall@marvell.com>, Hanna Hawa <hannah@marvell.com>, Wolfram Sang <wsa@the-dreams.de>, Neta Zur Hershkovits <neta@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, linux-i2c@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Shadi Ammouri <shadi@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-i2c@vger.kernel.org

SGkgUm9tYWluLAogCiBPbiBqZXUuLCBkw6ljLiAwMSAyMDE2LCBSb21haW4gUGVyaWVyIDxyb21h
aW4ucGVyaWVyQGZyZWUtZWxlY3Ryb25zLmNvbT4gd3JvdGU6Cgo+IFRoZSBBcm1hZGEgMzcwMCBo
YXMgdHdvIGkyYyBidXMgaW50ZXJmYWNlIHVuaXRzLCB0aGlzIGNvbW1pdCBhZGRzIHRoZQo+IGRl
ZmluaXRpb25zIG9mIHRoZSBjb3JyZXNwb25kaW5nIGRldmljZSBub2Rlcy4gSXQgYWxzbyBlbmFi
bGVzIHRoZSBub2RlCj4gb24gdGhlIGRldmVsb3BtZW50IGJvYXJkIGZvciB0aGlzIFNvQy4KPgo+
IFNpZ25lZC1vZmYtYnk6IFJvbWFpbiBQZXJpZXIgPHJvbWFpbi5wZXJpZXJAZnJlZS1lbGVjdHJv
bnMuY29tPgo+IEFja2VkLWJ5OiBHcmVnb3J5IENMRU1FTlQgPGdyZWdvcnkuY2xlbWVudEBmcmVl
LWVsZWN0cm9ucy5jb20+CgpBcHBsaWVkIG9uIG12ZWJ1L2R0NjQKClRoYW5rcywKCkdyZWdvcnkK
Cj4gLS0tCj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtMzcyMC1kYi5kdHMg
fCAgNCArKysrCj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtMzd4eC5kdHNp
ICAgfCAxOCArKysrKysrKysrKysrKysrKysKPiAgMiBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRp
b25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFk
YS0zNzIwLWRiLmR0cyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtMzcyMC1k
Yi5kdHMKPiBpbmRleCAxMzcyZTlhNi4uMTZkODRhZiAxMDA2NDQKPiAtLS0gYS9hcmNoL2FybTY0
L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLTM3MjAtZGIuZHRzCj4gKysrIGIvYXJjaC9hcm02NC9i
b290L2R0cy9tYXJ2ZWxsL2FybWFkYS0zNzIwLWRiLmR0cwo+IEBAIC02Miw2ICs2MiwxMCBAQAo+
ICAJfTsKPiAgfTsKPiAgCj4gKyZpMmMwIHsKPiArCXN0YXR1cyA9ICJva2F5IjsKPiArfTsKPiAr
Cj4gIC8qIENPTjMgKi8KPiAgJnNhdGEgewo+ICAJc3RhdHVzID0gIm9rYXkiOwo+IGRpZmYgLS1n
aXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLTM3eHguZHRzaSBiL2FyY2gv
YXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtMzd4eC5kdHNpCj4gaW5kZXggZTliZDU4Ny4u
MWIwZmQyMSAxMDA2NDQKPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRh
LTM3eHguZHRzaQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtMzd4
eC5kdHNpCj4gQEAgLTk4LDYgKzk4LDI0IEBACj4gIAkJCS8qIDMyTSBpbnRlcm5hbCByZWdpc3Rl
ciBAIDB4ZDAwMF8wMDAwICovCj4gIAkJCXJhbmdlcyA9IDwweDAgMHgwIDB4ZDAwMDAwMDAgMHgy
MDAwMDAwPjsKPiAgCj4gKwkJCWkyYzA6IGkyY0AxMTAwMCB7Cj4gKwkJCQljb21wYXRpYmxlID0g
Im1hcnZlbGwsYXJtYWRhLTM3MDAtaTJjIjsKPiArCQkJCXJlZyA9IDwweDExMDAwIDB4MjQ+Owo+
ICsJCQkJY2xvY2tzID0gPCZuYl9wZXJpcGhfY2xrIDEwPjsKPiArCQkJCWludGVycnVwdHMgPSA8
R0lDX1NQSSAxIElSUV9UWVBFX0xFVkVMX0hJR0g+Owo+ICsJCQkJbXJ2bCxpMmMtZmFzdC1tb2Rl
Owo+ICsJCQkJc3RhdHVzID0gImRpc2FibGVkIjsKPiArCQkJfTsKPiArCj4gKwkJCWkyYzE6IGky
Y0AxMTA4MCB7Cj4gKwkJCQljb21wYXRpYmxlID0gIm1hcnZlbGwsYXJtYWRhLTM3MDAtaTJjIjsK
PiArCQkJCXJlZyA9IDwweDExMDgwIDB4MjQ+Owo+ICsJCQkJY2xvY2tzID0gPCZuYl9wZXJpcGhf
Y2xrIDk+Owo+ICsJCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDIgSVJRX1RZUEVfTEVWRUxfSElH
SD47Cj4gKwkJCQltcnZsLGkyYy1mYXN0LW1vZGU7Cj4gKwkJCQlzdGF0dXMgPSAiZGlzYWJsZWQi
Owo+ICsJCQl9Owo+ICsKPiAgCQkJdWFydDA6IHNlcmlhbEAxMjAwMCB7Cj4gIAkJCQljb21wYXRp
YmxlID0gIm1hcnZlbGwsYXJtYWRhLTM3MDAtdWFydCI7Cj4gIAkJCQlyZWcgPSA8MHgxMjAwMCAw
eDQwMD47Cj4gLS0gCj4gMi45LjMKPgoKLS0gCkdyZWdvcnkgQ2xlbWVudCwgRnJlZSBFbGVjdHJv
bnMKS2VybmVsLCBkcml2ZXJzLCByZWFsLXRpbWUgYW5kIGVtYmVkZGVkIExpbnV4CmRldmVsb3Bt
ZW50LCBjb25zdWx0aW5nLCB0cmFpbmluZyBhbmQgc3VwcG9ydC4KaHR0cDovL2ZyZWUtZWxlY3Ry
b25zLmNvbQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtYXJtLWtlcm5lbAo=
