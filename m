From: Bibby Hsieh <bibby.hsieh@mediatek.com>
Subject: [PATCH v10 1/4] dt-binding: eeprom: at24: add vcc-supply property
Date: Thu, 16 Jan 2020 10:56:34 +0800
Message-ID: <20200116025637.3524-2-bibby.hsieh@mediatek.com>
References: <20200116025637.3524-1-bibby.hsieh@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: base64
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:22993 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729057AbgAPC4o (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 15 Jan 2020 21:56:44 -0500
In-Reply-To: <20200116025637.3524-1-bibby.hsieh@mediatek.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-i2c@vger.kernel.org
Cc: tfiga@chromium.org, drinkcat@chromium.org, srv_heupstream@mediatek.com, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, Bibby Hsieh <bibby.hsieh@mediatek.com>

SW4gc29tZSBwbGF0Zm9ybXMsIHRoZXkgZGlzYWJsZSB0aGUgcG93ZXItc3VwcGx5IG9mIGVlcHJv
bSBkdWUNCnRvIHBvd2VyIGNvbnN1bXB0aW9uIHJlZHVjdGlvbi4gVGhpcyBwYXRjaCBhZGQgdmNj
LXN1cHBseSBwcm9wZXJ0eS4NCg0KU2lnbmVkLW9mZi1ieTogQmliYnkgSHNpZWggPGJpYmJ5Lmhz
aWVoQG1lZGlhdGVrLmNvbT4NClJldmlld2VkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwu
b3JnPg0KLS0tDQogRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2VlcHJvbS9hdDI0
LnlhbWwgfCA0ICsrKysNCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQoNCmRpZmYg
LS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZWVwcm9tL2F0MjQueWFt
bCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9lZXByb20vYXQyNC55YW1sDQpp
bmRleCBlODc3ODU2MGQ5NjYuLmMwNGEzYjhhNmViYSAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9lZXByb20vYXQyNC55YW1sDQorKysgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZWVwcm9tL2F0MjQueWFtbA0KQEAgLTE2Nyw2ICsxNjcs
MTAgQEAgcHJvcGVydGllczoNCiAgICAgbWluaW11bTogMQ0KICAgICBtYXhpbXVtOiA4DQogDQor
ICB2Y2Mtc3VwcGx5Og0KKyAgICBkZXNjcmlwdGlvbjoNCisgICAgICBwaGFuZGxlIG9mIHRoZSBy
ZWd1bGF0b3IgdGhhdCBwcm92aWRlcyB0aGUgc3VwcGx5IHZvbHRhZ2UuDQorDQogcmVxdWlyZWQ6
DQogICAtIGNvbXBhdGlibGUNCiAgIC0gcmVnDQotLSANCjIuMTguMA0K
