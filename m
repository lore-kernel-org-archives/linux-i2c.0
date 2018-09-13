From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Subject: Re: [PATCH i2c-next v6] i2c: aspeed: Handle master/slave combined irq
 events properly
Date: Thu, 13 Sep 2018 18:35:38 +0200
Message-ID: <2c481986-7ee0-4887-5c9b-64e2cd9d8c04@kaod.org>
References: <20180911233302.GA18799@roeck-us.net>
 <5698ca34-14c9-8d05-c4e6-5acf85ff9d14@linux.intel.com>
 <20180912013449.GA12612@roeck-us.net>
 <7fd98646-fb5a-be4d-ce37-84b74e0fa8b3@linux.intel.com>
 <20180912195844.GA6893@roeck-us.net>
 <da7f4691-7428-3114-32bb-e0171f6c7228@linux.intel.com>
 <20180912203059.GA18201@roeck-us.net>
 <fb185839-3ae0-01dc-09e8-f22db55ecb04@kaod.org>
 <3f86e75f-1502-eae8-0633-d087937111c8@roeck-us.net>
 <f47b3050-3abd-caa4-cc71-4b13ef60e2c0@kaod.org>
 <20180913155703.GA22605@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180913155703.GA22605@roeck-us.net>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>, linux-aspeed@lists.ozlabs.org, James Feist <james.feist@linux.intel.com>, Vernon Mauery <vernon.mauery@linux.intel.com>, OpenBMC Maillist <openbmc@lists.ozlabs.org>, Brendan Higgins <brendanhiggins@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, jarkko.nikula@linux.intel.com, Joel Stanley <joel@jms.id.au>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

T24gMDkvMTMvMjAxOCAwNTo1NyBQTSwgR3VlbnRlciBSb2VjayB3cm90ZToKPiBPbiBUaHUsIFNl
cCAxMywgMjAxOCBhdCAwNTo0ODo1OVBNICswMjAwLCBDw6lkcmljIExlIEdvYXRlciB3cm90ZToK
Pj4gT24gMDkvMTMvMjAxOCAwMzozMyBQTSwgR3VlbnRlciBSb2VjayB3cm90ZToKPiBbIC4uLiBd
Cj4+Pj4+IMKgIC8qCj4+Pj4+IMKgwqAgKiBUaGUgc3RhdGUgbWFjaGluZSBuZWVkcyBzb21lIHJl
ZmluZW1lbnQuIEl0IGlzIG9ubHkgdXNlZCB0byB0cmFjawo+Pj4+PiDCoMKgICogaW52YWxpZCBT
VE9QIGNvbW1hbmRzIGZvciB0aGUgbW9tZW50Lgo+Pj4+PiBAQCAtMTg4LDcgKzIxNSw3IEBAIHN0
YXRpYyB2b2lkIGFzcGVlZF9pMmNfYnVzX2hhbmRsZV9jbWQoQXNwZWVkSTJDQnVzICpidXMsIHVp
bnQ2NF90IHZhbHVlKQo+Pj4+PiDCoCB7Cj4+Pj4+IMKgwqDCoMKgwqAgYnVzLT5jbWQgJj0gfjB4
RkZGRjsKPj4+Pj4gwqDCoMKgwqDCoCBidXMtPmNtZCB8PSB2YWx1ZSAmIDB4RkZGRjsKPj4+Pj4g
LcKgwqDCoCBidXMtPmludHJfc3RhdHVzID0gMDs+ICvCoMKgwqAgYnVzLT5pbnRyX3N0YXR1cyAm
PSBJMkNEX0lOVFJfUlhfRE9ORTsKPj4+Pgo+Pj4+IGl0IGRlc2VydmVzIGEgY29tbWVudCB0byB1
bmRlcnN0YW5kIHdoaWNoIHNjZW5hcmlvIHdlIGFyZSB0cnlpbmcgdG8gaGFuZGxlLgo+Pj4+IMKg
wqAgCj4+Pgo+Pj4gT2suIEZXSVcsIEkgd29uZGVyIGlmIGludHJfc3RhdHVzIHNob3VsZCBiZSB0
b3VjaGVkIGhlcmUgaW4gdGhlIGZpcnN0IHBsYWNlLAo+Pj4gYnV0IEkgbmVpdGhlciBoYXZlIHRo
ZSBoYXJkd2FyZSBub3IgYSBkYXRhc2hlZXQsIHNvIEkgZG9uJ3Qga25vdyBpZiBhbnkgYml0cwo+
Pj4gYXJlIGF1dG8tY2xlYXJlZC4KPj4KPj4gSSBqdXN0IHB1c2hlZCBhIHBhdGNoIG9uIG15IGJy
YW5jaCB3aXRoIHNvbWUgbW9yZSBleHBsYW5hdGlvbiA6IAo+Pgo+PiAJaHR0cHM6Ly9naXRodWIu
Y29tL2xlZ29hdGVyL3FlbXUvY29tbWl0cy9hc3BlZWQtMy4xCj4+Cj4gVGhhdCBzZWVtcyB0byBz
dWdnZXN0IHRoYXQgbm9uZSBvZiB0aGUgc3RhdHVzIGJpdHMgYXV0by1jbGVhcnMsIGFuZCB0aGF0
Cj4gdGhlIGFib3ZlIGNvZGUgY2xlYXJpbmcgaW50cl9zdGF0dXMgc2hvdWxkIGJlIHJlbW92ZWQg
ZW50aXJlbHkuCj4gQW0gSSBtaXNzaW5nIHNvbWV0aGluZyA/CgpZb3UgYXJlIHJpZ2h0LiBJIGp1
c3QgcHVzaGVkIGFub3RoZXIgdmVyc2lvbiBvZiB0aGUgcHJldmlvdXMgcGF0Y2ggd2l0aCB0aGlz
IApuZXcgaHVuayA6CgpAQCAtMTg4LDcgKzIwMCw2IEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9pMmNf
YnVzX2hhbmRsZV9jbWQoQXMKIHsKICAgICBidXMtPmNtZCAmPSB+MHhGRkZGOwogICAgIGJ1cy0+
Y21kIHw9IHZhbHVlICYgMHhGRkZGOwotICAgIGJ1cy0+aW50cl9zdGF0dXMgPSAwOwogCiAgICAg
aWYgKGJ1cy0+Y21kICYgSTJDRF9NX1NUQVJUX0NNRCkgewogICAgICAgICB1aW50OF90IHN0YXRl
ID0gYXNwZWVkX2kyY19nZXRfc3RhdGUoYnVzKSAmIEkyQ0RfTUFDVElWRSA/CgoKVGhlIFFFTVUg
cGFsbWV0dG8gYW5kIHdpdGhlcnNwb29uIG1hY2hpbmVzIHNlZW0gdG8gYmVoYXZlIGZpbmUuIENh
biB5b3UgZ2l2ZSAKaXQgYSB0cnkgPwoKVGhhbmtzLAoKQy4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0
CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
