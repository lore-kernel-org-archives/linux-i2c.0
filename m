Return-Path: <SRS0=DpqV=C2=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A66C433E2
	for <linux-i2c@archiver.kernel.org>; Thu, 17 Sep 2020 19:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B741720717
	for <linux-i2c@archiver.kernel.org>; Thu, 17 Sep 2020 19:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600370050;
	bh=74a8gevZmHOYjuvHZt7Qr+t93+WdAfxf6W1JkX3XHhU=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SCRox6fTk7FBx9Wv+fBqaiMRKd4JnZRS035n+CHUH/Ee9pe6owTEvs9+VLVIFfx6e
	 6G6fAraRHvWZEILJ7Fh+0hhmFWBbMAHhcnRtJxXK2PDY5+5czcNEmopwCE+zTAwyzA
	 o8xFK7WJhbadHKwMX56Ow1SyLi3YDUlwALYm/ggs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgIQTOI (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 17 Sep 2020 15:14:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbgIQTNj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 17 Sep 2020 15:13:39 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 583A72085B;
        Thu, 17 Sep 2020 19:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600370019;
        bh=74a8gevZmHOYjuvHZt7Qr+t93+WdAfxf6W1JkX3XHhU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FTepfaZE3+JJRZC5nd6xorL+Ztojruffy4PDMnssB3jue7GA2grbRVjl6NREbS4KJ
         fcwQWR0ChxbFHXZGq4HQTVgG6VVukPyoH2gTCLj59TN4jKgOw33netPfNp629GfWjn
         TKwbeK6v4wh/RqIuN3pWWqat86C2slSgNZEwCwVo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Wolfram Sang <wolfram@the-dreams.de>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] dt-bindings: i2c: imx: Fix i.MX 7 compatible matching
Date:   Thu, 17 Sep 2020 21:13:21 +0200
Message-Id: <20200917191321.28741-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200917191321.28741-1-krzk@kernel.org>
References: <20200917191321.28741-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

The i.MX 7 DTSes use two compatibles so update the binding to fix
dtbs_check warnings like:

  arch/arm/boot/dts/imx7d-cl-som-imx7.dt.yaml: i2c@30a20000:
    compatible: ['fsl,imx7d-i2c', 'fsl,imx21-i2c'] is not valid under any of the given schemas (Possible causes of the failure):

  arch/arm/boot/dts/imx7d-cl-som-imx7.dt.yaml: i2c@30a20000:
    compatible: ['fsl,imx7d-i2c', 'fsl,imx21-i2c'] is too long

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/i2c/i2c-imx.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-imx.yaml b/Documentation/devicetree/bindings/i2c/i2c-imx.yaml
index a0c87307ca07..f23966b0d6c6 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-imx.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-imx.yaml
@@ -21,6 +21,9 @@ properties:
       - items:
           - const: fsl,imx35-i2c
           - const: fsl,imx1-i2c
+      - items:
+          - const: fsl,imx7d-i2c
+          - const: fsl,imx21-i2c
       - items:
           - enum:
               - fsl,imx25-i2c
-- 
2.17.1

