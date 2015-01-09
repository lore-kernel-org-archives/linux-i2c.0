From: Wolfram Sang <wsa@the-dreams.de>
Subject: [RFC 03/11] i2c: at91: make use of the new infrastructure for quirks
Date: Fri,  9 Jan 2015 18:21:33 +0100
Message-ID: <1420824103-24169-4-git-send-email-wsa@the-dreams.de>
References: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-i2c@vger.kernel.org
Cc: linux-mips@linux-mips.org, Wolfram Sang <wsa@the-dreams.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-kernel@vger.kernel.org, Ludovic Desroches <ludovic.desroches@atmel.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-at91.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 636fd2efad88..8be7cf6e2747 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -487,30 +487,10 @@ static int at91_twi_xfer(struct i2c_adapter *adap, struct i2c_msg *msg, int num)
 	if (ret < 0)
 		goto out;
 
-	/*
-	 * The hardware can handle at most two messages concatenated by a
-	 * repeated start via it's internal address feature.
-	 */
-	if (num > 2) {
-		dev_err(dev->dev,
-			"cannot handle more than two concatenated messages.\n");
-		ret = 0;
-		goto out;
-	} else if (num == 2) {
+	if (num == 2) {
 		int internal_address = 0;
 		int i;
 
-		if (msg->flags & I2C_M_RD) {
-			dev_err(dev->dev, "first transfer must be write.\n");
-			ret = -EINVAL;
-			goto out;
-		}
-		if (msg->len > 3) {
-			dev_err(dev->dev, "first message size must be <= 3.\n");
-			ret = -EINVAL;
-			goto out;
-		}
-
 		/* 1st msg is put into the internal address, start with 2nd */
 		m_start = &msg[1];
 		for (i = 0; i < msg->len; ++i) {
@@ -540,6 +520,15 @@ out:
 	return ret;
 }
 
+/*
+ * The hardware can handle at most two messages concatenated by a
+ * repeated start via it's internal address feature.
+ */
+static struct i2c_adapter_quirks at91_twi_quirks = {
+	.flags = I2C_ADAPTER_QUIRK_COMB_WRITE_FIRST,
+	.max_comb_write_len = 3,
+};
+
 static u32 at91_twi_func(struct i2c_adapter *adapter)
 {
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL
@@ -777,6 +766,7 @@ static int at91_twi_probe(struct platform_device *pdev)
 	dev->adapter.owner = THIS_MODULE;
 	dev->adapter.class = I2C_CLASS_DEPRECATED;
 	dev->adapter.algo = &at91_twi_algorithm;
+	dev->adapter.quirks = &at91_twi_quirks;
 	dev->adapter.dev.parent = dev->dev;
 	dev->adapter.nr = pdev->id;
 	dev->adapter.timeout = AT91_I2C_TIMEOUT;
-- 
2.1.3
