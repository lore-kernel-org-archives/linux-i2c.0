From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 08/16] i2c: i2c-nomadik: Drop class based scanning to improve
 bootup time
Date: Thu, 10 Jul 2014 13:46:28 +0200
Message-ID: <1404992799-3705-9-git-send-email-wsa@the-dreams.de>
References: <1404992799-3705-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1404992799-3705-1-git-send-email-wsa@the-dreams.de>
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
Cc: Linus Walleij <linus.walleij@linaro.org>, Alessandro Rubini <rubini@unipv.it>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

This driver has been flagged to drop class based instantiation. The removal
improves boot-up time and is unneeded for embedded controllers. Users have been
warned to switch for some time now, so we can actually do the removal. Keep the
DEPRECATED flag, so the core can inform users that the behaviour finally
changed now. After another transition period, this flag can go, too.
While we are here, remove the indentation for the array setup because
such things always break after some time.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-nomadik.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 0e55d85fd4ed..9ad038d223c4 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -1032,10 +1032,10 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 	adap = &dev->adap;
 	adap->dev.of_node = np;
 	adap->dev.parent = &adev->dev;
-	adap->owner	= THIS_MODULE;
-	adap->class	= I2C_CLASS_HWMON | I2C_CLASS_SPD | I2C_CLASS_DEPRECATED;
-	adap->algo	= &nmk_i2c_algo;
-	adap->timeout	= msecs_to_jiffies(dev->timeout);
+	adap->owner = THIS_MODULE;
+	adap->class = I2C_CLASS_DEPRECATED;
+	adap->algo = &nmk_i2c_algo;
+	adap->timeout = msecs_to_jiffies(dev->timeout);
 	snprintf(adap->name, sizeof(adap->name),
 		 "Nomadik I2C at %pR", &adev->res);
 
-- 
2.0.0
