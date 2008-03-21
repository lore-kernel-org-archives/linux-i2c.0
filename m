From: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Subject: [PATCH 3/5] I2C: DaVinci: remove useless IVR read
Date: Thu, 20 Mar 2008 20:06:08 -0700
Message-ID: <1206068770-15458-4-git-send-email-troy.kisky@boundarydevices.com>
References: <1206068770-15458-1-git-send-email-troy.kisky@boundarydevices.com>
	<1206068770-15458-2-git-send-email-troy.kisky@boundarydevices.com>
	<1206068770-15458-3-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <1206068770-15458-3-git-send-email-troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Cc: Kevin Hilman <khilman-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Interrupts are enabled at the point where
the DAVINCI_I2C_IVR_REG is read, so unless
an interrupt happened just at that moment,
no interrupt would be pending. Even though
documentation implies you should do this,
I see no reason. If slave support is added,
this read would cause a hard to reproduce bug.

Signed-off-by: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Signed-off-by: Kevin Hilman <khilman-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-davinci.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 82d4b7f..da54fff 100755
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -240,7 +240,6 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
 	struct davinci_i2c_dev *dev = i2c_get_adapdata(adap);
 	struct davinci_i2c_platform_data *pdata = dev->dev->platform_data;
 	u32 flag;
-	u32 stat;
 	u16 w;
 	int r;
 
@@ -264,9 +263,6 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
 	init_completion(&dev->cmd_complete);
 	dev->cmd_err = 0;
 
-	/* Clear any pending interrupts by reading the IVR */
-	stat = davinci_i2c_read_reg(dev, DAVINCI_I2C_IVR_REG);
-
 	/* Take I2C out of reset, configure it as master and set the
 	 * start bit */
 	flag = DAVINCI_I2C_MDR_IRS | DAVINCI_I2C_MDR_MST | DAVINCI_I2C_MDR_STT;
-- 
1.5.4


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
