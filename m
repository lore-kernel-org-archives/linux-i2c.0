From: vishwa <vishwanath.k-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2] davinci: I2C: Adding bus frequency as module parameter
Date: Wed, 11 Aug 2010 15:38:33 +0530
Message-ID: <1281521313-4556-1-git-send-email-vishwanath.k@ti.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, vishwa <vishwanath.k-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

With current implementation, when I2C is used as a module,
for slave devices which operate at different frequencies,
the bus frequency needs to be modified in the board
configuration file and kernel needs to be re-built.

This patch addresses this issue by adding bus frequency as
module parameter.

Signed-off-by: vishwa <vishwanath.k-l0cyMroinI0@public.gmane.org>
---
Since v1:
a. added MODULE_PARAM_DESC.
b. Moved module parameter definitions to the beginning of the file.
c. 'pdata->bus_freq' is being set in i2c_davinci_init() function.

 drivers/i2c/busses/i2c-davinci.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 2222c87..8fbfaa2 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -98,6 +98,10 @@
 #define DAVINCI_I2C_IMR_NACK	BIT(1)
 #define DAVINCI_I2C_IMR_AL	BIT(0)
 
+static int i2c_davinci_busfreq;
+module_param(i2c_davinci_busfreq, int, 0);
+MODULE_PARM_DESC(i2c_davinci_busfreq, "bus frequency");
+
 struct davinci_i2c_dev {
 	struct device           *dev;
 	void __iomem		*base;
@@ -243,6 +247,9 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
 	/* put I2C into reset */
 	davinci_i2c_reset_ctrl(dev, 0);
 
+	if (i2c_davinci_busfreq != 0)
+		pdata->bus_freq = i2c_davinci_busfreq;
+
 	/* compute clock dividers */
 	i2c_davinci_calc_clk_dividers(dev);
 
-- 
1.5.6
