From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] MAINTAINERS: i2c: drop i2c-pnx maintainer
Date: Sun, 25 Oct 2015 16:31:24 +0100
Message-ID: <1445787084-23263-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46278 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751327AbbJYPbd (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 25 Oct 2015 11:31:33 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Vitaly Wool <vitalywool@gmail.com>

Vitaly last acked patch was in 2010. He moved on probably...

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: Vitaly Wool <vitalywool@gmail.com>
---

Vitaly, you may prove me wrong by nacking this patch :)

 MAINTAINERS | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3450a6b6d856da..37b6241f888508 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8277,12 +8277,6 @@ M:	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
 S:	Maintained
 F:	drivers/pnp/
 
-PNXxxxx I2C DRIVER
-M:	Vitaly Wool <vitalywool@gmail.com>
-L:	linux-i2c@vger.kernel.org
-S:	Maintained
-F:	drivers/i2c/busses/i2c-pnx.c
-
 PPP PROTOCOL DRIVERS AND COMPRESSORS
 M:	Paul Mackerras <paulus@samba.org>
 L:	linux-ppp@vger.kernel.org
-- 
2.1.4
