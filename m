From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] i2c: at91: ensure state is restored after suspending
Date: Mon, 30 Jan 2017 18:25:33 +0100
Message-ID: <20170130172533.31995-1-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

When going to suspend, the I2C registers may be lost because the power to
VDDcore is cut. Save them and restore them when resuming.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/i2c/busses/i2c-at91.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 0b86c6173e07..633bdd899952 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -140,6 +140,12 @@ struct at91_twi_dev {
 	unsigned transfer_status;
 	struct i2c_adapter adapter;
 	unsigned twi_cwgr_reg;
+	struct {
+		u32 mmr;
+		u32 imr;
+		u32 fmr;
+		u32 fimr;
+	} cache;
 	struct at91_twi_pdata *pdata;
 	bool use_dma;
 	bool use_alt_cmd;
@@ -1172,6 +1178,15 @@ static int at91_twi_runtime_resume(struct device *dev)
 
 static int at91_twi_suspend_noirq(struct device *dev)
 {
+	struct at91_twi_dev *twi_dev = dev_get_drvdata(dev);
+
+	twi_dev->cache.mmr = at91_twi_read(twi_dev, AT91_TWI_MMR);
+	twi_dev->cache.imr = at91_twi_read(twi_dev, AT91_TWI_IMR);
+	if (twi_dev->fifo_size) {
+		twi_dev->cache.fmr = at91_twi_read(twi_dev, AT91_TWI_FMR);
+		twi_dev->cache.fimr = at91_twi_read(twi_dev, AT91_TWI_FIMR);
+	}
+
 	if (!pm_runtime_status_suspended(dev))
 		at91_twi_runtime_suspend(dev);
 
@@ -1180,6 +1195,7 @@ static int at91_twi_suspend_noirq(struct device *dev)
 
 static int at91_twi_resume_noirq(struct device *dev)
 {
+	struct at91_twi_dev *twi_dev = dev_get_drvdata(dev);
 	int ret;
 
 	if (!pm_runtime_status_suspended(dev)) {
@@ -1191,6 +1207,14 @@ static int at91_twi_resume_noirq(struct device *dev)
 	pm_runtime_mark_last_busy(dev);
 	pm_request_autosuspend(dev);
 
+	at91_init_twi_bus(twi_dev);
+	at91_twi_write(twi_dev, AT91_TWI_MMR, twi_dev->cache.mmr);
+	at91_twi_write(twi_dev, AT91_TWI_IER, twi_dev->cache.imr);
+	if (twi_dev->fifo_size) {
+		at91_twi_write(twi_dev, AT91_TWI_FMR, twi_dev->cache.fmr);
+		at91_twi_write(twi_dev, AT91_TWI_FIER, twi_dev->cache.fimr);
+	}
+
 	return 0;
 }
 
-- 
2.11.0
