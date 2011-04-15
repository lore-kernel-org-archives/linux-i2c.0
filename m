From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] i2c: add a module alias to the sh-mobile driver
Date: Fri, 15 Apr 2011 20:18:57 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1104152017400.18593@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>
List-Id: linux-i2c@vger.kernel.org

This patch enables I2C driver autoloading on sh-mobile systems.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <damm@opensource.se>
---
 drivers/i2c/busses/i2c-sh_mobile.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 2707f5e..81ccd78 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -729,3 +729,4 @@ module_exit(sh_mobile_i2c_adap_exit);
 MODULE_DESCRIPTION("SuperH Mobile I2C Bus Controller driver");
 MODULE_AUTHOR("Magnus Damm");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:i2c-sh_mobile");
-- 
1.7.2.5

