From: Nikolaus Voss <n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>
Subject: [PATCH v10 2/4] Replace clk_lookup.con_id with clk_lookup.dev_id entries
 for twi clk
Date: Tue, 8 Nov 2011 12:09:30 +0100
Message-ID: <b9d32fc38e2e1c3ec21f402f3b8967b136e7a0ff.1334916810.git.n.voss@weinmann.de>
References: <cover.1334916810.git.n.voss@weinmann.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1334916810.git.n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, h.feurstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, adrian.yanes-uOixanVlb7U@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The old driver used con_id clock entries. Convert to use dev_id
for clock lookup via standard method.

Signed-off-by: Nikolaus Voss <n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>
---
 arch/arm/mach-at91/at91cap9.c    |    1 +
 arch/arm/mach-at91/at91rm9200.c  |    1 +
 arch/arm/mach-at91/at91sam9260.c |    1 +
 arch/arm/mach-at91/at91sam9261.c |    1 +
 arch/arm/mach-at91/at91sam9263.c |    1 +
 arch/arm/mach-at91/at91sam9g45.c |    2 ++
 arch/arm/mach-at91/at91sam9rl.c  |    2 ++
 7 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
index a42edc2..676d6cf 100644
--- a/arch/arm/mach-at91/at91cap9.c
+++ b/arch/arm/mach-at91/at91cap9.c
@@ -219,6 +219,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("t0_clk", "atmel_tcb.0", &tcb_clk),
 	CLKDEV_CON_DEV_ID("pclk", "ssc.0", &ssc0_clk),
 	CLKDEV_CON_DEV_ID("pclk", "ssc.1", &ssc1_clk),
+	CLKDEV_CON_DEV_ID(NULL, "at91_i2c", &twi_clk),
 	/* fake hclk clock */
 	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &ohci_clk),
 	CLKDEV_CON_ID("pioA", &pioABCD_clk),
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 99c3174..7c597e5 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -194,6 +194,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("pclk", "ssc.0", &ssc0_clk),
 	CLKDEV_CON_DEV_ID("pclk", "ssc.1", &ssc1_clk),
 	CLKDEV_CON_DEV_ID("pclk", "ssc.2", &ssc2_clk),
+	CLKDEV_CON_DEV_ID(NULL, "at91_i2c", &twi_clk),
 	/* fake hclk clock */
 	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &ohci_clk),
 	CLKDEV_CON_ID("pioA", &pioA_clk),
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index d4036ba..e21a3dc 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -200,6 +200,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("t1_clk", "atmel_tcb.1", &tc4_clk),
 	CLKDEV_CON_DEV_ID("t2_clk", "atmel_tcb.1", &tc5_clk),
 	CLKDEV_CON_DEV_ID("pclk", "ssc.0", &ssc_clk),
+	CLKDEV_CON_DEV_ID(NULL, "at91_i2c", &twi_clk),
 	/* more usart lookup table for DT entries */
 	CLKDEV_CON_DEV_ID("usart", "fffff200.serial", &mck),
 	CLKDEV_CON_DEV_ID("usart", "fffb0000.serial", &usart0_clk),
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index 023c2ff..b84d882 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -175,6 +175,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("pclk", "ssc.1", &ssc1_clk),
 	CLKDEV_CON_DEV_ID("pclk", "ssc.2", &ssc2_clk),
 	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &hck0),
+	CLKDEV_CON_DEV_ID(NULL, "at91_i2c", &twi_clk),
 	CLKDEV_CON_ID("pioA", &pioA_clk),
 	CLKDEV_CON_ID("pioB", &pioB_clk),
 	CLKDEV_CON_ID("pioC", &pioC_clk),
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 75e876c..e6e6a80 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -190,6 +190,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("spi_clk", "atmel_spi.0", &spi0_clk),
 	CLKDEV_CON_DEV_ID("spi_clk", "atmel_spi.1", &spi1_clk),
 	CLKDEV_CON_DEV_ID("t0_clk", "atmel_tcb.0", &tcb_clk),
+	CLKDEV_CON_DEV_ID(NULL, "at91_i2c", &twi_clk),
 	/* fake hclk clock */
 	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &ohci_clk),
 	CLKDEV_CON_ID("pioA", &pioA_clk),
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 1cb6a96..9e7ca32 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -220,6 +220,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("spi_clk", "atmel_spi.1", &spi1_clk),
 	CLKDEV_CON_DEV_ID("t0_clk", "atmel_tcb.0", &tcb0_clk),
 	CLKDEV_CON_DEV_ID("t0_clk", "atmel_tcb.1", &tcb0_clk),
+	CLKDEV_CON_DEV_ID(NULL, "at91_i2c.0", &twi0_clk),
+	CLKDEV_CON_DEV_ID(NULL, "at91_i2c.1", &twi1_clk),
 	CLKDEV_CON_DEV_ID("pclk", "ssc.0", &ssc0_clk),
 	CLKDEV_CON_DEV_ID("pclk", "ssc.1", &ssc1_clk),
 	CLKDEV_CON_DEV_ID(NULL, "atmel-trng", &trng_clk),
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index d2c91a8..2c88b94 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -183,6 +183,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("t2_clk", "atmel_tcb.0", &tc2_clk),
 	CLKDEV_CON_DEV_ID("pclk", "ssc.0", &ssc0_clk),
 	CLKDEV_CON_DEV_ID("pclk", "ssc.1", &ssc1_clk),
+	CLKDEV_CON_DEV_ID(NULL, "at91_i2c.0", &twi0_clk),
+	CLKDEV_CON_DEV_ID(NULL, "at91_i2c.1", &twi1_clk),
 	CLKDEV_CON_ID("pioA", &pioA_clk),
 	CLKDEV_CON_ID("pioB", &pioB_clk),
 	CLKDEV_CON_ID("pioC", &pioC_clk),
-- 
1.7.5.4
