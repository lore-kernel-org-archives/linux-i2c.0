From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH v1 0/3] i2c: imx: DMA related fixes
Date: Thu, 18 Oct 2018 13:26:12 +0200
Message-ID: <20181018112615.29362-1-o.rempel@pengutronix.de>
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
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, linux-i2c@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, linux-arm-kernel@lists.infradead.org, NXP Linux Team <linux-imx@nxp.com>
List-Id: linux-i2c@vger.kernel.org

Current i2c-imx module prints DMA warnings which in many cases are
false positive and just confuse testers:
1. DMA is not available on chips before i.MX50
2. DMA for i2c is muxed with some other peripheral, and can be used only
for one of devices at same time. So, obvious choice it to use it with
SDHC instead of i2c.

Oleksij Rempel (3):
  ARM: dts: imx6sll: fix typo for fsl,imx6sll-i2c node
  i2c: imx: probe dma only only on i.MX50 and later.
  i2c: imx: don't print error if DMA is not configured

 arch/arm/boot/dts/imx6sll.dtsi |  2 +-
 drivers/i2c/busses/i2c-imx.c   | 89 +++++++++++++++++++++++++++-------
 2 files changed, 73 insertions(+), 18 deletions(-)

-- 
2.19.0
