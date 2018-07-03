From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] i2c: designware-pcidrv: Mark expected switch fall-through
Date: Tue, 3 Jul 2018 14:10:55 -0500
Message-ID: <20180703191055.GA30768@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-i2c@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/i2c/busses/i2c-designware-pcidrv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index 86e1bd0..b4997be 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -105,6 +105,7 @@ static int mfld_setup(struct pci_dev *pdev, struct dw_pci_controller *c)
 	case 0x0817:
 		c->bus_cfg &= ~DW_IC_CON_SPEED_MASK;
 		c->bus_cfg |= DW_IC_CON_SPEED_STD;
+		/* fall through */
 	case 0x0818:
 	case 0x0819:
 		c->bus_num = pdev->device - 0x817 + 3;
-- 
2.7.4
