From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Bus drivers don't have to support I2C_M_REV_DIR_ADDR
Date: Wed, 30 Sep 2009 22:22:44 +0200
Message-ID: <20090930222244.43b8d17d@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

I2C bus drivers don't have to support I2C_M_REV_DIR_ADDR. It is a
deviation from the I2C specification, which only makes sense to
implement when really needed.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
---
 drivers/i2c/busses/i2c-iop3xx.c   |    6 ------
 drivers/i2c/busses/i2c-mv64xxx.c  |    3 ---
 drivers/i2c/busses/i2c-powermac.c |    2 --
 3 files changed, 11 deletions(-)

--- linux-2.6.32-rc1.orig/drivers/i2c/busses/i2c-iop3xx.c	2009-06-10 05:05:27.000000000 +0200
+++ linux-2.6.32-rc1/drivers/i2c/busses/i2c-iop3xx.c	2009-09-30 21:34:01.000000000 +0200
@@ -56,12 +56,6 @@ iic_cook_addr(struct i2c_msg *msg)
 	if (msg->flags & I2C_M_RD)
 		addr |= 1;
 
-	/*
-	 * Read or Write?
-	 */
-	if (msg->flags & I2C_M_REV_DIR_ADDR)
-		addr ^= 1;
-
 	return addr;   
 }
 
--- linux-2.6.32-rc1.orig/drivers/i2c/busses/i2c-mv64xxx.c	2009-09-28 10:28:36.000000000 +0200
+++ linux-2.6.32-rc1/drivers/i2c/busses/i2c-mv64xxx.c	2009-09-30 21:33:45.000000000 +0200
@@ -338,9 +338,6 @@ mv64xxx_i2c_prepare_for_io(struct mv64xx
 	if (msg->flags & I2C_M_RD)
 		dir = 1;
 
-	if (msg->flags & I2C_M_REV_DIR_ADDR)
-		dir ^= 1;
-
 	if (msg->flags & I2C_M_TEN) {
 		drv_data->addr1 = 0xf0 | (((u32)msg->addr & 0x300) >> 7) | dir;
 		drv_data->addr2 = (u32)msg->addr & 0xff;
--- linux-2.6.32-rc1.orig/drivers/i2c/busses/i2c-powermac.c	2009-09-30 20:29:42.000000000 +0200
+++ linux-2.6.32-rc1/drivers/i2c/busses/i2c-powermac.c	2009-09-30 21:33:39.000000000 +0200
@@ -156,8 +156,6 @@ static int i2c_powermac_master_xfer(	str
 		return -EINVAL;
 	read = (msgs->flags & I2C_M_RD) != 0;
 	addrdir = (msgs->addr << 1) | read;
-	if (msgs->flags & I2C_M_REV_DIR_ADDR)
-		addrdir ^= 1;
 
 	rc = pmac_i2c_open(bus, 0);
 	if (rc)


-- 
Jean Delvare
