From: Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c: at91: fix unsed variable warning when building with !CONFIG_OF
Date: Sat,  9 Feb 2013 19:14:00 +0100
Message-ID: <1360433640-30160-1-git-send-email-manabian@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Commit 70d46a2 "i2c: at91: add dt support to i2c-at91"
added DT only support for at91sam9x5. Building i2c-at91
without CONFIG_OF now warns about at91sam9x5_config as
being unused.

  drivers/i2c/busses/i2c-at91.c:556:30: warning: 'at91sam9x5_config' defined but not used [-Wunused-variable]

Move at91sam9x5_config under the defined(CONFIG_OF)
guard as new AT91 SoCs will be DT only.

Signed-off-by: Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
Hi,

This patch is agains 3.8-rc7 since the warning was
introduced in the 3.8 merge cycle.

regards
Joachim Eastwood


 drivers/i2c/busses/i2c-at91.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 2bfc04d..708026b 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -553,13 +553,6 @@ static struct at91_twi_pdata at91sam9g10_config = {
 	.has_dma_support = false,
 };
 
-static struct at91_twi_pdata at91sam9x5_config = {
-	.clk_max_div = 7,
-	.clk_offset = 4,
-	.has_unre_flag = false,
-	.has_dma_support = true,
-};
-
 static const struct platform_device_id at91_twi_devtypes[] = {
 	{
 		.name = "i2c-at91rm9200",
@@ -582,6 +575,13 @@ static const struct platform_device_id at91_twi_devtypes[] = {
 };
 
 #if defined(CONFIG_OF)
+static struct at91_twi_pdata at91sam9x5_config = {
+	.clk_max_div = 7,
+	.clk_offset = 4,
+	.has_unre_flag = false,
+	.has_dma_support = true,
+};
+
 static const struct of_device_id atmel_twi_dt_ids[] = {
 	{
 		.compatible = "atmel,at91sam9260-i2c",
-- 
1.8.0
