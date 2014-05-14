From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH V2] i2c: ocores: Make of_device_id array const
Date: Thu, 15 May 2014 08:17:33 +0900
Message-ID: <005801cf6fca$af7fd0e0$0e7f72a0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Peter Korsgaard' <peter-+2lRwdCCLRT2eFz/2MeuCQ@public.gmane.org>, 'Maxime COQUELIN' <maxime.coquelin-qxv4g6HH51o@public.gmane.org>, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Make of_device_id array const, because all OF functions
handle it as const.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Acked-by: Peter Korsgaard <peter-+2lRwdCCLRT2eFz/2MeuCQ@public.gmane.org>
Acked-by: Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
---
Changes since v1:
- squashed all patches into a single patch
- added acked-by

 drivers/i2c/busses/i2c-ocores.c |    2 +-
 drivers/i2c/busses/i2c-pxa.c    |    2 +-
 drivers/i2c/busses/i2c-riic.c   |    2 +-
 drivers/i2c/busses/i2c-st.c     |    2 +-
 drivers/i2c/busses/i2c-wmt.c    |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 1f6369f..0e10cc6 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -250,7 +250,7 @@ static struct i2c_adapter ocores_adapter = {
 	.algo		= &ocores_algorithm,
 };
 
-static struct of_device_id ocores_i2c_match[] = {
+static const struct of_device_id ocores_i2c_match[] = {
 	{
 		.compatible = "opencores,i2c-ocores",
 		.data = (void *)TYPE_OCORES,
diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index bbe6dfb..be671f7 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1084,7 +1084,7 @@ static const struct i2c_algorithm i2c_pxa_pio_algorithm = {
 	.functionality	= i2c_pxa_functionality,
 };
 
-static struct of_device_id i2c_pxa_dt_ids[] = {
+static const struct of_device_id i2c_pxa_dt_ids[] = {
 	{ .compatible = "mrvl,pxa-i2c", .data = (void *)REGS_PXA2XX },
 	{ .compatible = "mrvl,pwri2c", .data = (void *)REGS_PXA3XX },
 	{ .compatible = "mrvl,mmp-twsi", .data = (void *)REGS_PXA2XX },
diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 9e1f8ba..af3b3d0 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -404,7 +404,7 @@ static int riic_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id riic_i2c_dt_ids[] = {
+static const struct of_device_id riic_i2c_dt_ids[] = {
 	{ .compatible = "renesas,riic-rz" },
 	{ /* Sentinel */ },
 };
diff --git a/drivers/i2c/busses/i2c-st.c b/drivers/i2c/busses/i2c-st.c
index 8720161..95b94767 100644
--- a/drivers/i2c/busses/i2c-st.c
+++ b/drivers/i2c/busses/i2c-st.c
@@ -847,7 +847,7 @@ static int st_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id st_i2c_match[] = {
+static const struct of_device_id st_i2c_match[] = {
 	{ .compatible = "st,comms-ssc-i2c", },
 	{ .compatible = "st,comms-ssc4-i2c", },
 	{},
diff --git a/drivers/i2c/busses/i2c-wmt.c b/drivers/i2c/busses/i2c-wmt.c
index 2c8a3e4..924b501 100644
--- a/drivers/i2c/busses/i2c-wmt.c
+++ b/drivers/i2c/busses/i2c-wmt.c
@@ -454,7 +454,7 @@ static int wmt_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id wmt_i2c_dt_ids[] = {
+static const struct of_device_id wmt_i2c_dt_ids[] = {
 	{ .compatible = "wm,wm8505-i2c" },
 	{ /* Sentinel */ },
 };
-- 
1.7.10.4
