From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] MAINTAINERS: add maintainers for Synopsis Designware I2C drivers
Date: Thu, 15 Oct 2015 15:58:53 +0200
Message-ID: <1444917533-1981-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:38680 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752642AbbJON7F (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 15 Oct 2015 09:59:05 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

Those guys already have been helpful in the past and are actively
working on this driver, unlike me.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
---

As suggested by Jarkko here:
http://article.gmane.org/gmane.linux.drivers.i2c/24834

 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5f467845ef725f..58d6b02d2dea78 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9101,6 +9101,15 @@ S: Supported
 F: Documentation/devicetree/bindings/net/snps,dwc-qos-ethernet.txt
 F: drivers/net/ethernet/synopsys/dwc_eth_qos.c
 
+SYNOPSYS DESIGNWARE I2C DRIVER
+M:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+M:	Jarkko Nikula <jarkko.nikula@linux.intel.com>
+M:	Mika Westerberg <mika.westerberg@linux.intel.com>
+L:	linux-i2c@vger.kernel.org
+S:	Maintained
+F:	drivers/i2c/busses/i2c-designware-*
+F:	include/linux/platform_data/i2c-designware.h
+
 SYNOPSYS DESIGNWARE MMC/SD/SDIO DRIVER
 M:	Seungwon Jeon <tgih.jun@samsung.com>
 M:	Jaehoon Chung <jh80.chung@samsung.com>
-- 
2.1.4
