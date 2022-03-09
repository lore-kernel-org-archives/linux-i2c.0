Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC78C433F5
	for <linux-i2c@archiver.kernel.org>; Wed,  9 Mar 2022 12:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbiCIMIm (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 9 Mar 2022 07:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbiCIMIm (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 9 Mar 2022 07:08:42 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA1C6D877;
        Wed,  9 Mar 2022 04:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646827660; x=1678363660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SPoqSZocfjBDQM7PDGGLqUQ9iJSp5hgCrxwujOTgUZg=;
  b=PfAGDOtuLZ7A7Ptzme3Al5l+AYUkB9NymSmv1TWzncaW6PJGxQ+NZgl4
   BUzivTj1legz2pJIJg5nLSwdbmc1efsdgWrP44WXPRtVopw9ILDzE++QK
   BOtTT/0rRov1/9Fv5a2XJWNFJfMtQDN6xOvxsUXIJ8qpiyJ/tvOh8C1IX
   AFYwSxhKGRQyWVGMq2/sBlDrBTIcU47T+qTELD4VIJtFqJilLrRj0Rh8Y
   skSE07ibyAJQGNNOhyDc0XBz2szXyE0kWZXwg14FGEb5yZ/lVUeHYieTX
   N0ueVeQ8Ctk6PVjvH+i73/CROA1Woxjv2DTaco4n2M7OXWuAhWWAzVzAn
   w==;
X-IronPort-AV: E=Sophos;i="5.90,167,1643698800"; 
   d="scan'208";a="156252239"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Mar 2022 05:07:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Mar 2022 05:07:38 -0700
Received: from ROB-ULT-M68701.amer.actel.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 9 Mar 2022 05:07:36 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-i2c@vger.kernel.org>,
        Sergiu Moga <sergiu.moga@microchip.com>
Subject: [PATCH 1/3] ARM: dts: at91: sama7g5: Swap `rx` and `tx` for `i2c` nodes
Date:   Wed, 9 Mar 2022 14:07:12 +0200
Message-ID: <20220309120714.51393-2-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220309120714.51393-1-sergiu.moga@microchip.com>
References: <20220309120714.51393-1-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Swap `rx` and `tx` for the `dma-names` property of the `i2c` nodes
in order to maintain consistency across Microchip/Atmel SoC files.

Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
---
 arch/arm/boot/dts/sama7g5.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
index 4decd3a91a76..f691c8f08d04 100644
--- a/arch/arm/boot/dts/sama7g5.dtsi
+++ b/arch/arm/boot/dts/sama7g5.dtsi
@@ -601,9 +601,9 @@ i2c1: i2c@600 {
 				#size-cells = <0>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 39>;
 				atmel,fifo-size = <32>;
-				dmas = <&dma0 AT91_XDMAC_DT_PERID(7)>,
-					<&dma0 AT91_XDMAC_DT_PERID(8)>;
-				dma-names = "rx", "tx";
+				dmas = <&dma0 AT91_XDMAC_DT_PERID(8)>,
+					<&dma0 AT91_XDMAC_DT_PERID(7)>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 		};
@@ -786,9 +786,9 @@ i2c8: i2c@600 {
 				#size-cells = <0>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 46>;
 				atmel,fifo-size = <32>;
-				dmas = <&dma0 AT91_XDMAC_DT_PERID(21)>,
-					<&dma0 AT91_XDMAC_DT_PERID(22)>;
-				dma-names = "rx", "tx";
+				dmas = <&dma0 AT91_XDMAC_DT_PERID(22)>,
+					<&dma0 AT91_XDMAC_DT_PERID(21)>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 		};
@@ -810,9 +810,9 @@ i2c9: i2c@600 {
 				#size-cells = <0>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 47>;
 				atmel,fifo-size = <32>;
-				dmas = <&dma0 AT91_XDMAC_DT_PERID(23)>,
-					<&dma0 AT91_XDMAC_DT_PERID(24)>;
-				dma-names = "rx", "tx";
+				dmas = <&dma0 AT91_XDMAC_DT_PERID(24)>,
+					<&dma0 AT91_XDMAC_DT_PERID(23)>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 		};
-- 
2.25.1

