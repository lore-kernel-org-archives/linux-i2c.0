From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v11 6/8] i2c: octeon: Sort include files alphabetically
Date: Wed, 24 Aug 2016 23:25:47 +0200
Message-ID: <20160824212549.16140-7-jglauber@cavium.com>
References: <20160824212549.16140-1-jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160824212549.16140-1-jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Jan Glauber <jglauber@cavium.com>
List-Id: linux-i2c@vger.kernel.org

Sort include files alphabetically to reduce probability of merge
conflicts.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon-platdrv.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon-platdrv.c b/drivers/i2c/busses/i2c-octeon-platdrv.c
index 916ebee..ce2765f 100644
--- a/drivers/i2c/busses/i2c-octeon-platdrv.c
+++ b/drivers/i2c/busses/i2c-octeon-platdrv.c
@@ -12,16 +12,16 @@
  */
 
 #include <linux/atomic.h>
-#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/delay.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/i2c.h>
-#include <linux/io.h>
-#include <linux/of.h>
 
 #include <asm/octeon/octeon.h>
 #include "i2c-octeon-core.h"
-- 
2.9.0.rc0.21.g7777322
