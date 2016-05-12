From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v9 6/8] i2c: octeon: Sort include files alphabetically
Date: Thu, 12 May 2016 14:22:14 +0200
Message-ID: <1463055736-20025-7-git-send-email-jglauber@cavium.com>
References: <1463055736-20025-1-git-send-email-jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463055736-20025-1-git-send-email-jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Jan Glauber <jglauber@cavium.com>
List-Id: linux-i2c@vger.kernel.org

Sort include files alphabetically to reduce probability of merge
conflicts.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon-core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon-core.c b/drivers/i2c/busses/i2c-octeon-core.c
index 038007d..ce535fa 100644
--- a/drivers/i2c/busses/i2c-octeon-core.c
+++ b/drivers/i2c/busses/i2c-octeon-core.c
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
 #include "i2c-cavium.h"
-- 
1.9.1
