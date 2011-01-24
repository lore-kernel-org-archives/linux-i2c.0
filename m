From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 3/4] staging/ste_rmi4: Remove obsolete cleanup for clientdata
Date: Mon, 24 Jan 2011 11:44:29 +0100
Message-ID: <1295865880-27672-3-git-send-email-w.sang@pengutronix.de>
References: <1295865880-27672-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1295865880-27672-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Naveen Kumar Gaddipati <naveen.gaddipati-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

A few new i2c-drivers came into the kernel which clear the clientdata-pointer
on exit or error. This is obsolete meanwhile, the core will do it.

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>
Cc: Naveen Kumar Gaddipati <naveen.gaddipati-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Cc: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
---

Compile tested only.

 drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c b/drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c
index e8f047e..c9207de 100644
--- a/drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c
+++ b/drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c
@@ -989,7 +989,7 @@ static int __devinit synaptics_rmi4_probe
 	retval = input_register_device(rmi4_data->input_dev);
 	if (retval) {
 		dev_err(&client->dev, "%s:input register failed\n", __func__);
-		goto err_input_register;
+		goto err_query_dev;
 	}
 
 	/* Clear interrupts */
@@ -1011,8 +1011,6 @@ static int __devinit synaptics_rmi4_probe
 err_request_irq:
 	free_irq(platformdata->irq_number, rmi4_data);
 	input_unregister_device(rmi4_data->input_dev);
-err_input_register:
-	i2c_set_clientdata(client, NULL);
 err_query_dev:
 	if (platformdata->regulator_en) {
 		regulator_disable(rmi4_data->regulator);
-- 
1.7.2.3
