From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Call client_unregister for new-style devices too
Date: Mon, 14 Jul 2008 11:56:13 +0200
Message-ID: <20080714115613.3d5f608d@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

We call adapter->client_register for both legacy and new-style i2c
devices, however we only call adapter->client_unregister for legacy
drivers. This doesn't make much sense. Usually, drivers will undo
in client_unregister what they did in client_register, so we should
call neither or both for every given i2c device.

In order to ease the transition from legacy to new-style devices, it
seems preferable to actually call both.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
---
David, is this OK with you?

 drivers/i2c/i2c-core.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- linux-2.6.26-rc9.orig/drivers/i2c/i2c-core.c	2008-07-13 17:29:04.000000000 +0200
+++ linux-2.6.26-rc9/drivers/i2c/i2c-core.c	2008-07-13 17:30:01.000000000 +0200
@@ -300,6 +300,14 @@ void i2c_unregister_device(struct i2c_cl
 		return;
 	}
 
+	if (adapter->client_unregister) {
+		if (adapter->client_unregister(client)) {
+			dev_warn(&client->dev,
+				 "client_unregister [%s] failed\n",
+				 client->name);
+		}
+	}
+
 	mutex_lock(&adapter->clist_lock);
 	list_del(&client->list);
 	mutex_unlock(&adapter->clist_lock);


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
