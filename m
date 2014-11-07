From: Andrew Jackson <Andrew.Jackson@arm.com>
Subject: [PATCH] i2c: designware: prevent early stop on TX FIFO empty
Date: Fri, 07 Nov 2014 12:10:44 +0000
Message-ID: <545CB6C4.8010201@arm.com>
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
To: Wolfram Sang <wsa@the-dreams.de>, Andrew Morton <akpm@linux-foundation.org>, Baruch Siach <baruch@tkos.co.il>, "Du, Wenkai" <wenkai.du@intel.com>, Shinya Kuribayashi <skuribay@pobox.com>, Romain Baeriswyl <Romain.Baeriswyl@abilis.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Liviu Dudau <Liviu.Dudau@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

If the Designware core is configured with IC_EMPTYFIFO_HOLD_MASTER_EN
set to zero, allowing the TX FIFO to become empty causes a STOP
condition to be generated on the I2C bus. If the transmit FIFO
threshold is set too high, an erroneous STOP condition can be
generated on long transfers - particularly where the interrupt
latency is extended.

Signed-off-by: Andrew Jackson <Andrew.Jackson@arm.com>
Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
---
 drivers/i2c/busses/i2c-designware-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 3c20e4b..e070edd 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -363,7 +363,7 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 	}
 
 	/* Configure Tx/Rx FIFO threshold levels */
-	dw_writel(dev, dev->tx_fifo_depth - 1, DW_IC_TX_TL);
+	dw_writel(dev, dev->tx_fifo_depth / 2, DW_IC_TX_TL);
 	dw_writel(dev, 0, DW_IC_RX_TL);
 
 	/* configure the i2c master */
-- 
1.7.1
