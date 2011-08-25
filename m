From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] staging/olpc_dcon: Remove obsolete cleanup for clientdata
Date: Thu, 25 Aug 2011 12:53:30 +0200
Message-ID: <1314269628-18325-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Andres Salomon <dilinger-pFFUokh25LWsTnJN9+BGXg@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Marek Belisko <marek.belisko-e6Ot0yJZRx5zTq7rFmK8cA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

A few new i2c-drivers came into the kernel which clear the clientdata-pointer
on exit or error. This is obsolete meanwhile, the core will do it.

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>
Cc: Andres Salomon <dilinger-pFFUokh25LWsTnJN9+BGXg@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Marek Belisko <marek.belisko-e6Ot0yJZRx5zTq7rFmK8cA@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/staging/olpc_dcon/olpc_dcon.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/olpc_dcon/olpc_dcon.c b/drivers/staging/olpc_dcon/olpc_dcon.c
index 750fe50..a235330 100644
--- a/drivers/staging/olpc_dcon/olpc_dcon.c
+++ b/drivers/staging/olpc_dcon/olpc_dcon.c
@@ -712,7 +712,6 @@ static int dcon_probe(struct i2c_client *client, const struct i2c_device_id *id)
  eirq:
 	free_irq(DCON_IRQ, dcon);
  einit:
-	i2c_set_clientdata(client, NULL);
 	kfree(dcon);
 	return rc;
 }
@@ -721,8 +720,6 @@ static int dcon_remove(struct i2c_client *client)
 {
 	struct dcon_priv *dcon = i2c_get_clientdata(client);
 
-	i2c_set_clientdata(client, NULL);
-
 	fb_unregister_client(&dcon->fbevent_nb);
 	unregister_reboot_notifier(&dcon->reboot_nb);
 	atomic_notifier_chain_unregister(&panic_notifier_list, &dcon_panic_nb);
-- 
1.7.5.4
