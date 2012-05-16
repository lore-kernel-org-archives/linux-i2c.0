From: <sonic.zhang@analog.com>
Subject: [PATCH 1/8] i2c: i2c-bfin-twi: Illegal i2c bus lock upon certain transfer scenarios.
Date: Wed, 16 May 2012 15:20:19 +0800
Message-ID: <1337152826-9850-1-git-send-email-sonic.zhang@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, uclinux-dist-devel@blackfin.uclinux.org, Michael Hennerich <michael.hennerich@analog.com>, Sonic Zhang <sonic.zhang@analog.com>
List-Id: linux-i2c@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

For transfer counts > 255 bytes i2c-bfin-twi sets the data
transfer counter DCNT to 0xFF indicating unlimited transfers.
It then uses a flag iface->manual_stop to manually issue the STOP
condition, once the required amount of bytes are received.

We found that on I2C receive operation issuing the STOP condition
together with a FULL RCV FIFO (2bytes) will cause SDA and SCL be
constantly driven low.

Temporary workaround until further investigation:
Discard the RCV FIFO before issuing the STOP condition.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>

git-svn-id: svn://localhost/svn/linux-kernel/trunk@9011 526b6c2d-f592-4532-a319-5dd88ccb003d
---
 drivers/i2c/busses/i2c-bfin-twi.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index cdb59e5..e6dd3c9 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -131,6 +131,10 @@ static void bfin_twi_handle_interrupt(struct bfin_twi_iface *iface,
 			iface->transPtr++;
 			iface->readNum--;
 		} else if (iface->manual_stop) {
+			/* Avoid possible bus stall -
+			 * Flush FIFO before issuing the STOP condition
+			 */
+			read_RCV_DATA16(iface);
 			write_MASTER_CTL(iface,
 				read_MASTER_CTL(iface) | STOP);
 		} else if (iface->cur_mode == TWI_I2C_MODE_REPEAT &&
-- 
1.7.0.4
