From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 4/4] ARM: dts: at91: tse850: use the correct compatible for the eeprom
Date: Tue, 16 Jan 2018 17:06:18 +0100
Message-ID: <20180116160618.27859-5-peda@axentia.se>
References: <20180116160618.27859-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr00136.outbound.protection.outlook.com ([40.107.0.136]:12544
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750868AbeAPQGq (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 16 Jan 2018 11:06:46 -0500
In-Reply-To: <20180116160618.27859-1-peda@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Russell King <linux@armlinux.org.uk>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The used part does contain an eeprom compatible with an Atmel 24c02
chip and it is from NXP, but it is not called 24c02. It's actually a
se97b chip. Adjust the compatible accordingly.

Fixes: 21dd0ece34c2 ("ARM: dts: at91: add devicetree for the Axentia TSE-850")
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 arch/arm/boot/dts/at91-tse850-3.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-tse850-3.dts b/arch/arm/boot/dts/at91-tse850-3.dts
index 9b82cc8843e1..97b227693658 100644
--- a/arch/arm/boot/dts/at91-tse850-3.dts
+++ b/arch/arm/boot/dts/at91-tse850-3.dts
@@ -246,7 +246,7 @@
 	};
 
 	eeprom@50 {
-		compatible = "nxp,24c02", "atmel,24c02";
+		compatible = "nxp,se97b", "atmel,24c02";
 		reg = <0x50>;
 		pagesize = <16>;
 	};
-- 
2.11.0
