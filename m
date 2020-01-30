From: Bibby Hsieh <bibby.hsieh@mediatek.com>
Subject: [PATCH v11 1/2] dt-binding: i2c: add bus-supply property
Date: Thu, 30 Jan 2020 13:11:27 +0800
Message-ID: <20200130051128.14878-2-bibby.hsieh@mediatek.com>
References: <20200130051128.14878-1-bibby.hsieh@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: base64
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:1802 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726397AbgA3FLi (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 30 Jan 2020 00:11:38 -0500
In-Reply-To: <20200130051128.14878-1-bibby.hsieh@mediatek.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-i2c@vger.kernel.org
Cc: tfiga@chromium.org, drinkcat@chromium.org, srv_heupstream@mediatek.com, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, Bibby Hsieh <bibby.hsieh@mediatek.com>

SW4gc29tZSBwbGF0Zm9ybXMsIHRoZXkgZGlzYWJsZSB0aGUgcG93ZXItc3VwcGx5IG9mIGkyYyBk
dWUNCnRvIHBvd2VyIGNvbnN1bXB0aW9uIHJlZHVjdGlvbi4gVGhpcyBwYXRjaCBhZGQgYnVzLXN1
cHBseSBwcm9wZXJ0eS4NCg0KU2lnbmVkLW9mZi1ieTogQmliYnkgSHNpZWggPGJpYmJ5LmhzaWVo
QG1lZGlhdGVrLmNvbT4NClJldmlld2VkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3Jn
Pg0KLS0tDQogRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2kyYy9pMmMudHh0IHwg
MyArKysNCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaTJjL2kyYy50eHQgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaTJjL2kyYy50eHQNCmluZGV4IDlhNTNkZjQyNDNjNi4u
ODlkODI3ODA1ZTg5IDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2kyYy9pMmMudHh0DQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
aTJjL2kyYy50eHQNCkBAIC05OCw2ICs5OCw5IEBAIHdhbnRzIHRvIHN1cHBvcnQgb25lIG9mIHRo
ZSBiZWxvdyBmZWF0dXJlcywgaXQgc2hvdWxkIGFkYXB0IHRoZSBiaW5kaW5ncyBiZWxvdy4NCiAJ
TmFtZXMgb2YgbWFwIHByb2dyYW1tYWJsZSBhZGRyZXNzZXMuDQogCUl0IGNhbiBjb250YWluIGFu
eSBtYXAgbmVlZGluZyBhbm90aGVyIGFkZHJlc3MgdGhhbiBkZWZhdWx0IG9uZS4NCiANCistIGJ1
cy1zdXBwbHkNCisJcGhhbmRsZSB0byB0aGUgcmVndWxhdG9yIHRoYXQgcHJvdmlkZXMgcG93ZXIg
dG8gaTJjLg0KKw0KIEJpbmRpbmcgbWF5IGNvbnRhaW4gb3B0aW9uYWwgImludGVycnVwdHMiIHBy
b3BlcnR5LCBkZXNjcmliaW5nIGludGVycnVwdHMNCiB1c2VkIGJ5IHRoZSBkZXZpY2UuIEkyQyBj
b3JlIHdpbGwgYXNzaWduICJpcnEiIGludGVycnVwdCAob3IgdGhlIHZlcnkgZmlyc3QNCiBpbnRl
cnJ1cHQgaWYgbm90IHVzaW5nIGludGVycnVwdCBuYW1lcykgYXMgcHJpbWFyeSBpbnRlcnJ1cHQg
Zm9yIHRoZSBzbGF2ZS4NCi0tIA0KMi4xOC4wDQo=
