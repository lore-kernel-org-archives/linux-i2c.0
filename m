From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] MAINTAINERS: move Mika and me to designated reviewers
Date: Tue,  8 Mar 2016 11:19:24 +0200
Message-ID: <1457428764-80793-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:27573 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932132AbcCHJTb (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 8 Mar 2016 04:19:31 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Jarkko is a main contact to handle i2c-designware driver. Move Mika and me to
designated reviewers which we actualy are.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f5e6a53..465fc58 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9540,9 +9540,9 @@ F: Documentation/devicetree/bindings/net/snps,dwc-qos-ethernet.txt
 F: drivers/net/ethernet/synopsys/dwc_eth_qos.c
 
 SYNOPSYS DESIGNWARE I2C DRIVER
-M:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 M:	Jarkko Nikula <jarkko.nikula@linux.intel.com>
-M:	Mika Westerberg <mika.westerberg@linux.intel.com>
+R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+R:	Mika Westerberg <mika.westerberg@linux.intel.com>
 L:	linux-i2c@vger.kernel.org
 S:	Maintained
 F:	drivers/i2c/busses/i2c-designware-*
-- 
2.7.0
