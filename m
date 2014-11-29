From: Danielle Costantino <danielle.costantino-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c: mpc: add register documentation to Freescale I2C driver
Date: Sat, 29 Nov 2014 13:58:42 -0800
Message-ID: <547A4192.30102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

i2c: mpc: add register documentation to Freescale I2C driver

return -ETIMEDOUT for all time-out error conditions and warn on 
arbitration lost.

Signed-off-by: Danielle Costantino <danielle.costantino-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 4c5d7d9..28d9245 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -36,26 +36,31 @@
  #define MPC_I2C_CLOCK_LEGACY   0
  #define MPC_I2C_CLOCK_PRESERVE (~0U)

-#define MPC_I2C_FDR   0x04
-#define MPC_I2C_CR    0x08
-#define MPC_I2C_SR    0x0c
-#define MPC_I2C_DR    0x10
-#define MPC_I2C_DFSRR 0x14
+#define    MPC_I2C_ADR        0x00    /* I2C address register */
+#define    MPC_I2C_FDR        0x04    /* I2C frequency divider register */
+#define    MPC_I2C_CR        0x08    /* I2C control register */
+#define    MPC_I2C_SR        0x0C    /* I2C status register */
+#define    MPC_I2C_DR        0x10    /* I2C data register */
+#define    MPC_I2C_DFSRR    0x14    /* I2C digital filter sampling rate 
register */

-#define CCR_MEN  0x80
-#define CCR_MIEN 0x40
-#define CCR_MSTA 0x20
-#define CCR_MTX  0x10
-#define CCR_TXAK 0x08
-#define CCR_RSTA 0x04
+/* I2C Control Register (MPC_I2C_CR): */
+#define CCR_MEN  0x80    /* Module enable */
+#define CCR_MIEN 0x40    /* Module interrupt enable */
+#define CCR_MSTA 0x20    /* Master/slave mode START */
+#define CCR_MTX  0x10    /* Transmit/receive mode select */
+#define CCR_TXAK 0x08    /* Transfer acknowledge */
+#define CCR_RSTA 0x04    /* Repeated START */
+#define CCR_BCST 0x01    /* Broadcast */

-#define CSR_MCF  0x80
-#define CSR_MAAS 0x40
-#define CSR_MBB  0x20
-#define CSR_MAL  0x10
-#define CSR_SRW  0x04
-#define CSR_MIF  0x02
-#define CSR_RXAK 0x01
+/* I2C Status Register (MPC_I2C_SR): */
+#define CSR_MCF  0x80    /* Data transfer */
+#define CSR_MAAS 0x40    /* Addressed as a slave */
+#define CSR_MBB  0x20    /* Bus busy */
+#define CSR_MAL  0x10    /* Arbitration lost */
+#define CSR_BCSTM 0x08    /* Broadcast match */
+#define CSR_SRW  0x04    /* Slave read/write */
+#define CSR_MIF  0x02    /* Module interrupt */
+#define CSR_RXAK 0x01    /* Received acknowledge */

  struct mpc_i2c {
      struct device *dev;
@@ -158,12 +163,12 @@
          return result;

      if (!(cmd_err & CSR_MCF)) {
-        dev_dbg(i2c->dev, "unfinished\n");
+        dev_warn(i2c->dev, "unfinished\n");
          return -EIO;
      }

      if (cmd_err & CSR_MAL) {
-        dev_dbg(i2c->dev, "MAL\n");
+        dev_err(i2c->dev, "Arbitration lost\n");
          return -EAGAIN;
      }

@@ -554,7 +559,7 @@
                         i2c->base + MPC_I2C_SR);
                  mpc_i2c_fixup(i2c);
              }
-            return -EIO;
+            return -ETIMEDOUT;
          }
          schedule();
      }
@@ -590,7 +595,7 @@
                         i2c->base + MPC_I2C_SR);
                  mpc_i2c_fixup(i2c);
              }
-            return -EIO;
+            return -ETIMEDOUT;
          }
          cond_resched();
      }
