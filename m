From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.26-rc1] i2c_use_client() defends against NULL
Date: Sun, 4 May 2008 13:06:20 -0700
Message-ID: <200805041306.21074.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Defend the i2c refcount calls against NULL pointers, as is important
(and conventional) for such calls ... we don't want to morph NULL
pointers into bogus non-null ones.  Note that none of the current
callers of i2c_use_client() use its return value.

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/i2c/i2c-core.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- g26.orig/drivers/i2c/i2c-core.c	2008-05-04 12:50:33.000000000 -0700
+++ g26/drivers/i2c/i2c-core.c	2008-05-04 12:51:04.000000000 -0700
@@ -1013,8 +1013,9 @@ EXPORT_SYMBOL(i2c_detach_client);
  */
 struct i2c_client *i2c_use_client(struct i2c_client *client)
 {
-	get_device(&client->dev);
-	return client;
+	if (client && get_device(&client->dev))
+		return client;
+	return NULL;
 }
 EXPORT_SYMBOL(i2c_use_client);
 
@@ -1026,7 +1027,8 @@ EXPORT_SYMBOL(i2c_use_client);
  */
 void i2c_release_client(struct i2c_client *client)
 {
-	put_device(&client->dev);
+	if (client)
+		put_device(&client->dev);
 }
 EXPORT_SYMBOL(i2c_release_client);
 

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
