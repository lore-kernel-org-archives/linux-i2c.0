From: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH V2 10/11] ARM: imx6q: change clkdev device name from xxxx.uart to xxxx.serial
Date: Wed, 9 May 2012 19:33:09 +0800
Message-ID: <1336563190-19974-11-git-send-email-richard.zhao@freescale.com>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1336563190-19974-1-git-send-email-richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dong.aisheng-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

It's because the dts changed the node name.

Signed-off-by: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 arch/arm/mach-imx/clk-imx6q.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 096fcfb..4ac1282 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -393,16 +393,16 @@ int __init mx6q_clocks_init(void)
 	clk_register_clkdev(clk[gpt_ipg_per], "per", "imx-gpt.0");
 	clk_register_clkdev(clk[twd], NULL, "smp_twd");
 	clk_register_clkdev(clk[usboh3], NULL, "usboh3");
-	clk_register_clkdev(clk[uart_serial], "per", "2020000.uart");
-	clk_register_clkdev(clk[uart_ipg], "ipg", "2020000.uart");
-	clk_register_clkdev(clk[uart_serial], "per", "21e8000.uart");
-	clk_register_clkdev(clk[uart_ipg], "ipg", "21e8000.uart");
-	clk_register_clkdev(clk[uart_serial], "per", "21ec000.uart");
-	clk_register_clkdev(clk[uart_ipg], "ipg", "21ec000.uart");
-	clk_register_clkdev(clk[uart_serial], "per", "21f0000.uart");
-	clk_register_clkdev(clk[uart_ipg], "ipg", "21f0000.uart");
-	clk_register_clkdev(clk[uart_serial], "per", "21f4000.uart");
-	clk_register_clkdev(clk[uart_ipg], "ipg", "21f4000.uart");
+	clk_register_clkdev(clk[uart_serial], "per", "2020000.serial");
+	clk_register_clkdev(clk[uart_ipg], "ipg", "2020000.serial");
+	clk_register_clkdev(clk[uart_serial], "per", "21e8000.serial");
+	clk_register_clkdev(clk[uart_ipg], "ipg", "21e8000.serial");
+	clk_register_clkdev(clk[uart_serial], "per", "21ec000.serial");
+	clk_register_clkdev(clk[uart_ipg], "ipg", "21ec000.serial");
+	clk_register_clkdev(clk[uart_serial], "per", "21f0000.serial");
+	clk_register_clkdev(clk[uart_ipg], "ipg", "21f0000.serial");
+	clk_register_clkdev(clk[uart_serial], "per", "21f4000.serial");
+	clk_register_clkdev(clk[uart_ipg], "ipg", "21f4000.serial");
 	clk_register_clkdev(clk[enet], NULL, "2188000.enet");
 	clk_register_clkdev(clk[usdhc1], NULL, "2190000.usdhc");
 	clk_register_clkdev(clk[usdhc2], NULL, "2194000.usdhc");
-- 
1.7.5.4
