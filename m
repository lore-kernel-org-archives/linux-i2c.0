From: Yuan Yao <yao.yuan@freescale.com>
Subject: [PATCH v10 1/3] i2c: imx: Sort include headers alphabetically
Date: Mon, 17 Nov 2014 18:40:34 +0800
Message-ID: <1416220836-7666-2-git-send-email-yao.yuan@freescale.com>
References: <1416220836-7666-1-git-send-email-yao.yuan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1416220836-7666-1-git-send-email-yao.yuan@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: wsa@the-dreams.de, marex@denx.de
Cc: mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, fugang.duan@freescale.com, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, LW@KARO-electronics.de
List-Id: linux-i2c@vger.kernel.org

If the inlcude headers aren't sorted alphabetically, then the
logical choice is to append new ones, however that creates a
lot of potential for conflicts or duplicates because every change
will then add new includes in the same location.

Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
---
 drivers/i2c/busses/i2c-imx.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index a7a2a79..d025c47 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -32,22 +32,22 @@
 /** Includes *******************************************************************
 *******************************************************************************/
 
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/errno.h>
-#include <linux/err.h>
-#include <linux/interrupt.h>
+#include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/errno.h>
 #include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
-#include <linux/sched.h>
-#include <linux/platform_device.h>
-#include <linux/clk.h>
-#include <linux/slab.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_data/i2c-imx.h>
+#include <linux/platform_device.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
 
 /** Defines ********************************************************************
 *******************************************************************************/
-- 
2.1.0.27.g96db324
