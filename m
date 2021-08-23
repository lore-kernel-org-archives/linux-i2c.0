Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53939C43216
	for <linux-i2c@archiver.kernel.org>; Mon, 23 Aug 2021 13:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 349F8613BD
	for <linux-i2c@archiver.kernel.org>; Mon, 23 Aug 2021 13:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237394AbhHWNGm (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 23 Aug 2021 09:06:42 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:47852 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237329AbhHWNGf (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 23 Aug 2021 09:06:35 -0400
X-UUID: 26baf71f73864d50884a4bbbc0737947-20210823
X-UUID: 26baf71f73864d50884a4bbbc0737947-20210823
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <kewei.xu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1024271164; Mon, 23 Aug 2021 21:05:46 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 23 Aug 2021 21:05:44 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 23 Aug 2021 21:05:43 +0800
From:   Kewei Xu <kewei.xu@mediatek.com>
To:     <wsa@the-dreams.de>
CC:     <matthias.bgg@gmail.com>, <robh+dt@kernel.org>,
        <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>,
        <qii.wang@mediatek.com>, <liguo.zhang@mediatek.com>,
        <caiyu.chen@mediatek.com>, <ot_daolong.zhu@mediatek.com>,
        <yuhan.wei@mediatek.com>, <kewei.xu@mediatek.com>
Subject: [PATCH 4/7] dt-bindings: i2c: add attribute use-default-timing
Date:   Mon, 23 Aug 2021 21:05:34 +0800
Message-ID: <1629723937-10839-5-git-send-email-kewei.xu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1629723937-10839-1-git-send-email-kewei.xu@mediatek.com>
References: <1629723937-10839-1-git-send-email-kewei.xu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Add attribute use-default-timing for DT-binding document.

Fixes: be5ce0e97cc7 ("i2c: mediatek: Add i2c ac-timing adjust support")
Signed-off-by: Kewei Xu <kewei.xu@mediatek.com>
---
 Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt b/Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt
index 5ea216a..4dbb697 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt
@@ -34,6 +34,8 @@ Optional properties:
     Only mt6589 and mt8135 support this feature.
   - mediatek,use-push-pull: IO config use push-pull mode.
   - vbus-supply: phandle to the regulator that provides power to SCL/SDA.
+  - mediatek,use-default-timing: use default timing calculation, no timing
+    adjustment.
 
 Example:
 
-- 
1.9.1

