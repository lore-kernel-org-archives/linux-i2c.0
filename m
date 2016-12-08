From: Jan Kotas <jank@cadence.com>
Subject: [PATCH] i2c: cadence: Allow Cadence I2C to be selected for Cadence Xtensa CPUs
Date: Thu, 8 Dec 2016 09:47:58 +0000
Message-ID: <1481190478-16718-1-git-send-email-jank@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:39781 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750989AbcLHKHw (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 8 Dec 2016 05:07:52 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jan Kotas <jank@cadence.com>

This patch allows Cadence I2C controller to be selected in systems using Cadence Xtensa processors.

Signed-off-by: Jan Kotas <jank@cadence.com>
---
 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index d252276..87271c3 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -426,7 +426,7 @@ config I2C_BLACKFIN_TWI_CLK_KHZ
 
 config I2C_CADENCE
 	tristate "Cadence I2C Controller"
-	depends on ARCH_ZYNQ || ARM64
+	depends on ARCH_ZYNQ || ARM64 || XTENSA
 	help
 	  Say yes here to select Cadence I2C Host Controller. This controller is
 	  e.g. used by Xilinx Zynq.
-- 
2.4.5
