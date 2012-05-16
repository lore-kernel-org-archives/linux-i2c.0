From: <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/8] i2c: i2c-bfin-twi: Break dead waiting loop if i2c device misbehaves.
Date: Wed, 16 May 2012 15:20:21 +0800
Message-ID: <1337152826-9850-3-git-send-email-sonic.zhang@analog.com>
References: <1337152826-9850-1-git-send-email-sonic.zhang@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1337152826-9850-1-git-send-email-sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

Some fault i2c device may hold the sda/scl line and cause i2c driver
wait in the BUS busy loop. This patch breaks this potential dead
loop.

Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

git-svn-id: svn://localhost/svn/linux-kernel/trunk@9291 526b6c2d-f592-4532-a319-5dd88ccb003d
---
 drivers/i2c/busses/i2c-bfin-twi.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index 376e331..4abaf59 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -294,6 +294,8 @@ static irqreturn_t bfin_twi_interrupt_entry(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+#define BFIN_TWI_BUSY_TIMEOUT	1000
+
 /*
  * One i2c master transfer
  */
@@ -303,12 +305,16 @@ static int bfin_twi_do_master_xfer(struct i2c_adapter *adap,
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
@@ -403,12 +409,16 @@ int bfin_twi_do_smbus_xfer(struct i2c_adapter *adap, u16 addr,
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
1.7.0.4
