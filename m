Return-Path: <SRS0=ZIKj=6F=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A647C55183
	for <linux-i2c@archiver.kernel.org>; Tue, 21 Apr 2020 05:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41FBF2076C
	for <linux-i2c@archiver.kernel.org>; Tue, 21 Apr 2020 05:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tohmTXkM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgDUFTG (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 21 Apr 2020 01:19:06 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:32191 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726611AbgDUFTG (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 21 Apr 2020 01:19:06 -0400
X-UUID: 426b52b14dee41e3859a2646884612cd-20200421
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=XRGWbiWvmZoRr08G6Fnzph3V3VflbmBKWMESNxR1htI=;
        b=tohmTXkMXjPcANjAvvVGJeaEjYcHF7nvknDHgRKACrHvfYLttxoY55Mh0NGJjnfNmom2GHloFqGTM6RQtL1qrUVsNGWLMS1Hjza4Bk+gzZxXPc++f4445VMSd2Fwh/gtxSns5inMNih9yLnUzdZNe1YMYEvcO0lxc4LW5VsnmP8=;
X-UUID: 426b52b14dee41e3859a2646884612cd-20200421
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1721863500; Tue, 21 Apr 2020 13:19:01 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 21 Apr 2020 13:19:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 21 Apr 2020 13:18:59 +0800
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        <linux-i2c@vger.kernel.org>
CC:     <tfiga@chromium.org>, <drinkcat@chromium.org>,
        <srv_heupstream@mediatek.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>
Subject: [PATCH v13 1/2] dt-binding: i2c: add bus-supply property
Date:   Tue, 21 Apr 2020 13:18:57 +0800
Message-ID: <20200421051858.11176-2-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200421051858.11176-1-bibby.hsieh@mediatek.com>
References: <20200421051858.11176-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

SW4gc29tZSBwbGF0Zm9ybXMsIHRoZXkgZGlzYWJsZSB0aGUgcG93ZXItc3VwcGx5IG9mIFNDTC9T
REEgZHVlDQp0byBwb3dlciBjb25zdW1wdGlvbiByZWR1Y3Rpb24uIFRoaXMgcGF0Y2ggYWRkIGJ1
cy1zdXBwbHkgcHJvcGVydHkuDQoNClNpZ25lZC1vZmYtYnk6IEJpYmJ5IEhzaWVoIDxiaWJieS5o
c2llaEBtZWRpYXRlay5jb20+DQotLS0NCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvaTJjL2kyYy50eHQgfCAzICsrKw0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykN
Cg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pMmMvaTJj
LnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pMmMvaTJjLnR4dA0KaW5k
ZXggOWE1M2RmNDI0M2M2Li5lNmI1YWFmYzVkYzkgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvaTJjL2kyYy50eHQNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9pMmMvaTJjLnR4dA0KQEAgLTk4LDYgKzk4LDkgQEAgd2FudHMgdG8g
c3VwcG9ydCBvbmUgb2YgdGhlIGJlbG93IGZlYXR1cmVzLCBpdCBzaG91bGQgYWRhcHQgdGhlIGJp
bmRpbmdzIGJlbG93Lg0KIAlOYW1lcyBvZiBtYXAgcHJvZ3JhbW1hYmxlIGFkZHJlc3Nlcy4NCiAJ
SXQgY2FuIGNvbnRhaW4gYW55IG1hcCBuZWVkaW5nIGFub3RoZXIgYWRkcmVzcyB0aGFuIGRlZmF1
bHQgb25lLg0KIA0KKy0gYnVzLXN1cHBseQ0KKwlwaGFuZGxlIHRvIHRoZSByZWd1bGF0b3IgdGhh
dCBwcm92aWRlcyBwb3dlciB0byBTQ0wvU0RBLg0KKw0KIEJpbmRpbmcgbWF5IGNvbnRhaW4gb3B0
aW9uYWwgImludGVycnVwdHMiIHByb3BlcnR5LCBkZXNjcmliaW5nIGludGVycnVwdHMNCiB1c2Vk
IGJ5IHRoZSBkZXZpY2UuIEkyQyBjb3JlIHdpbGwgYXNzaWduICJpcnEiIGludGVycnVwdCAob3Ig
dGhlIHZlcnkgZmlyc3QNCiBpbnRlcnJ1cHQgaWYgbm90IHVzaW5nIGludGVycnVwdCBuYW1lcykg
YXMgcHJpbWFyeSBpbnRlcnJ1cHQgZm9yIHRoZSBzbGF2ZS4NCi0tIA0KMi4xOC4wDQo=

