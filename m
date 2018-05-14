From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 04/21] i2c: aspeed: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 16:53:13 +0200
Message-ID: <20180514145330.4857-5-peda@axentia.se>
References: <20180514145330.4857-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180514145330.4857-1-peda@axentia.se>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-aspeed@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, openbmc@lists.ozlabs.org, Brendan Higgins <brendanhiggins@google.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, Peter Rosin <peda@axentia.se>, linux-arm-kernel@lists.infradead.org, Joel Stanley <joel@jms.id.au>
List-Id: linux-i2c@vger.kernel.org

Because it looks neater.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-aspeed.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 7d4aeb4465b3..60e4d0e939a3 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -335,13 +335,12 @@ static void aspeed_i2c_do_start(struct aspeed_i2c_bus *bus)
 {
 	u32 command = ASPEED_I2CD_M_START_CMD | ASPEED_I2CD_M_TX_CMD;
 	struct i2c_msg *msg = &bus->msgs[bus->msgs_index];
-	u8 slave_addr = msg->addr << 1;
+	u8 slave_addr = i2c_8bit_addr_from_msg(msg);
 
 	bus->master_state = ASPEED_I2C_MASTER_START;
 	bus->buf_index = 0;
 
 	if (msg->flags & I2C_M_RD) {
-		slave_addr |= 1;
 		command |= ASPEED_I2CD_M_RX_CMD;
 		/* Need to let the hardware know to NACK after RX. */
 		if (msg->len == 1 && !(msg->flags & I2C_M_RECV_LEN))
-- 
2.11.0
