From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH v1] MAINTAINERS: i2c-imx: take over maintainership
Date: Mon, 12 Aug 2019 07:08:17 +0200
Message-ID: <20190812050817.23279-1-o.rempel@pengutronix.de>
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
To: Wolfram Sang <wsa@the-dreams.de>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Russell King - ARM Linux admin <linux@armlinux.org.uk>, Oleksij Rempel <o.rempel@pengutronix.de>, linux-i2c@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Chris Healy <cphealy@gmail.com>, linux-arm-kernel@lists.infradead.org, NXP Linux Team <linux-imx@nxp.com>
List-Id: linux-i2c@vger.kernel.org

I would like to maintain the i2c-imx driver. Since I work with
different i.MX variants and have access to the hardware, I can spend
some time on the reviewing of this driver.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e81e60bd7c26..ddc1cf5cb0b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6441,6 +6441,14 @@ S:	Maintained
 F:	drivers/perf/fsl_imx8_ddr_perf.c
 F:	Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt
 
+FREESCALE IMX I2C DRIVER
+M:	Oleksij Rempel <o.rempel@pengutronix.de>
+R:	Pengutronix Kernel Team <kernel@pengutronix.de>
+L:	linux-i2c@vger.kernel.org
+S:	Maintained
+F:	drivers/i2c/busses/i2c-imx.c
+F:	Documentation/devicetree/bindings/i2c/i2c-imx.txt
+
 FREESCALE IMX LPI2C DRIVER
 M:	Dong Aisheng <aisheng.dong@nxp.com>
 L:	linux-i2c@vger.kernel.org
-- 
2.20.1
