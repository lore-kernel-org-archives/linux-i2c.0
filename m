From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] MAINTAINERS: Add entry for drivers/i2c/busses/i2c-cht-wc.c
Date: Mon, 28 Aug 2017 18:40:29 +0200
Message-ID: <20170828164029.2274-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44112 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751198AbdH1Qkc (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 28 Aug 2017 12:40:32 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-i2c@vger.kernel.org

Add an entry for drivers/i2c/busses/i2c-cht-wc.c and add myself as
maintainer of this driver.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index db633caa5a1d..d6eb0bf29bcc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6378,6 +6378,12 @@ F:	drivers/i2c/busses/i2c-sis96x.c
 F:	drivers/i2c/busses/i2c-via.c
 F:	drivers/i2c/busses/i2c-viapro.c
 
+I2C/SMBUS INTEL CHT WHISKEY COVE PMIC DRIVER
+M:	Hans de Goede <hdegoede@redhat.com>
+L:	linux-i2c@vger.kernel.org
+S:	Maintained
+F:	drivers/i2c/busses/i2c-cht-wc.c
+
 I2C/SMBUS ISMT DRIVER
 M:	Seth Heasley <seth.heasley@intel.com>
 M:	Neil Horman <nhorman@tuxdriver.com>
-- 
2.13.4
