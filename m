From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v1 1/1] i2c: iproc: generate stop event for slave writes
Date: Sun, 22 Mar 2020 23:50:19 +0530
Message-ID: <20200322182019.32493-1-rayagonda.kokatanur@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Wolfram Sang <wsa@the-dreams.de>, Lori Hikichi <lori.hikichi@broadcom.com>, Shreesha Rajashekar <shreesha.rajashekar@broadcom.com>, Nishka Dasgupta <nishkadg.linux@gmail.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
List-Id: linux-i2c@vger.kernel.org

When slave status is I2C_SLAVE_RX_END, generate I2C_SLAVE_STOP
event to i2c_client.

Fixes: c245d94ed106 ("i2c: iproc: Add multi byte read-write support for slave mode")
Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
 drivers/i2c/busses/i2c-bcm-iproc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index 30efb7913b2e..b58224b7ba79 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -360,6 +360,9 @@ static bool bcm_iproc_i2c_slave_isr(struct bcm_iproc_i2c_dev *iproc_i2c,
 			value = (u8)((val >> S_RX_DATA_SHIFT) & S_RX_DATA_MASK);
 			i2c_slave_event(iproc_i2c->slave,
 					I2C_SLAVE_WRITE_RECEIVED, &value);
+			if (rx_status == I2C_SLAVE_RX_END)
+				i2c_slave_event(iproc_i2c->slave,
+						I2C_SLAVE_STOP, &value);
 		}
 	} else if (status & BIT(IS_S_TX_UNDERRUN_SHIFT)) {
 		/* Master read other than start */
-- 
2.17.1
