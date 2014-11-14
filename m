From: Valentin Longchamp <valentin.longchamp@keymile.com>
Subject: Re: [PATCH] i2c-qoriq: modified compatibility for correct prescaler
Date: Fri, 14 Nov 2014 08:43:01 +0100
Message-ID: <5465B285.7070005@keymile.com>
References: <1413538026-15739-1-git-send-email-valentin.longchamp@keymile.com>
 <1414537731.23458.120.camel@snotra.buserror.net> <5450AC85.40302@keymile.com>
 <20141113003418.GE2062@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20141113003418.GE2062@katana>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux device trees <devicetree@vger.kernel.org>, "Boschung,
 Rainer" <Rainer.Boschung@keymile.com>, "Brunck,
 Holger" <Holger.Brunck@keymile.com>, Linux I2C <linux-i2c@vger.kernel.org>, Scott Wood <scottwood@freescale.com>, Linux PowerPC Kernel <linuxppc-dev@lists.ozlabs.org>
List-Id: linux-i2c@vger.kernel.org

T24gMTEvMTMvMjAxNCAwMTozNCBBTSwgV29sZnJhbSBTYW5nIHdyb3RlOgo+IAo+PiBJZiB3ZSB3
YW50ZWQgdG8gYmUgb24gdGhlIHNhZmUgc2lkZSBhbmQgc3RyaWN0IChzaW5jZSB3ZSBhcmUgbm90
IHN1cmUgdGhhdCB0aGUKPj4gaGFyZHdhcmUgaXMgMTAwJSBjb21wYXRpYmxlKSwgd2UgbWF5YmUg
c2hvdWxkIGFkZCBhIGZzbCxxb3JpcS1pMmMgY29tcGF0aWJsZSB0bwo+PiB0aGUgZHJpdmVyIHRo
YXQgZG9lcyB0aGUgc2FtZSBhcyBtcGM4NTQzLWkyYy4KPiAKPiBPciB5b3UgbGVhdmUgdGhlIGRy
aXZlciBhcyBpcyBhbmQgdXNlIGJvdGggY29tcGF0aWJsZXM6Cj4gCj4gY29tcGF0aWJsZSA9ICJm
c2wscW9yaXEtaTJjIiwgImZzbCxtcGM4NTQzLWkyYyIsICJmc2wtaTJjIjsKPiAKPiA/Cj4gCgpJ
IGxpa2UgU2NvdHQncyBwcm9wb3NpdGlvbiB0byBhZGQgdGhlIHByZXNjYWxlciBpbiB0aGUgZGV2
aWNlIHRyZWUgbW9yZS4gRnJvbQp0aGUgaGFyZHdhcmUgZGVzY3JpcHRpb24gcG9pbnQgb2Ygdmll
dywgaXQgbWFrZXMgbW9yZSBzZW5zZTogdGhlIGRldmljZXMgYXJlIGFsbApqdXN0IGZzbC1pMmMs
IHdpdGggYSBkaWZmZXJlbnQgcHJlc2NhbGVyLiBJIGp1c3QgcXVvdGUgaXQgYmVsb3cgYXMgYSBy
ZW1pbmRlci4KCj4gCj4gSWYgd2UncmUgZ29pbmcgdG8gY2hhbmdlIHRoZSBkZXZpY2UgdHJlZSBJ
J2QgcmF0aGVyIGp1c3QgYWRkIGEgcHJvcGVydHkKPiB0byBzYXkgd2hhdCB0aGUgcHJlc2NhbGVy
IGlzLgoKIFdlIHdvdWxkIGhvd2V2ZXIsIGxlYXZlIHRoZSBib2FyZHMnIGRldmljZSB0cmVlcyB0
aGF0IHVzZSB0aGluZ3MgbGlrZQoiZnNsLG1wYzg1NDMtaTJjIiBhcyBpcyBhbmQgaW50cm9kdWNl
IHRoZSBwcmVzY2FsZXIgZm9yIHRoZSBvdGhlcnMgcmVxdWlyaW5nIGl0LgoKCk5vdyB0aGUgZHJh
d2JhY2sgaXMgdGhhdCB0aGUgZHJpdmVyIHdvdWxkIHJlcXVpcmUgYSBjaGFuZ2UsIHRvIHBhcnNl
IHRoaXMKcHJlc2NhbGVyIG5ldyBwcmVzY2FsZXIgcHJvcGVydHkuIFdvdWxkIHRoaXMgYmUgT0sg
ZnJvbSB5b3VyIHBvaW50IG9mIHZpZXcKV29sZnJhbSA/IElmIHllcywgSSB3aWxsIHNlbmQgdGhl
IHBhdGNoZXMgZm9yIGl0LgoKVmFsZW50aW4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXhwcGMtZGV2IG1haWxpbmcgbGlzdApMaW51eHBwYy1kZXZA
bGlzdHMub3psYWJzLm9yZwpodHRwczovL2xpc3RzLm96bGFicy5vcmcvbGlzdGluZm8vbGludXhw
cGMtZGV2
