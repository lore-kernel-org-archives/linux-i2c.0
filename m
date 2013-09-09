From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/2] i2c: bfin-twi: Remove casting the return value which is a
 void pointer
Date: Mon, 09 Sep 2013 14:32:25 +0900
Message-ID: <005101cead1d$f7411ee0$e5c35ca0$%han@samsung.com>
References: <005001cead1d$d68d3bc0$83a7b340$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <005001cead1d$d68d3bc0$83a7b340$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: 'Wolfram Sang' <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Casting the return value which is a void pointer is redundant.
The conversion from void pointer to any other pointer type is
guaranteed by the C programming language.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-bfin-twi.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index 35a473b..3b9bd9a 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -675,7 +675,7 @@ static int i2c_bfin_twi_probe(struct platform_device *pdev)
 	p_adap->retries = 3;
 
 	rc = peripheral_request_list(
-			(unsigned short *)dev_get_platdata(&pdev->dev),
+			dev_get_platdata(&pdev->dev),
 			"i2c-bfin-twi");
 	if (rc) {
 		dev_err(&pdev->dev, "Can't setup pin mux!\n");
@@ -723,7 +723,7 @@ out_error_add_adapter:
 	free_irq(iface->irq, iface);
 out_error_req_irq:
 out_error_no_irq:
-	peripheral_free_list((unsigned short *)dev_get_platdata(&pdev->dev));
+	peripheral_free_list(dev_get_platdata(&pdev->dev));
 out_error_pin_mux:
 	iounmap(iface->regs_base);
 out_error_ioremap:
@@ -739,7 +739,7 @@ static int i2c_bfin_twi_remove(struct platform_device *pdev)
 
 	i2c_del_adapter(&(iface->adap));
 	free_irq(iface->irq, iface);
-	peripheral_free_list((unsigned short *)dev_get_platdata(&pdev->dev));
+	peripheral_free_list(dev_get_platdata(&pdev->dev));
 	iounmap(iface->regs_base);
 	kfree(iface);
 
-- 
1.7.10.4
