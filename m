From: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
Subject: [PATCH] drivers/i2c/i2c-smbus.c: convert kzalloc to devm_kzalloc
Date: Sat,  4 Aug 2012 19:10:48 +0200
Message-ID: <1344100248-16238-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "Wolfram Sang (embedded platforms)" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>

Converting kzalloc to devm_kzalloc simplifies the code and ensures that the
result, alert, is freed after the irq allocated by the subsequent
devm_request_irq.  This in turn ensures that when an interrupt can be
triggered, the alert structure is still available.

The problem of a free after a devm_request_irq was found using the
following semantic match (http://coccinelle.lip6.fr/)

// <smpl>
@r exists@
expression e1,e2,x,a,b,c,d;
identifier free;
position p1,p2;
@@

  devm_request_irq@p1(e1,e2,...,x)
  ... when any
      when != e2 = a
      when != x = b
  if (...) {
    ... when != e2 = c
        when != x = d
    free@p2(...,x,...);
    ...
    return ...;
  }
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>

---
 drivers/i2c/i2c-smbus.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index df3e0bf..50a36cf 100644
--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -142,7 +142,8 @@ static int smbalert_probe(struct i2c_client *ara,
 	struct i2c_adapter *adapter = ara->adapter;
 	int res;
 
-	alert = kzalloc(sizeof(struct i2c_smbus_alert), GFP_KERNEL);
+	alert = devm_kzalloc(&ara->dev, sizeof(struct i2c_smbus_alert),
+			     GFP_KERNEL);
 	if (!alert)
 		return -ENOMEM;
 
@@ -154,10 +155,8 @@ static int smbalert_probe(struct i2c_client *ara,
 	if (setup->irq > 0) {
 		res = devm_request_irq(&ara->dev, setup->irq, smbalert_irq,
 				       0, "smbus_alert", alert);
-		if (res) {
-			kfree(alert);
+		if (res)
 			return res;
-		}
 	}
 
 	i2c_set_clientdata(ara, alert);
@@ -167,14 +166,12 @@ static int smbalert_probe(struct i2c_client *ara,
 	return 0;
 }
 
-/* IRQ resource is managed so it is freed automatically */
+/* IRQ resource and alert are managed so they are freed automatically */
 static int smbalert_remove(struct i2c_client *ara)
 {
 	struct i2c_smbus_alert *alert = i2c_get_clientdata(ara);
 
 	cancel_work_sync(&alert->alert);
-
-	kfree(alert);
 	return 0;
 }
 
