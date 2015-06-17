From: York Sun <yorksun@freescale.com>
Subject: [RFC] drivers/clk/Kconfig: Change COMMON_CLK to tristate
Date: Wed, 17 Jun 2015 12:01:47 -0700
Message-ID: <1434567707-9352-1-git-send-email-yorksun@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mturquette@baylibre.com
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, York Sun <yorksun@freescale.com>, Paul Bolle <pebolle@tiscali.nl>
List-Id: linux-i2c@vger.kernel.org

COMMON_CLK has been a bool value, selected by the platforms who need
common clock framework. If a CCF driver is needed on an add-on device
such as PCIe card, COMMON_CLK can be selected individually as a
tristate value.

Signed-off-by: York Sun <yorksun@freescale.com>
CC: Paul Bolle <pebolle@tiscali.nl>
CC: Mike Turquette <mturquette@baylibre.com>
---
 drivers/clk/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 32b2219..07f0b2f 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -10,7 +10,7 @@ config HAVE_MACH_CLKDEV
 	bool
 
 config COMMON_CLK
-	bool
+	tristate "Common Clock"
 	select HAVE_CLK_PREPARE
 	select CLKDEV_LOOKUP
 	select SRCU
-- 
1.7.9.5
