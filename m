From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 4/9] I2C: mv64xxx: use devm_clk_get() to avoid missing
 clk_put()
Date: Thu, 16 May 2013 21:34:10 +0100
Message-ID: <E1Ud4sM-0004Ji-3h@rmk-PC.arm.linux.org.uk>
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

This driver forgets to use clk_put().  Rather than adding clk_put(),
lets instead use devm_clk_get() to obtain this clock so that it's
automatically handled on cleanup.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/i2c/busses/i2c-mv64xxx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 19cc9bf..0b4da77 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -599,7 +599,7 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 
 #if defined(CONFIG_HAVE_CLK)
 	/* Not all platforms have a clk */
-	drv_data->clk = clk_get(&pd->dev, NULL);
+	drv_data->clk = devm_clk_get(&pd->dev, NULL);
 	if (!IS_ERR(drv_data->clk)) {
 		clk_prepare(drv_data->clk);
 		clk_enable(drv_data->clk);
-- 
1.7.4.4
