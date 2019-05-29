From: Annaliese McDermond <nh6z@nh6z.net>
Subject: Re: [PATCH v2] i2c: bcm2835: Model Divider in CCF
Date: Tue, 28 May 2019 20:01:56 -0700
Message-ID: <ACF57AF2-51C9-4884-BC65-126221CDAB5B@nh6z.net>
References: <20190508071227.18609-1-nh6z@nh6z.net>
 <716a7b8a-c2f8-a3c4-0b3a-be3cb26a6c12@i2se.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <716a7b8a-c2f8-a3c4-0b3a-be3cb26a6c12@i2se.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: f.fainelli@gmail.com, swarren@wwwdotorg.org, wsa@the-dreams.de, team@nwdigitalradio.com, eric@anholt.net, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Cgo+IE9uIE1heSAyOCwgMjAxOSwgYXQgMTI6NTIgQU0sIFN0ZWZhbiBXYWhyZW4gPHN0ZWZhbi53
YWhyZW5AaTJzZS5jb20+IHdyb3RlOgo+IAo+IEhpIEFubmFsaWVzZSwKPiAKPiB0aGFuayB5b3Ug
Zm9yIG1lbnRpb24gdGhhdCB3ZSBoYXZlIG11bHRpcGxlIEkyQyBpbnRlcmZhY2VzLgo+IAo+IE9u
IDA4LjA1LjE5IDA5OjEyLCBBbm5hbGllc2UgTWNEZXJtb25kIHdyb3RlOgo+PiArCj4+ICtzdGF0
aWMgc3RydWN0IGNsayAqYmNtMjgzNV9pMmNfcmVnaXN0ZXJfZGl2KHN0cnVjdCBkZXZpY2UgKmRl
diwKPj4gKwkJCQkJY29uc3QgY2hhciAqbWNsa19uYW1lLAo+PiArCQkJCQlzdHJ1Y3QgYmNtMjgz
NV9pMmNfZGV2ICppMmNfZGV2KQo+PiArewo+PiArCXN0cnVjdCBjbGtfaW5pdF9kYXRhIGluaXQ7
Cj4+ICsJc3RydWN0IGNsa19iY20yODM1X2kyYyAqcHJpdjsKPj4gKwljb25zdCBjaGFyICpkZXZu
YW1lID0gZGV2X25hbWUoZGV2KTsKPj4gKwo+PiArCWluaXQub3BzID0gJmNsa19iY20yODM1X2ky
Y19vcHM7Cj4+ICsJaW5pdC5uYW1lID0gImJjbTI4MzUtaTJjIjsKPiAKPiBEb2VzIHRoaXMgd29y
ayBpbnRlbnRpb25hbGx5IGluIGNhc2UgaTJjLTAgYW5kIGkyYy0xIGFyZSB1c2VkIGF0IHRoZQo+
IHNhbWUgdGltZT8KCkl0IHNob3VsZCB3b3JrIGZpbmUuICBUaGUgY2xvY2tzIGFyZSBhbGwgcmVn
aXN0ZXJlZCBzZXBhcmF0ZWx5IGFuZCBwYXNzZWQKdGhlIHBvaW50ZXIgdG8gdGhlIHN0cnVjdCBk
ZXZpY2UgZm9yIHRoZSBpbnRlcmZhY2UuICBUaGlzIGtlZXBzIGl0CmFjY2Vzc2luZyB0aGUgY29y
cmVjdCByZWdpc3RlcnMgYW5kIHN1Y2guCgo+IFBsZWFzZSBhbHNvIGNoZWNrIHRoZSBvdXRwdXQg
b2YgL3N5cy9rZXJuZWwvZGVidWcvY2xrL2Nsa19zdW1tYXJ5CgpUaGV54oCZbGwgY29tZSB1cCB3
aXRoIHRoZSBzYW1lIG5hbWUgaW4gdGhlIGN1cnJlbnQgY29kZSBpbiB0aGUgZGVidWcKb3V0cHV0
LiAgSSBhZ3JlZSB0aGlzIGlzIG1pbGRseSBjb25mdXNpbmcgYW5kIEnigJlsbCBzcGluIGFub3Ro
ZXIgdmVyc2lvbgpvZiB0aGUgcGF0Y2ggdG8gZ2l2ZSB0aGVtIHVuaXF1ZSBjbG9jayBuYW1lcyBp
biBjbGtfc3VtbWFyeS4KCj4gUmVnYXJkcwo+IFN0ZWZhbgo+IAoKLS0KQW5uYWxpZXNlIE1jRGVy
bW9ub2QKbmg2ekBuaDZ6Lm5ldApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
