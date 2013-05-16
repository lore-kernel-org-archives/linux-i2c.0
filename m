From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 6/9] I2C: mv64xxx: fix error handling for request_irq()
Date: Thu, 16 May 2013 21:36:11 +0100
Message-ID: <E1Ud4uJ-0004Jt-0s@rmk-PC.arm.linux.org.uk>
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

Propagate the error code from request_irq() rather than ignoring it
entirely.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/i2c/busses/i2c-mv64xxx.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 841792f..a82ab25 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -630,12 +630,12 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 
 	mv64xxx_i2c_hw_init(drv_data);
 
-	if (request_irq(drv_data->irq, mv64xxx_i2c_intr, 0,
-			MV64XXX_I2C_CTLR_NAME, drv_data)) {
+	rc = request_irq(drv_data->irq, mv64xxx_i2c_intr, 0,
+			 MV64XXX_I2C_CTLR_NAME, drv_data);
+	if (rc) {
 		dev_err(&drv_data->adapter.dev,
-			"mv64xxx: Can't register intr handler irq: %d\n",
-			drv_data->irq);
-		rc = -EINVAL;
+			"mv64xxx: Can't register intr handler irq%d: %d\n",
+			drv_data->irq, rc);
 		goto exit_clk;
 	} else if ((rc = i2c_add_numbered_adapter(&drv_data->adapter)) != 0) {
 		dev_err(&drv_data->adapter.dev,
-- 
1.7.4.4
