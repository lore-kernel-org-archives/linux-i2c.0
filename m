From: Danielle Costantino <danielle.costantino-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c: mpc: Report correct I2C error codes on Freescale MPC i2c
 bus driver
Date: Wed, 8 Oct 2014 12:06:15 -0700
Message-ID: <CAAVjN7fq-czDj5Ga_UC+fzqy3dcYY3bgU7Z5JUY829Va4rbeXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Report correct I2C error codes on Freescale MPC i2c bus driver


diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 0edf630..b56145c 100644
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
@@ -133,11 +133,11 @@
  if (time_after(jiffies, orig_jiffies + timeout)) {
  dev_dbg(i2c->dev, "timeout\n");
  writeccr(i2c, 0);
- result = -EIO;
+ result = -ETIMEDOUT;
  break;
  }
  }
- x = readb(i2c->base + MPC_I2C_SR);
+ cmd_err = readb(i2c->base + MPC_I2C_SR);
  writeb(0, i2c->base + MPC_I2C_SR);
  } else {
  /* Interrupt mode */
@@ -150,28 +150,28 @@
  result = -ETIMEDOUT;
  }

- x = i2c->interrupt;
+ cmd_err = i2c->interrupt;
  i2c->interrupt = 0;
  }

  if (result < 0)
  return result;

- if (!(x & CSR_MCF)) {
+ if (!(cmd_err & CSR_MCF)) {
  dev_dbg(i2c->dev, "unfinished\n");
  return -EIO;
  }

- if (x & CSR_MAL) {
+ if (cmd_err & CSR_MAL) {
  dev_dbg(i2c->dev, "MAL\n");
- return -EIO;
+ return -EAGAIN;
  }

- if (writing && (x & CSR_RXAK)) {
+ if (writing && (cmd_err & CSR_RXAK)) {
  dev_dbg(i2c->dev, "No RXAK\n");
  /* generate stop */
  writeccr(i2c, CCR_MEN);
- return -EIO;
+ return -ENXIO;
  }
  return 0;
 }
@@ -554,7 +554,7 @@
        i2c->base + MPC_I2C_SR);
  mpc_i2c_fixup(i2c);
  }
- return -EIO;
+ return -ETIMEDOUT;
  }
  schedule();
  }
@@ -590,7 +590,7 @@
        i2c->base + MPC_I2C_SR);
  mpc_i2c_fixup(i2c);
  }
- return -EIO;
+ return -ETIMEDOUT;
  }
  cond_resched();
  }


- Danielle Costantino
