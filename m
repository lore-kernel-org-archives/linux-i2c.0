From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 7/9] I2C: mv64xxx: remove I2C_M_NOSTART code
Date: Thu, 16 May 2013 21:37:11 +0100
Message-ID: <E1Ud4vH-0004Jz-F6@rmk-PC.arm.linux.org.uk>
References: <20130516202921.GW18614@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130516202921.GW18614@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Jason Cooper <jason@lakedaemon.net>, Wolfram Sang <wsa@the-dreams.de>, "Mark A. Greer" <mgreer@animalcreek.com>, linux-i2c@vger.kernel.org, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-i2c@vger.kernel.org

As this driver does not advertise protocol mangling support
(I2C_FUNC_PROTOCOL_MANGLING is not set), having code to act on
I2C_M_NOSTART is illogical, and in any case isn't supportable on
anything but the first message - which makes no sense.  Remove
the I2C_M_NOSTART code.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/i2c/busses/i2c-mv64xxx.c |   26 +++++---------------------
 1 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index a82ab25..d160f8c 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -419,28 +419,12 @@ mv64xxx_i2c_execute_msg(struct mv64xxx_i2c_data *drv_data, struct i2c_msg *msg,
 	spin_lock_irqsave(&drv_data->lock, flags);
 	mv64xxx_i2c_prepare_for_io(drv_data, msg);
 
-	if (unlikely(msg->flags & I2C_M_NOSTART)) { /* Skip start/addr phases */
-		if (drv_data->msg->flags & I2C_M_RD) {
-			/* No action to do, wait for slave to send a byte */
-			drv_data->action = MV64XXX_I2C_ACTION_CONTINUE;
-			drv_data->state =
-				MV64XXX_I2C_STATE_WAITING_FOR_SLAVE_DATA;
-		} else {
-			drv_data->action = MV64XXX_I2C_ACTION_SEND_DATA;
-			drv_data->state =
-				MV64XXX_I2C_STATE_WAITING_FOR_SLAVE_ACK;
-			drv_data->bytes_left--;
-		}
+	if (is_first) {
+		drv_data->action = MV64XXX_I2C_ACTION_SEND_START;
+		drv_data->state = MV64XXX_I2C_STATE_WAITING_FOR_START_COND;
 	} else {
-		if (is_first) {
-			drv_data->action = MV64XXX_I2C_ACTION_SEND_START;
-			drv_data->state =
-				MV64XXX_I2C_STATE_WAITING_FOR_START_COND;
-		} else {
-			drv_data->action = MV64XXX_I2C_ACTION_SEND_ADDR_1;
-			drv_data->state =
-				MV64XXX_I2C_STATE_WAITING_FOR_ADDR_1_ACK;
-		}
+		drv_data->action = MV64XXX_I2C_ACTION_SEND_ADDR_1;
+		drv_data->state = MV64XXX_I2C_STATE_WAITING_FOR_ADDR_1_ACK;
 	}
 
 	drv_data->send_stop = is_last;
-- 
1.7.4.4
