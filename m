From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 2/7] i2c: use proper name for the R-Car SoC
Date: Sun, 28 May 2017 11:30:45 +0200
Message-ID: <20170528093051.11816-3-wsa+renesas@sang-engineering.com>
References: <20170528093051.11816-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:50744 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751009AbdE1Jaz (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 28 May 2017 05:30:55 -0400
In-Reply-To: <20170528093051.11816-1-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

It is 'R-Car', not 'RCar'. No code or binding changes, only descriptive text.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
I suggest this trivial patch should be picked individually per susbsystem.

 drivers/i2c/busses/i2c-rcar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 214bf2835d1f95..214a71cb64429f 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -1,5 +1,5 @@
 /*
- * Driver for the Renesas RCar I2C unit
+ * Driver for the Renesas R-Car I2C unit
  *
  * Copyright (C) 2014-15 Wolfram Sang <wsa@sang-engineering.com>
  * Copyright (C) 2011-2015 Renesas Electronics Corporation
-- 
2.11.0
