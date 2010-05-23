From: Andrea Gelmini <andrea.gelmini-PT7Us6ch6G9eoWH0uzbU5w@public.gmane.org>
Subject: [PATCH 045/199] Documentation/i2c/busses/i2c-pca-isa: Checkpatch cleanup
Date: Sun, 23 May 2010 21:56:13 +0200
Message-ID: <1274644605-25181-17-git-send-email-andrea.gelmini@gelma.net>
References: <1274644605-25181-1-git-send-email-andrea.gelmini@gelma.net>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1274644605-25181-1-git-send-email-andrea.gelmini-PT7Us6ch6G9eoWH0uzbU5w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: andrea.gelmini-PT7Us6ch6G9eoWH0uzbU5w@public.gmane.org
Cc: "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Documentation/i2c/busses/i2c-pca-isa:4: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-pca-isa:5: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-pca-isa:7: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-pca-isa:15: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-pca-isa:16: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-pca-isa:22: ERROR: trailing whitespace
Documentation/i2c/busses/i2c-pca-isa:23: ERROR: trailing whitespace

Signed-off-by: Andrea Gelmini <andrea.gelmini-PT7Us6ch6G9eoWH0uzbU5w@public.gmane.org>
---
 Documentation/i2c/busses/i2c-pca-isa |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/i2c/busses/i2c-pca-isa b/Documentation/i2c/busses/i2c-pca-isa
index 6fc8f4c..b044e52 100644
--- a/Documentation/i2c/busses/i2c-pca-isa
+++ b/Documentation/i2c/busses/i2c-pca-isa
@@ -1,10 +1,10 @@
 Kernel driver i2c-pca-isa
 
 Supported adapters:
-This driver supports ISA boards using the Philips PCA 9564 
-Parallel bus to I2C bus controller 
+This driver supports ISA boards using the Philips PCA 9564
+Parallel bus to I2C bus controller
 
-Author: Ian Campbell <icampbell-2sJRl1BP9u0AvxtiuMwx3w@public.gmane.org>, Arcom Control Systems 
+Author: Ian Campbell <icampbell-2sJRl1BP9u0AvxtiuMwx3w@public.gmane.org>, Arcom Control Systems
 
 Module Parameters
 -----------------
@@ -12,12 +12,12 @@ Module Parameters
 * base int
  I/O base address
 * irq int
- IRQ interrupt 
-* clock int 
+ IRQ interrupt
+* clock int
  Clock rate as described in table 1 of PCA9564 datasheet
 
 Description
 -----------
 
-This driver supports ISA boards using the Philips PCA 9564 
-Parallel bus to I2C bus controller 
+This driver supports ISA boards using the Philips PCA 9564
+Parallel bus to I2C bus controller
-- 
1.7.1.251.gf80a2
