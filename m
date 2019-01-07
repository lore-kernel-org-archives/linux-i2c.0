From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH v4 0/2] i2c: imx: rework imx error handling.
Date: Mon,  7 Jan 2019 09:47:36 +0100
Message-ID: <20190107084738.4130-1-o.rempel@pengutronix.de>
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

changes:
20190107 v4:
 - split one patch to separate patches
 - revert back devm_free(), we need it for -ENODEV case.
 - reword comments.

20181130 v3:
 - reword commit message 
20181112 v2:
 - drop "[PATCH v1 2/3] i2c: imx: probe dma only only on i.MX50 and
   later" and rebase without this patch.
 - Set proper initial author

Oleksij Rempel (2):
  i2c: imx: notify about real errors on dma i2c_imx_dma_request
  i2c: imx: forward error values out of i2c_imx_dma_request()

 drivers/i2c/busses/i2c-imx.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

-- 
2.19.1
