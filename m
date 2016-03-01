From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH] i2c-thunderx: fix compile error for x86_64
Date: Tue,  1 Mar 2016 14:53:18 +0100
Message-ID: <1456840398-9275-1-git-send-email-jglauber@cavium.com>
References: <25e8960abe506539a230db6d31ab75e7195752b8.1456752497.git.jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36477 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753469AbcCANx4 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 1 Mar 2016 08:53:56 -0500
In-Reply-To: <25e8960abe506539a230db6d31ab75e7195752b8.1456752497.git.jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Jan Glauber <jglauber@cavium.com>

The i2c-thunderx driver only depends on 64BIT and PCI,
because there is no reason to limit it to ARM64.

Adjusting the check in the header file that selects Octeon
or ThunderX values to check for CONFIG_I2C_THUNDERX
instead of CONFIG_ARCH_THUNDER fixes the compile error
on x86_64.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-cavium.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-cavium.h b/drivers/i2c/busses/i2c-cavium.h
index 8357997..c7398f4 100644
--- a/drivers/i2c/busses/i2c-cavium.h
+++ b/drivers/i2c/busses/i2c-cavium.h
@@ -8,7 +8,7 @@
 #include <linux/pci.h>
 
 /* Register offsets */
-#ifdef CONFIG_ARCH_THUNDER
+#ifdef CONFIG_I2C_THUNDERX
 	#define SW_TWSI			0x1000
 	#define TWSI_INT		0x1010
 	#define SW_TWSI_EXT		0x1018
-- 
1.9.1
