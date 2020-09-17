Return-Path: <SRS0=DpqV=C2=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BF0C433E2
	for <linux-i2c@archiver.kernel.org>; Thu, 17 Sep 2020 12:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA68B208DB
	for <linux-i2c@archiver.kernel.org>; Thu, 17 Sep 2020 12:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CevI0gAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgIQMFC (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 17 Sep 2020 08:05:02 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:61005 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726773AbgIQMEs (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 17 Sep 2020 08:04:48 -0400
X-UUID: 71a43a36754643aa88dbddd9eb1235fa-20200917
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=6RsFN3FgI09QCmEIV64IUurK2wRwXLViWE4DI22IWEY=;
        b=CevI0gAxzwQWnyHIN7cLsYBuCJ4gsX+/9Ypq1hApsLwTuKwpCdLm7AbvEKtcEQIZqmT4fs2ZwKx7qe3LKFygV8nRO2KmKEcXofj5NYBpVBQMOtJQD5e01JB9AvKKyUah16Ao0E+1oLm8UFn79auPIBHUQyM8PpvWo6m06VNITeE=;
X-UUID: 71a43a36754643aa88dbddd9eb1235fa-20200917
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <qii.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1923396637; Thu, 17 Sep 2020 19:58:02 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 17 Sep 2020 19:57:59 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Sep 2020 19:57:59 +0800
From:   Qii Wang <qii.wang@mediatek.com>
To:     <wsa@the-dreams.de>
CC:     <matthias.bgg@gmail.com>, <linux-i2c@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>,
        <qii.wang@mediatek.com>
Subject: [PATCH 0/2] Fix some definitions for bus frequency
Date:   Thu, 17 Sep 2020 19:55:40 +0800
Message-ID: <1600343742-9731-1-git-send-email-qii.wang@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

VGhpcyBzZXJpZXMgYXJlIGJhc2VkIG9uIDUuOS1yYzEgYW5kIHdlIHByb3ZpZGUgdHdvIGkyYyBw
YXRjaGVzDQp0byBmaXggc29tZSBkZWZpbml0aW9ucyBmb3IgYnVzIGZyZXF1ZW5jeS4NCg0KUWlp
IFdhbmcgKDIpOg0KICBpMmM6IG1lZGlhdGVrOiBGaXggZ2VuZXJpYyBkZWZpbml0aW9ucyBmb3Ig
YnVzIGZyZXF1ZW5jeQ0KICBpMmM6IG1lZGlhdGVrOiBTZW5kIGkyYyBtYXN0ZXIgY29kZSBhdCBt
b3JlIHRoYW4gMU1Ieg0KDQogZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1tdDY1eHguYyB8IDYgKysr
LS0tDQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0K
LS0gDQoxLjkuMQ0KDQo=

