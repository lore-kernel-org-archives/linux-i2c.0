From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH] i2c-i801: Fix the alignment of the device table
Date: Mon, 23 Jun 2014 10:36:58 +0200
Message-ID: <20140623103658.57df2c14@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

A long name broke the alignment, shift the columns a bit to fix it and
make the table look nice again. While we're here, switch to the
standard comment style to make checkpatch happy.

Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/i2c/busses/i2c-i801.c |  102 +++++++++++++++++++++---------------------
 1 file changed, 51 insertions(+), 51 deletions(-)

--- linux-3.16-rc1.orig/drivers/i2c/busses/i2c-i801.c	2014-06-16 05:45:28.000000000 +0200
+++ linux-3.16-rc1/drivers/i2c/busses/i2c-i801.c	2014-06-23 10:33:04.341790691 +0200
@@ -22,57 +22,57 @@
 */
 
 /*
-  Supports the following Intel I/O Controller Hubs (ICH):
-
-                                  I/O                     Block   I2C
-                                  region  SMBus   Block   proc.   block
-  Chip name             PCI ID    size    PEC     buffer  call    read
-  ----------------------------------------------------------------------
-  82801AA  (ICH)        0x2413     16      no      no      no      no
-  82801AB  (ICH0)       0x2423     16      no      no      no      no
-  82801BA  (ICH2)       0x2443     16      no      no      no      no
-  82801CA  (ICH3)       0x2483     32     soft     no      no      no
-  82801DB  (ICH4)       0x24c3     32     hard     yes     no      no
-  82801E   (ICH5)       0x24d3     32     hard     yes     yes     yes
-  6300ESB               0x25a4     32     hard     yes     yes     yes
-  82801F   (ICH6)       0x266a     32     hard     yes     yes     yes
-  6310ESB/6320ESB       0x269b     32     hard     yes     yes     yes
-  82801G   (ICH7)       0x27da     32     hard     yes     yes     yes
-  82801H   (ICH8)       0x283e     32     hard     yes     yes     yes
-  82801I   (ICH9)       0x2930     32     hard     yes     yes     yes
-  EP80579 (Tolapai)     0x5032     32     hard     yes     yes     yes
-  ICH10                 0x3a30     32     hard     yes     yes     yes
-  ICH10                 0x3a60     32     hard     yes     yes     yes
-  5/3400 Series (PCH)   0x3b30     32     hard     yes     yes     yes
-  6 Series (PCH)        0x1c22     32     hard     yes     yes     yes
-  Patsburg (PCH)        0x1d22     32     hard     yes     yes     yes
-  Patsburg (PCH) IDF    0x1d70     32     hard     yes     yes     yes
-  Patsburg (PCH) IDF    0x1d71     32     hard     yes     yes     yes
-  Patsburg (PCH) IDF    0x1d72     32     hard     yes     yes     yes
-  DH89xxCC (PCH)        0x2330     32     hard     yes     yes     yes
-  Panther Point (PCH)   0x1e22     32     hard     yes     yes     yes
-  Lynx Point (PCH)      0x8c22     32     hard     yes     yes     yes
-  Lynx Point-LP (PCH)   0x9c22     32     hard     yes     yes     yes
-  Avoton (SOC)          0x1f3c     32     hard     yes     yes     yes
-  Wellsburg (PCH)       0x8d22     32     hard     yes     yes     yes
-  Wellsburg (PCH) MS    0x8d7d     32     hard     yes     yes     yes
-  Wellsburg (PCH) MS    0x8d7e     32     hard     yes     yes     yes
-  Wellsburg (PCH) MS    0x8d7f     32     hard     yes     yes     yes
-  Coleto Creek (PCH)    0x23b0     32     hard     yes     yes     yes
-  Wildcat Point-LP (PCH)   0x9ca2     32     hard     yes     yes     yes
-  BayTrail (SOC)        0x0f12     32     hard     yes     yes     yes
-
-  Features supported by this driver:
-  Software PEC                     no
-  Hardware PEC                     yes
-  Block buffer                     yes
-  Block process call transaction   no
-  I2C block read transaction       yes  (doesn't use the block buffer)
-  Slave mode                       no
-  Interrupt processing             yes
-
-  See the file Documentation/i2c/busses/i2c-i801 for details.
-*/
+ * Supports the following Intel I/O Controller Hubs (ICH):
+ *
+ *                                  I/O                     Block   I2C
+ *                                  region  SMBus   Block   proc.   block
+ * Chip name               PCI ID   size    PEC     buffer  call    read
+ * -----------------------------------------------------------------------
+ * 82801AA (ICH)           0x2413    16      no      no      no      no
+ * 82801AB (ICH0)          0x2423    16      no      no      no      no
+ * 82801BA (ICH2)          0x2443    16      no      no      no      no
+ * 82801CA (ICH3)          0x2483    32     soft     no      no      no
+ * 82801DB (ICH4)          0x24c3    32     hard     yes     no      no
+ * 82801E (ICH5)           0x24d3    32     hard     yes     yes     yes
+ * 6300ESB                 0x25a4    32     hard     yes     yes     yes
+ * 82801F (ICH6)           0x266a    32     hard     yes     yes     yes
+ * 6310ESB/6320ESB         0x269b    32     hard     yes     yes     yes
+ * 82801G (ICH7)           0x27da    32     hard     yes     yes     yes
+ * 82801H (ICH8)           0x283e    32     hard     yes     yes     yes
+ * 82801I (ICH9)           0x2930    32     hard     yes     yes     yes
+ * EP80579 (Tolapai)       0x5032    32     hard     yes     yes     yes
+ * ICH10                   0x3a30    32     hard     yes     yes     yes
+ * ICH10                   0x3a60    32     hard     yes     yes     yes
+ * 5/3400 Series (PCH)     0x3b30    32     hard     yes     yes     yes
+ * 6 Series (PCH)          0x1c22    32     hard     yes     yes     yes
+ * Patsburg (PCH)          0x1d22    32     hard     yes     yes     yes
+ * Patsburg (PCH) IDF      0x1d70    32     hard     yes     yes     yes
+ * Patsburg (PCH) IDF      0x1d71    32     hard     yes     yes     yes
+ * Patsburg (PCH) IDF      0x1d72    32     hard     yes     yes     yes
+ * DH89xxCC (PCH)          0x2330    32     hard     yes     yes     yes
+ * Panther Point (PCH)     0x1e22    32     hard     yes     yes     yes
+ * Lynx Point (PCH)        0x8c22    32     hard     yes     yes     yes
+ * Lynx Point-LP (PCH)     0x9c22    32     hard     yes     yes     yes
+ * Avoton (SOC)            0x1f3c    32     hard     yes     yes     yes
+ * Wellsburg (PCH)         0x8d22    32     hard     yes     yes     yes
+ * Wellsburg (PCH) MS      0x8d7d    32     hard     yes     yes     yes
+ * Wellsburg (PCH) MS      0x8d7e    32     hard     yes     yes     yes
+ * Wellsburg (PCH) MS      0x8d7f    32     hard     yes     yes     yes
+ * Coleto Creek (PCH)      0x23b0    32     hard     yes     yes     yes
+ * Wildcat Point-LP (PCH)  0x9ca2    32     hard     yes     yes     yes
+ * BayTrail (SOC)          0x0f12    32     hard     yes     yes     yes
+ *
+ * Features supported by this driver:
+ * Software PEC                     no
+ * Hardware PEC                     yes
+ * Block buffer                     yes
+ * Block process call transaction   no
+ * I2C block read transaction       yes  (doesn't use the block buffer)
+ * Slave mode                       no
+ * Interrupt processing             yes
+ *
+ * See the file Documentation/i2c/busses/i2c-i801 for details.
+ */
 
 #include <linux/interrupt.h>
 #include <linux/module.h>


-- 
Jean Delvare
SUSE L3 Support
