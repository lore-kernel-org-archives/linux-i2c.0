From: Nikolaus Voss <n.voss@weinmann.de>
Subject: [PATCH V3 4/4] Add lookup entries for twi_clk for devices with more
 than one TWI port
Date: Tue, 8 Nov 2011 12:09:30 +0100
Message-ID: <d395122d7633e7e64854b30da5e587e5afeb2dd2.1320753142.git.n.voss@weinmann.de>
References: <cover.1320753142.git.n.voss@weinmann.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1320753142.git.n.voss@weinmann.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: ben-linux@fluff.org, khali@linux-fr.org, nicolas.ferre@atmel.com, rmallon@gmail.com, balbi@ti.com
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Nikolaus Voss <n.voss@weinmann.de>
---
 arch/arm/mach-at91/at91sam9g45.c |    2 ++
 arch/arm/mach-at91/at91sam9rl.c  |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index e04c5fb..c985fdb 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -215,6 +215,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("t0_clk", "atmel_tcb.1", &tcb0_clk),
 	CLKDEV_CON_DEV_ID("pclk", "ssc.0", &ssc0_clk),
 	CLKDEV_CON_DEV_ID("pclk", "ssc.1", &ssc1_clk),
+	CLKDEV_CON_DEV_ID("twi_clk", "at91_i2c.0", &twi0_clk),
+	CLKDEV_CON_DEV_ID("twi_clk", "at91_i2c.1", &twi1_clk),
 };
 
 static struct clk_lookup usart_clocks_lookups[] = {
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index a238105..ab81223 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -184,6 +184,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("t2_clk", "atmel_tcb.0", &tc2_clk),
 	CLKDEV_CON_DEV_ID("pclk", "ssc.0", &ssc0_clk),
 	CLKDEV_CON_DEV_ID("pclk", "ssc.1", &ssc1_clk),
+	CLKDEV_CON_DEV_ID("twi_clk", "at91_i2c.0", &twi0_clk),
+	CLKDEV_CON_DEV_ID("twi_clk", "at91_i2c.1", &twi1_clk),
 };
 
 static struct clk_lookup usart_clocks_lookups[] = {
-- 
1.7.5.4
