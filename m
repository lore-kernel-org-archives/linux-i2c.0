From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 4/4] i2c-bfin-twi: add a timeout to busbusy polling
Date: Wed, 25 May 2011 16:26:38 -0400
Message-ID: <1306355198-18530-4-git-send-email-vapier@gentoo.org>
References: <1306355198-18530-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1306355198-18530-1-git-send-email-vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

Some faulty i2c slave devices might hold the sda/scl line and cause the
i2c bus driver to wait indefinitely in the busbusy loop.  Add a timeout
to the loop so the bus master can recover without locking up everything.

Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-bfin-twi.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index 64d4b64..f2628a7 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -288,6 +288,8 @@ static irqreturn_t bfin_twi_interrupt_entry(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+#define BFIN_TWI_BUSY_TIMEOUT	1000
+
 /*
  * One i2c master transfer
  */
@@ -297,12 +299,16 @@ static int bfin_twi_do_master_xfer(struct i2c_adapter *adap,
 	struct bfin_twi_iface *iface = adap->algo_data;
 	struct i2c_msg *pmsg;
 	int rc = 0;
+	unsigned int busy_timeout = BFIN_TWI_BUSY_TIMEOUT;
 
 	if (!(read_CONTROL(iface) & TWI_ENA))
 		return -ENXIO;
 
-	while (read_MASTER_STAT(iface) & BUSBUSY)
+	while (read_MASTER_STAT(iface) & BUSBUSY) {
+		if (--busy_timeout == 0)
+			return -EBUSY;
 		yield();
+	}
 
 	iface->pmsg = msgs;
 	iface->msg_num = num;
@@ -397,12 +403,16 @@ int bfin_twi_do_smbus_xfer(struct i2c_adapter *adap, u16 addr,
 {
 	struct bfin_twi_iface *iface = adap->algo_data;
 	int rc = 0;
+	unsigned int busy_timeout = BFIN_TWI_BUSY_TIMEOUT;
 
 	if (!(read_CONTROL(iface) & TWI_ENA))
 		return -ENXIO;
 
-	while (read_MASTER_STAT(iface) & BUSBUSY)
+	while (read_MASTER_STAT(iface) & BUSBUSY) {
+		if (--busy_timeout == 0)
+			return -EBUSY;
 		yield();
+	}
 
 	iface->writeNum = 0;
 	iface->readNum = 0;
-- 
1.7.5.rc3
