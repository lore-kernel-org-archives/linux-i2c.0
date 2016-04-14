From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH 2/4] i2c: designware-platdrv: fix unbalanced clk enable and
 prepare
Date: Thu, 14 Apr 2016 20:53:32 +0800
Message-ID: <1460638414-5987-3-git-send-email-jszhang@marvell.com>
References: <1460638414-5987-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1460638414-5987-1-git-send-email-jszhang@marvell.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de
Cc: Jisheng Zhang <jszhang@marvell.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

If i2c_dw_probe() fail, we should call i2c_dw_plat_prepare_clk() to
disable and unprepare the clk, otherwise the clk enable and prepare
is left unbalanced.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 00f9e99..1488cea 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -268,6 +268,8 @@ rpm_disable:
 		pm_runtime_put_noidle(&pdev->dev);
 	}
 
+	i2c_dw_plat_prepare_clk(dev, false);
+
 	return r;
 }
 
-- 
2.8.0.rc3
