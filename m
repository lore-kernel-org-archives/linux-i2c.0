From: Janusz Uzycki <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
Subject: [PATCH] i2c-mxs: detect No Slave Ack on SELECT in PIO mode
Date: Wed, 10 Sep 2014 17:18:06 +0200
Message-ID: <1410362286-1785-1-git-send-email-j.uzycki@elproma.com.pl>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: marex-ynQEQJNshbs@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Janusz Uzycki <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Reported problem:
i2cdetect scanned i2c bus very slow if address was not occupied by any device.

Solution:
The patch adds to mxs_i2c_pio_wait_xfer_end() function
NO_SLAVE_ACK_IRQ bit polling during wait loop (until timeout).
If the bit is set the function immediately returns ENXIO error
in order to break the loop and not reset I2C block (it is in idle state then).
The function is called by mxs_i2c_pio_setup_xfer() to wait for complete xfer
after sent SELECT, READ or WRITE command.
If SELECT command is sent and selected slave address is unused by any device
on the bus I2C block sets NO_SLAVE_ACK_IRQ flag and doesn't deassert CTRL0_RUN.
Therefore we need to break the timeout loop when the flag is set,
otherwise the loop continues until long timeout (1000ms).
The change does not affect READ command because slave does not ack
any byte then (only the master does ack / or not for the last read byte).
According to i.MX28 reference manual (quoted below) it is not clear
if the patch affects WRITE command. However when no acked bytes
on WRITE command followed after address byte (SELECT command)
STAT_GOT_A_NAK flag is set rather than NO_SLAVE_ACK_IRQ (no tested).
Therefore clock stretching shouldn't be affected too.
It has confirmation in FSL BSP 2.6.35 i2c implementation which
completes xfer after NO_SLAVE_ACK_IRQ interrupt and scheduled work.
Registers on NO_SLAVE_ACK_IRQ in PIO mode:
* STAT: 0xd0000e00
	MASTER_PRESENT
	SLAVE_PRESENT
	GOT_A_NAK !
	BUS_BUSY
	CLK_GEN_BUSY
	DATA_ENGINE_BUSY
* CTRL0: 0x20230000
	RUN !
	RETAIN_CLOCK
	MASTER_MODE
	DIRECTION
* CTRL1: 0x688600a0
	RD_QUEUE_IRQ
	WR_QUEUE_IRQ
	ACK_MODE
	SLAVE_ADDRESS_BYTE=0b10000110
	BUS_FREE_IRQ
	NO_SLAVE_ACK_IRQ !

NO_SLAVE_ACK_IRQ (CTRL1):
When a start condition is transmitted in master mode, the next byte
contains an address for a targeted slave. If the targeted slave does not
acknowledge the address byte, then this interrupt is set, no further I2C
protocol is processed, and the I2C bus returns to the idle state.
This bit is set to indicate that an interrupt is requested
by the I2C controller because the slave addressed
by a master transfer did not respond with an acknowledge.

Signed-off-by: Janusz Uzycki <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
---
 drivers/i2c/busses/i2c-mxs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 87ee72d..35ae448 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -307,6 +307,10 @@ static int mxs_i2c_pio_wait_xfer_end(struct mxs_i2c_dev *i2c)
 	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
 
 	while (readl(i2c->regs + MXS_I2C_CTRL0) & MXS_I2C_CTRL0_RUN) {
+		if (readl(i2c->regs + MXS_I2C_CTRL1) &
+				MXS_I2C_CTRL1_NO_SLAVE_ACK_IRQ)
+			return -ENXIO;
 		if (time_after(jiffies, timeout))
 			return -ETIMEDOUT;
 		cond_resched();
-- 
1.7.11.3
