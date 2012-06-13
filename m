From: Sonic Zhang <sonic.adi@gmail.com>
Subject: [PATCH 3/8 v2] i2c: i2c-bfin-twi: Break dead waiting loop if i2c device misbehaves.
Date: Wed, 13 Jun 2012 16:22:42 +0800
Message-ID: <1339575767-22985-3-git-send-email-sonic.adi@gmail.com>
References: <1339575767-22985-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1339575767-22985-1-git-send-email-sonic.adi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>, Ben Dooks <ben-linux@fluff.org>
Cc: linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>
List-Id: linux-i2c@vger.kernel.org

From: Sonic Zhang <sonic.zhang@analog.com>

Some fault i2c device may hold the sda/scl line and cause i2c driver
wait in the BUS busy loop. The I2C framework already retry the
transfer loop before timeout. Return -EAGAIN instead of pull BUSBUSY
in the other loop.

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
---
 drivers/i2c/busses/i2c-bfin-twi.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index dbe8fa0..a5ab454 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -307,8 +307,8 @@ static int bfin_twi_do_master_xfer(struct i2c_adapter *adap,
 	if (!(read_CONTROL(iface) & TWI_ENA))
 		return -ENXIO;
 
-	while (read_MASTER_STAT(iface) & BUSBUSY)
-		yield();
+	if (read_MASTER_STAT(iface) & BUSBUSY)
+		return -EAGAIN;
 
 	iface->pmsg = msgs;
 	iface->msg_num = num;
@@ -407,8 +407,8 @@ int bfin_twi_do_smbus_xfer(struct i2c_adapter *adap, u16 addr,
 	if (!(read_CONTROL(iface) & TWI_ENA))
 		return -ENXIO;
 
-	while (read_MASTER_STAT(iface) & BUSBUSY)
-		yield();
+	if (read_MASTER_STAT(iface) & BUSBUSY)
+		return -EAGAIN;
 
 	iface->writeNum = 0;
 	iface->readNum = 0;
-- 
1.7.0.4
