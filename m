From: Danielle Costantino <danielle.costantino-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c: mux: pca9541: add return value check on register writes
Date: Sat, 29 Nov 2014 14:45:47 -0800
Message-ID: <547A4C9B.5080705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

i2c: mux: pca9541: add return value check on register writes

Without this check there are conditions when the device was unable to
acquire mastership but returns that it succeeded.

also convert to use devm memory allocation functions

Signed-off-by: Danielle Costantino <danielle.costantino-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c 
b/drivers/i2c/muxes/i2c-mux-pca9541.c
index cb77277..0a029e9 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -52,9 +52,9 @@
  #define PCA9541_CTL_TESTON    (1 << 6)
  #define PCA9541_CTL_NTESTON    (1 << 7)

-#define PCA9541_ISTAT_INTIN    (1 << 0)
+#define PCA9541_ISTAT_INTIN        (1 << 0)
  #define PCA9541_ISTAT_BUSINIT    (1 << 1)
-#define PCA9541_ISTAT_BUSOK    (1 << 2)
+#define PCA9541_ISTAT_BUSOK        (1 << 2)
  #define PCA9541_ISTAT_BUSLOST    (1 << 3)
  #define PCA9541_ISTAT_MYTEST    (1 << 6)
  #define PCA9541_ISTAT_NMYTEST    (1 << 7)
@@ -65,7 +65,7 @@
  #define busoff(x)    (!((x) & BUSON) || ((x) & BUSON) == BUSON)

  /* arbitration timeouts, in jiffies */
-#define ARB_TIMEOUT    (HZ / 8)    /* 125 ms until forcing bus ownership */
+#define ARB_TIMEOUT        (HZ / 8)    /* 125 ms until forcing bus 
ownership */
  #define ARB2_TIMEOUT    (HZ / 4)    /* 250 ms until acquisition failure */

  /* arbitration retry delays, in us */
@@ -219,6 +219,7 @@
  {
      struct pca9541 *data = i2c_get_clientdata(client);
      int reg;
+    int ret = 0;

      reg = pca9541_reg_read(client, PCA9541_CONTROL);
      if (reg < 0)
@@ -237,7 +238,7 @@
               * Other master did not request ownership,
               * or arbitration timeout expired. Take the bus.
               */
-            pca9541_reg_write(client,
+            ret = pca9541_reg_write(client,
                        PCA9541_CONTROL,
                        pca9541_control[reg & 0x0f]
                        | PCA9541_CTL_NTESTON);
@@ -255,11 +256,11 @@
           * Reset NTESTON and BUSINIT, then return success.
           */
          if (reg & (PCA9541_CTL_NTESTON | PCA9541_CTL_BUSINIT))
-            pca9541_reg_write(client,
+            ret = pca9541_reg_write(client,
                        PCA9541_CONTROL,
                        reg & ~(PCA9541_CTL_NTESTON
                            | PCA9541_CTL_BUSINIT));
-        return 1;
+        return ret < 0 ? ret : 1;
      } else {
          /*
           * Other master owns the bus.
@@ -269,7 +270,7 @@
          data->select_timeout = SELECT_DELAY_LONG;
          if (time_is_before_eq_jiffies(data->arb_timeout)) {
              /* Time is up, take the bus and reset it. */
-            pca9541_reg_write(client,
+            ret = pca9541_reg_write(client,
                        PCA9541_CONTROL,
                        pca9541_control[reg & 0x0f]
                        | PCA9541_CTL_BUSINIT
@@ -277,12 +278,12 @@
          } else {
              /* Request bus ownership if needed */
              if (!(reg & PCA9541_CTL_NTESTON))
-                pca9541_reg_write(client,
+                ret = pca9541_reg_write(client,
                            PCA9541_CONTROL,
                            reg | PCA9541_CTL_NTESTON);
          }
      }
-    return 0;
+    return ret < 0 ? ret : 0;
  }

  static int pca9541_select_chan(struct i2c_adapter *adap, void *client, 
u32 chan)
@@ -331,7 +332,7 @@
      if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_BYTE_DATA))
          goto err;

-    data = kzalloc(sizeof(struct pca9541), GFP_KERNEL);
+    data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
      if (!data) {
          ret = -ENOMEM;
          goto err;
@@ -368,7 +369,7 @@
      return 0;

  exit_free:
-    kfree(data);
+    devm_kfree(&client->dev, data);
  err:
      return ret;
  }
@@ -379,7 +380,6 @@

      i2c_del_mux_adapter(data->mux_adap);

-    kfree(data);
      return 0;
  }
