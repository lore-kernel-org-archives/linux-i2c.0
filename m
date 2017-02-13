From: "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>
Subject: RE: [PATCH] i2c: designware: Fix regression when dynamic TAR update
 is disabled
Date: Mon, 13 Feb 2017 04:15:43 +0000
Message-ID: <MWHPR12MB13574F24845835E760E30134A0590@MWHPR12MB1357.namprd12.prod.outlook.com>
References: <1486669851-25632-1-git-send-email-Nehal-Bakulchandra.Shah@amd.com>
 <1486670858.2133.436.camel@linux.intel.com>
 <1486676048.14478.4.camel@intel.com>
 <110f9081-ddba-82c2-6ba3-f92bc36d0bc3@amd.com>
 <d1db459e-59a4-72d8-e21c-bb44545f10e6@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-cys01nam02on0049.outbound.protection.outlook.com ([104.47.37.49]:31436
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750989AbdBMEPt (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 12 Feb 2017 23:15:49 -0500
In-Reply-To: <d1db459e-59a4-72d8-e21c-bb44545f10e6@linux.intel.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>, "De Marchi, Lucas" <lucas.demarchi@intel.com>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
Cc: "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>

SXQgaXMgYmV0dGVyIHRvIHJldmVydCB0aGUgNjNkMGYwYTY5NTJhLiAgDQoNCi0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBKYXJra28gTmlrdWxhIFttYWlsdG86amFya2tvLm5pa3Vs
YUBsaW51eC5pbnRlbC5jb21dIA0KU2VudDogRnJpZGF5LCBGZWJydWFyeSAxMCwgMjAxNyA0OjE5
IFBNDQpUbzogU3V0aGlrdWxwYW5pdCwgU3VyYXZlZSA8U3VyYXZlZS5TdXRoaWt1bHBhbml0QGFt
ZC5jb20+OyBEZSBNYXJjaGksIEx1Y2FzIDxsdWNhcy5kZW1hcmNoaUBpbnRlbC5jb20+OyBtaWth
Lndlc3RlcmJlcmdAbGludXguaW50ZWwuY29tOyBhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRl
bC5jb207IFNoYWgsIE5laGFsLWJha3VsY2hhbmRyYSA8TmVoYWwtYmFrdWxjaGFuZHJhLlNoYWhA
YW1kLmNvbT4NCkNjOiB3c2FAdGhlLWRyZWFtcy5kZTsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtaTJjQHZnZXIua2VybmVsLm9yZzsgUy1rLCBTaHlhbS1zdW5kYXIgPFNoeWFt
LXN1bmRhci5TLWtAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGkyYzogZGVzaWdud2Fy
ZTogRml4IHJlZ3Jlc3Npb24gd2hlbiBkeW5hbWljIFRBUiB1cGRhdGUgaXMgZGlzYWJsZWQNCg0K
T24gMTAuMDIuMjAxNyAwODozOCwgU3VyYXZlZSBTdXRoaWt1bHBhbml0IHdyb3RlOg0KPiBBdCB0
aGlzIHBvaW50cywgbXkgdW5kZXJzdGFuZGluZyBpcyB0aGVyZSBhcmUgcHJvYmFibHkgdHdvIG9w
dGlvbnMgaGVyZToNCj4NCj4gMSkgS2VlcCB0aGUgY29tbWl0IDYzZDBmMGE2OTUyYSAoaTJjOiBk
ZXNpZ253YXJlOiBkZXRlY3Qgd2hlbiBkeW5hbWljIA0KPiB0YXIgdXBkYXRlDQo+ICAgIGlzIHBv
c3NpYmxlKSBhbmQgYXBwbHkgVjIgb2YgdGhpcyBwYXRjaCBpbiA0LjEwLiBXZSBtaWdodCBuZWVk
IHRvIA0KPiBiYWNrLXBvcnQgdGhlIGNoYW5nZQ0KPiAgICB0byB2NC45IHN0YWJsZSBhcyB3ZWxs
Lg0KPg0KPiAyKSBSZXZlcnQgdGhlIDYzZDBmMGE2OTUyYSAoaTJjOiBkZXNpZ253YXJlOiBkZXRl
Y3Qgd2hlbiBkeW5hbWljIHRhciANCj4gdXBkYXRlIGlzIHBvc3NpYmxlKSBpbiA0LjEwLA0KPiAg
ICBhbmQgYWxzbyBpbiB2NC45IHN0YWJsZSBhcyB3ZWxsLg0KPg0KSSdtIGZpbmUgd2l0aCBib3Ro
IG9wdGlvbnMuIE1heWJlIHJldmVydCBhcyBjb21taXQgMDMxN2U2YzBmMWRjICgiaTJjOiANCmRl
c2lnbndhcmU6IGRvIG5vdCBkaXNhYmxlIGFkYXB0ZXIgYWZ0ZXIgdHJhbnNmZXIiKSB3YXMgYWxz
byByZXZlcnRlZCBhbmQgdGhpcyByZXZlcnQgZG9lc24ndCBzZWVtIHRvIGNhdXNlIGNvbmZsaWN0
cy4NCg0KLS0NCkphcmtrbw0K
