From: Zhiqiang Hou <B48286@freescale.com>
Subject: [PATCH 2/6] watchdog: Add support for Freescale Layerscape platforms
Date: Mon, 21 Sep 2015 20:22:34 +0800
Message-ID: <1442838158-2964-3-git-send-email-B48286@freescale.com>
References: <1442838158-2964-1-git-send-email-B48286@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1442838158-2964-1-git-send-email-B48286@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-i2c@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
Cc: Hou Zhiqiang <B48286@freescale.com>, Shaohui.Xie@freescale.com, corbet@lwn.net, bhupesh.sharma@freescale.com, mturquette@baylibre.com, wsa@the-dreams.de, sboyd@codeaurora.org, wim@iguana.be, Wenbin.Song@freescale.com, scottwood@freescale.com, Mingkai.Hu@freescale.com, leoli@freescale.com
List-Id: linux-i2c@vger.kernel.org

From: Shaohui Xie <Shaohui.Xie@freescale.com>

Modify watchdog/Kconfig file to support Layerscape platforms.

Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
Signed-off-by: Wenbin Song <Wenbin.Song@freescale.com>
Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index c68edc1..2862219 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -446,7 +446,7 @@ config MAX63XX_WATCHDOG
 
 config IMX2_WDT
 	tristate "IMX2+ Watchdog"
-	depends on ARCH_MXC
+	depends on ARCH_MXC || ARCH_LAYERSCAPE
 	select REGMAP_MMIO
 	select WATCHDOG_CORE
 	help
-- 
2.1.0.27.g96db324
