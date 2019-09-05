From: Saiyam Doshi <saiyamdoshi.in@gmail.com>
Subject: [PATCH v2] i2c: muxes: pca9541: use BIT() macro
Date: Thu, 5 Sep 2019 23:34:23 +0530
Message-ID: <20190905180423.GA7477@SD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux@roeck-us.net, peda@axentia.se
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Use bit mask macro BIT() for definition where appropriate.

Signed-off-by: Saiyam Doshi <saiyamdoshi.in@gmail.com>
---
Changes in v2:
* Include linux/bits.h which defines BIT()

 drivers/i2c/muxes/i2c-mux-pca9541.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
index 50e1fb4aedf5..c9b17a305bb5 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -16,6 +16,7 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/bits.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/i2c.h>
@@ -42,20 +43,20 @@
 #define PCA9541_CONTROL		0x01
 #define PCA9541_ISTAT		0x02
 
-#define PCA9541_CTL_MYBUS	(1 << 0)
-#define PCA9541_CTL_NMYBUS	(1 << 1)
-#define PCA9541_CTL_BUSON	(1 << 2)
-#define PCA9541_CTL_NBUSON	(1 << 3)
-#define PCA9541_CTL_BUSINIT	(1 << 4)
-#define PCA9541_CTL_TESTON	(1 << 6)
-#define PCA9541_CTL_NTESTON	(1 << 7)
-
-#define PCA9541_ISTAT_INTIN	(1 << 0)
-#define PCA9541_ISTAT_BUSINIT	(1 << 1)
-#define PCA9541_ISTAT_BUSOK	(1 << 2)
-#define PCA9541_ISTAT_BUSLOST	(1 << 3)
-#define PCA9541_ISTAT_MYTEST	(1 << 6)
-#define PCA9541_ISTAT_NMYTEST	(1 << 7)
+#define PCA9541_CTL_MYBUS	BIT(0)
+#define PCA9541_CTL_NMYBUS	BIT(1)
+#define PCA9541_CTL_BUSON	BIT(2)
+#define PCA9541_CTL_NBUSON	BIT(3)
+#define PCA9541_CTL_BUSINIT	BIT(4)
+#define PCA9541_CTL_TESTON	BIT(6)
+#define PCA9541_CTL_NTESTON	BIT(7)
+
+#define PCA9541_ISTAT_INTIN	BIT(0)
+#define PCA9541_ISTAT_BUSINIT	BIT(1)
+#define PCA9541_ISTAT_BUSOK	BIT(2)
+#define PCA9541_ISTAT_BUSLOST	BIT(3)
+#define PCA9541_ISTAT_MYTEST	BIT(6)
+#define PCA9541_ISTAT_NMYTEST	BIT(7)
 
 #define BUSON		(PCA9541_CTL_BUSON | PCA9541_CTL_NBUSON)
 #define MYBUS		(PCA9541_CTL_MYBUS | PCA9541_CTL_NMYBUS)
-- 
2.20.1
