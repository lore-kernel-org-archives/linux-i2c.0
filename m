From: Nicola Corna <nicola@corna.info>
Subject: [PATCH v2 3/5] i2c: add I2C_AQ_NO_CLK_STRETCH to i2c-bcm2835.c
Date: Thu, 29 Oct 2015 12:34:25 +0100
Message-ID: <1446118467-26453-3-git-send-email-nicola@corna.info>
References: <1445976718-7449-1-git-send-email-nicola@corna.info>
 <1446118467-26453-1-git-send-email-nicola@corna.info>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1446118467-26453-1-git-send-email-nicola@corna.info>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Jonathan Cameron <jic23@kernel.org>
Cc: Nicola Corna <nicola@corna.info>, Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-i2c@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

As reported here
http://www.advamation.com/knowhow/raspberrypi/rpi-i2c-bug.html
and confirmed here
https://www.raspberrypi.org/forums/viewtopic.php?p=146272
the BCM2835 has a hardware bug in its i2c module which prevents a correct
clock stretching. This patch adds the I2C_AQ_NO_CLK_STRETCH quirk flag
to i2c-bcm2835.

Signed-off-by: Nicola Corna <nicola@corna.info>
---
 drivers/i2c/busses/i2c-bcm2835.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index 3032b89..38d7102 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -222,6 +222,10 @@ static const struct i2c_algorithm bcm2835_i2c_algo = {
 	.functionality	= bcm2835_i2c_func,
 };
 
+static const struct i2c_adapter_quirks bcm2835_i2c_quirks = {
+	.flags = I2C_AQ_NO_CLK_STRETCH,
+};
+
 static int bcm2835_i2c_probe(struct platform_device *pdev)
 {
 	struct bcm2835_i2c_dev *i2c_dev;
@@ -293,6 +297,7 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
 	adap->algo = &bcm2835_i2c_algo;
 	adap->dev.parent = &pdev->dev;
 	adap->dev.of_node = pdev->dev.of_node;
+	adap->quirks = &bcm2835_i2c_quirks;
 
 	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C, 0);
 
-- 
2.6.1
