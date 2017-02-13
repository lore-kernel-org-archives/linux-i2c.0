From: "De Marchi, Lucas" <lucas.demarchi@intel.com>
Subject: Re: [PATCH] Revert "i2c: designware: detect when dynamic tar update
 is possible"
Date: Mon, 13 Feb 2017 17:22:42 +0000
Message-ID: <1487006561.2767.6.camel@intel.com>
References: <20170213091819.4370-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:11121 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751652AbdBMRWp (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 13 Feb 2017 12:22:45 -0500
In-Reply-To: <20170213091819.4370-1-jarkko.nikula@linux.intel.com>
Content-Language: en-US
Content-ID: <F5898E76214ED74290E37B256468B468@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "jarkko.nikula@linux.intel.com" <jarkko.nikula@linux.intel.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Cc: "wsa@the-dreams.de" <wsa@the-dreams.de>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "Nehal-bakulchandra.Shah@amd.com" <Nehal-bakulchandra.Shah@amd.com>

T24gTW9uLCAyMDE3LTAyLTEzIGF0IDExOjE4ICswMjAwLCBKYXJra28gTmlrdWxhIHdyb3RlOg0K
PiBUaGlzIHJldmVydHMgY29tbWl0IDYzZDBmMGE2OTUyYTFhMDJiYzRmMTE2YjdkYTdjNzg4N2U0
NmVmYTMuDQo+IA0KPiBJdCBjYXVzZWQgYSByZWdyZXNzaW9uIG9uIHBsYXRmb3JtcyB3aGVyZSBJ
MkMgY29udHJvbGxlciBpcyBzeW50aGVzaXplZA0KPiB3aXRoIGR5bmFtaWMgVEFSIHVwZGF0ZSBk
aXNhYmxlZC4gRGV0ZWN0aW9uIGNvZGUgaXMgdGVzdGluZyBpcyBiaXQNCj4gRFdfSUNfQ09OXzEw
QklUQUREUl9NQVNURVIgaW4gcmVnaXN0ZXIgRFdfSUNfQ09OIHJlYWQtb25seSBidXQgZmFpbHMg
dG8NCj4gcmVzdG9yZSBvcmlnaW5hbCB2YWx1ZSBpbiBjYXNlIGJpdCBpcyByZWFkLXdyaXRlLg0K
PiANCj4gSW5zdGVhZCBvZiBmaXhpbmcgdGhpcyB3ZSByZXZlcnQgdGhlIGNvbW1pdCBzaW5jZSBp
dCB3YXMgcHJlcGFyYXRpb24gZm9yDQo+IHRoZSBjb21taXQgMDMxN2U2YzBmMWRjICgiaTJjOiBk
ZXNpZ253YXJlOiBkbyBub3QgZGlzYWJsZSBhZGFwdGVyIGFmdGVyDQo+IHRyYW5zZmVyIikgd2hp
Y2ggd2FzIGFsc28gcmV2ZXJ0ZWQuDQo+IA0KPiBSZXBvcnRlZC1ieTogU2hhaCBOZWhhbC1CYWt1
bGNoYW5kcmEgPE5laGFsLWJha3VsY2hhbmRyYS5TaGFoQGFtZC5jb20+DQo+IFJlcG9ydGVkLWJ5
OiBTdXJhdmVlIFN1dGhpa3VscGFuaXQgPHN1cmF2ZWUuc3V0aGlrdWxwYW5pdEBhbWQuY29tPg0K
PiBDYzogTHVjYXMgRGUgTWFyY2hpIDxsdWNhcy5kZW1hcmNoaUBpbnRlbC5jb20+DQo+IENjOiA8
c3RhYmxlQHZnZXIua2VybmVsLm9yZz4gIyB2NC45Kw0KPiBGaXhlczogNjNkMGYwYTY5NTJhICgi
aTJjOiBkZXNpZ253YXJlOiBkZXRlY3Qgd2hlbiBkeW5hbWljIHRhciB1cGRhdGUgaXMgcG9zc2li
bGUiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBKYXJra28gTmlrdWxhIDxqYXJra28ubmlrdWxhQGxpbnV4
LmludGVsLmNvbT4NCg0KQWNrZWQtQnk6IEx1Y2FzIERlIE1hcmNoaSA8bHVjYXMuZGVtYXJjaGlA
aW50ZWwuY29tPg0KDQoNCg0KTHVjYXMgRGUgTWFyY2hp
