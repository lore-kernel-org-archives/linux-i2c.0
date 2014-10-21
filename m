From: Danielle Costantino <danielle.costantino-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c: mpc: Report correct I2C error codes on Freescale MPC i2c
 bus driver
Date: Tue, 21 Oct 2014 00:05:44 -0700
Message-ID: <CAAVjN7cpGzokOntyyGVBksdvAw7rGt8zvggpCeMqr+g1yHEyzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Danielle Costantino <danielle.costantino-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

This patch enforces correct I2C error returned codes from Freescale's
MPC i2c bus driver, allowing for proper user-space/kernel error
handling.

Signed-off-by: Danielle Costantino <danielle.costantino-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 0edf630..66bef28 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -124,7 +124,7 @@
 static int i2c_wait(struct mpc_i2c *i2c, unsigned timeout, int writing)
 {
  unsigned long orig_jiffies = jiffies;
- u32 x;
+ u32 cmd_err;
  int result = 0;

  if (!i2c->irq) {
@@ -137,7 +137,7 @@
  break;
  }
  }
- x = readb(i2c->base + MPC_I2C_SR);
+ cmd_err = readb(i2c->base + MPC_I2C_SR);
  writeb(0, i2c->base + MPC_I2C_SR);
  } else {
  /* Interrupt mode */
@@ -150,30 +150,30 @@
  result = -ETIMEDOUT;
  }

- x = i2c->interrupt;
+ cmd_err = i2c->interrupt;
  i2c->interrupt = 0;
  }

- if (result < 0)
- return result;
+    if (result < 0)
+        return result;

- if (!(x & CSR_MCF)) {
- dev_dbg(i2c->dev, "unfinished\n");
- return -EIO;
- }
+    if (!(cmd_err & CSR_MCF)) {
+        dev_dbg(i2c->dev, "unfinished\n");
+        return -EIO;
+    }

- if (x & CSR_MAL) {
- dev_dbg(i2c->dev, "MAL\n");
- return -EIO;
- }
+    if (cmd_err & CSR_MAL) {
+        dev_dbg(i2c->dev, "MAL\n");
+        return -EAGAIN;
+    }

- if (writing && (x & CSR_RXAK)) {
- dev_dbg(i2c->dev, "No RXAK\n");
- /* generate stop */
- writeccr(i2c, CCR_MEN);
- return -EIO;
- }
- return 0;
+    if (writing && (cmd_err & CSR_RXAK)) {
+        dev_dbg(i2c->dev, "No RXAK\n");
+        /* generate stop */
+        writeccr(i2c, CCR_MEN);
+        return -ENXIO;
+    }
+    return 0;
 }

 #if defined(CONFIG_PPC_MPC52xx) || defined(CONFIG_PPC_MPC512x)

-- 
- Danielle Costantino
