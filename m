From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 1/2] i2c: mv64xxx: Remove useless test before
 clk_disable_unprepare
Date: Wed, 10 Jan 2018 17:51:46 +0100
Message-ID: <20180110165147.26605-2-gregory.clement@free-electrons.com>
References: <20180110165147.26605-1-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180110165147.26605-1-gregory.clement@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Yehuda Yitschak <yehuday@marvell.com>, Jason Cooper <jason@lakedaemon.net>, Antoine Tenart <antoine.tenart@free-electrons.com>, Omri Itach <omrii@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Igal Liberman <igall@marvell.com>, =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@free-electrons.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Marcin Wojtas <mw@semihalf.com>, Hanna Hawa <hannah@marvell.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-i2c@vger.kernel.org

The 2 functions called from clk_disable_unprepare() already check that
the clock pointer is valid: no need to test it before calling it.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index a832c45276a4..f69066266faa 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -950,9 +950,7 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 exit_reset:
 	reset_control_assert(drv_data->rstc);
 exit_clk:
-	/* Not all platforms have a clk */
-	if (!IS_ERR(drv_data->clk))
-		clk_disable_unprepare(drv_data->clk);
+	clk_disable_unprepare(drv_data->clk);
 
 	return rc;
 }
@@ -965,9 +963,7 @@ mv64xxx_i2c_remove(struct platform_device *dev)
 	i2c_del_adapter(&drv_data->adapter);
 	free_irq(drv_data->irq, drv_data);
 	reset_control_assert(drv_data->rstc);
-	/* Not all platforms have a clk */
-	if (!IS_ERR(drv_data->clk))
-		clk_disable_unprepare(drv_data->clk);
+	clk_disable_unprepare(drv_data->clk);
 
 	return 0;
 }
-- 
2.15.1
