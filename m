Return-Path: <SRS0=YXQZ=CN=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81424C43461
	for <linux-i2c@archiver.kernel.org>; Fri,  4 Sep 2020 15:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5735B2074D
	for <linux-i2c@archiver.kernel.org>; Fri,  4 Sep 2020 15:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599232483;
	bh=tBuZCR5xiv1qjye1QG9PxK9ZNp+DEVBnbx0PDmvTlWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d0RHNwvQ32iGfr86ZQGvEGeHpbHXty0zIvvaQnoRvd2ZoL0vrUcPqr4nBu1+T4fCR
	 VJ+Wy1csYMFQMcG69O0raSbhn3F3zdBqGQgG1BC7O0MXzrZuaR6J7Qx1m4zG0cnLhQ
	 57rnKlJwd2EBxYxMTbNvvQpm9U7YubYBLDmt9KPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730847AbgIDPOi (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:14:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730815AbgIDPO2 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 4 Sep 2020 11:14:28 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF1342074D;
        Fri,  4 Sep 2020 15:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599232468;
        bh=tBuZCR5xiv1qjye1QG9PxK9ZNp+DEVBnbx0PDmvTlWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lVHcSosQVaM/W3llWDSMPdjYLEu2J3Oq2lGobDsihOxz5ocycMsYQSqfQm/geRkcQ
         IEjFwlZ1rHsUG1rvt45G+7qqiPtfjVVjoRYiwGrxCWLld9yI3+FgfpcNG/86/uRXEk
         Xm1vDKpV1NtnTuiOaFZ7smMh4ai43WZO9bOl0jAo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Wolfram Sang <wolfram@the-dreams.de>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 4/4] dt-bindings: i2c: imx: Fix i.MX 7 compatible matching
Date:   Fri,  4 Sep 2020 17:14:11 +0200
Message-Id: <20200904151411.18973-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904151411.18973-1-krzk@kernel.org>
References: <20200904151411.18973-1-krzk@kernel.org>
Sender: linux-i2c-owner@vger.kernel.org
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
index 19c9daba6e9f..3a0fbeea7aaf 100644
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

