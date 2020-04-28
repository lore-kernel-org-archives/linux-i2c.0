Return-Path: <SRS0=lZNS=6M=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D097DC83007
	for <linux-i2c@archiver.kernel.org>; Tue, 28 Apr 2020 06:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0431206B9
	for <linux-i2c@archiver.kernel.org>; Tue, 28 Apr 2020 06:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IAxkbBp7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgD1GSb (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 28 Apr 2020 02:18:31 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:10958 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726309AbgD1GSa (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 28 Apr 2020 02:18:30 -0400
X-UUID: 5f7169bdba84448391519a5427b37230-20200428
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Z3F9dzYpj6kHQJyFHOmnLv8yfGY35xuCReuodtH6pAI=;
        b=IAxkbBp7yAY9E8gZKXhqXYHSU3+O8J0gBkXFDv8DqjpEszmvID+jpIhddYEAetkH+6OT+hbxsvTniTr97BtnJ7Y2byluABWhjGSq36+j717GNyJ/oIDzI0Af7ePm/7y+Vy1PbtOuBb7WmQPWwwAvqGKHRETngZzPeiPaUCr0csM=;
X-UUID: 5f7169bdba84448391519a5427b37230-20200428
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 459568150; Tue, 28 Apr 2020 14:18:26 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 28 Apr 2020 14:18:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 28 Apr 2020 14:18:22 +0800
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        <linux-i2c@vger.kernel.org>
CC:     <tfiga@chromium.org>, <drinkcat@chromium.org>,
        <srv_heupstream@mediatek.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>
Subject: [PATCH v14 1/2] dt-binding: i2c: add bus-supply property
Date:   Tue, 28 Apr 2020 14:18:12 +0800
Message-ID: <20200428061813.27072-2-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200428061813.27072-1-bibby.hsieh@mediatek.com>
References: <20200428061813.27072-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

SW4gc29tZSBwbGF0Zm9ybXMsIHRoZXkgZGlzYWJsZSB0aGUgcG93ZXItc3VwcGx5IG9mIGkyYyBk
dWUNCnRvIHBvd2VyIGNvbnN1bXB0aW9uIHJlZHVjdGlvbi4gVGhpcyBwYXRjaCBhZGQgYnVzLXN1
cHBseSBwcm9wZXJ0eS4NCg0KU2lnbmVkLW9mZi1ieTogQmliYnkgSHNpZWggPGJpYmJ5LmhzaWVo
QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9p
MmMvaTJjLnR4dCB8IDMgKysrDQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KDQpk
aWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2kyYy9pMmMudHh0
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2kyYy9pMmMudHh0DQppbmRleCA5
YTUzZGY0MjQzYzYuLmU2YjVhYWZjNWRjOSAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9pMmMvaTJjLnR4dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2kyYy9pMmMudHh0DQpAQCAtOTgsNiArOTgsOSBAQCB3YW50cyB0byBzdXBw
b3J0IG9uZSBvZiB0aGUgYmVsb3cgZmVhdHVyZXMsIGl0IHNob3VsZCBhZGFwdCB0aGUgYmluZGlu
Z3MgYmVsb3cuDQogCU5hbWVzIG9mIG1hcCBwcm9ncmFtbWFibGUgYWRkcmVzc2VzLg0KIAlJdCBj
YW4gY29udGFpbiBhbnkgbWFwIG5lZWRpbmcgYW5vdGhlciBhZGRyZXNzIHRoYW4gZGVmYXVsdCBv
bmUuDQogDQorLSBidXMtc3VwcGx5DQorCXBoYW5kbGUgdG8gdGhlIHJlZ3VsYXRvciB0aGF0IHBy
b3ZpZGVzIHBvd2VyIHRvIFNDTC9TREEuDQorDQogQmluZGluZyBtYXkgY29udGFpbiBvcHRpb25h
bCAiaW50ZXJydXB0cyIgcHJvcGVydHksIGRlc2NyaWJpbmcgaW50ZXJydXB0cw0KIHVzZWQgYnkg
dGhlIGRldmljZS4gSTJDIGNvcmUgd2lsbCBhc3NpZ24gImlycSIgaW50ZXJydXB0IChvciB0aGUg
dmVyeSBmaXJzdA0KIGludGVycnVwdCBpZiBub3QgdXNpbmcgaW50ZXJydXB0IG5hbWVzKSBhcyBw
cmltYXJ5IGludGVycnVwdCBmb3IgdGhlIHNsYXZlLg0KLS0gDQoyLjE4LjANCg==

