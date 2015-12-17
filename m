From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] i2c: emev: select I2C slave support
Date: Thu, 17 Dec 2015 13:09:32 +0100
Message-ID: <1450354172-5656-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:53517 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756077AbbLQMJ5 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 17 Dec 2015 07:09:57 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, Wolfram Sang <wsa+renesas@sang-engineering.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Until we have proper support to make I2C slave support fully optional,
select it to prevent build errors on randconfigs.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index eaa7b4a0e48438..0299dfa746a387 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -532,6 +532,7 @@ config I2C_EG20T
 config I2C_EMEV2
 	tristate "EMMA Mobile series I2C adapter"
 	depends on HAVE_CLK
+	select I2C_SLAVE
 	help
 	  If you say yes to this option, support will be included for the
 	  I2C interface on the Renesas Electronics EM/EV family of processors.
-- 
2.1.4
