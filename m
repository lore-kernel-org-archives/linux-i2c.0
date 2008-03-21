From: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Subject: [PATCH 5/5] I2C: DaVinci: initialize cmd_complete sooner
Date: Thu, 20 Mar 2008 20:06:10 -0700
Message-ID: <1206068770-15458-6-git-send-email-troy.kisky@boundarydevices.com>
References: <1206068770-15458-1-git-send-email-troy.kisky@boundarydevices.com>
	<1206068770-15458-2-git-send-email-troy.kisky@boundarydevices.com>
	<1206068770-15458-3-git-send-email-troy.kisky@boundarydevices.com>
	<1206068770-15458-4-git-send-email-troy.kisky@boundarydevices.com>
	<1206068770-15458-5-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <1206068770-15458-5-git-send-email-troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
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

If an interrupt happens before an I2c master read/write,
complete is called on uninitialized structure.

Signed-off-by: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Signed-off-by: Kevin Hilman <khilman-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-davinci.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 2ac56a2..f0b095f 100755
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -262,7 +262,7 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
 
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_CNT_REG, dev->buf_len);
 
-	init_completion(&dev->cmd_complete);
+	INIT_COMPLETION(dev->cmd_complete);
 	dev->cmd_err = 0;
 
 	/* Take I2C out of reset, configure it as master and set the
@@ -518,6 +518,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 		goto err_release_region;
 	}
 
+	init_completion(&dev->cmd_complete);
 	dev->dev = get_device(&pdev->dev);
 	dev->irq = irq->start;
 	platform_set_drvdata(pdev, dev);
-- 
1.5.4


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
