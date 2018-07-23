From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 06/12] i2c: qup: use core to detect 'no zero length' quirk
Date: Mon, 23 Jul 2018 22:26:10 +0200
Message-ID: <20180723202617.15230-7-wsa+renesas@sang-engineering.com>
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

And don't reimplement in the driver.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Only build tested.

 drivers/i2c/busses/i2c-qup.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index c86c3ae1318f..e09cd0775ae9 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -1088,11 +1088,6 @@ static int qup_i2c_xfer(struct i2c_adapter *adap,
 	writel(I2C_MINI_CORE | I2C_N_VAL, qup->base + QUP_CONFIG);
 
 	for (idx = 0; idx < num; idx++) {
-		if (msgs[idx].len == 0) {
-			ret = -EINVAL;
-			goto out;
-		}
-
 		if (qup_i2c_poll_state_i2c_master(qup)) {
 			ret = -EIO;
 			goto out;
@@ -1520,9 +1515,6 @@ qup_i2c_determine_mode_v2(struct qup_i2c_dev *qup,
 
 	/* All i2c_msgs should be transferred using either dma or cpu */
 	for (idx = 0; idx < num; idx++) {
-		if (msgs[idx].len == 0)
-			return -EINVAL;
-
 		if (msgs[idx].flags & I2C_M_RD)
 			max_rx_len = max_t(unsigned int, max_rx_len,
 					   msgs[idx].len);
@@ -1636,9 +1628,14 @@ static const struct i2c_algorithm qup_i2c_algo_v2 = {
  * which limits the possible read to 256 (QUP_READ_LIMIT) bytes.
  */
 static const struct i2c_adapter_quirks qup_i2c_quirks = {
+	.flags = I2C_AQ_NO_ZERO_LEN,
 	.max_read_len = QUP_READ_LIMIT,
 };
 
+static const struct i2c_adapter_quirks qup_i2c_quirks_v2 = {
+	.flags = I2C_AQ_NO_ZERO_LEN,
+};
+
 static void qup_i2c_enable_clocks(struct qup_i2c_dev *qup)
 {
 	clk_prepare_enable(qup->clk);
@@ -1701,6 +1698,7 @@ static int qup_i2c_probe(struct platform_device *pdev)
 		is_qup_v1 = true;
 	} else {
 		qup->adap.algo = &qup_i2c_algo_v2;
+		qup->adap.quirks = &qup_i2c_quirks_v2;
 		is_qup_v1 = false;
 		if (acpi_match_device(qup_i2c_acpi_match, qup->dev))
 			goto nodma;
-- 
2.11.0
