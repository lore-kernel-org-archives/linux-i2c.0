From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: i2c-remove-redundant-i2c_client-list.patch
Date: Thu, 17 Jan 2008 11:59:00 -0800
Message-ID: <200801171159.00291.david-b@pacbell.net>
References: <20071216052308.A0FB11668D7@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<200801091321.29212.david-b@pacbell.net>
	<200801171135.45797.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200801171135.45797.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thursday 17 January 2008, David Brownell wrote:
> > (d) Meanwhile, come up with a different solution to the deadlock
> > =A0 =A0 observed with i2c_adapter.clist ... which for some unknown
> > =A0 =A0 reason has *NOT* shown up for me with lockdep.
> =

> This should suffice. =A0Could be merged with the patch above,
> or even made to not depend on it.
> =

> And maybe the list_add should be moved after device_register()
> so the locking is only needed on that one path. =A0That'd be a
> net code shrink and simplification...

Grr.  Disregard that previous patch.  This version fixes bugs
in that one, and includes those cleanups too.  To make it not
depend on the previous patch, make it "__i2c_check_addr".

=3D=3D=3D=3D=3D=3D=3D=3D=3D SNIP!
This goes on top of the patch removing most i2c_adapter.clients usage,
updating i2c_attach_client:

 - Don't call device_register() while holding clist_lock.  This
   removes a self-deadlock when on the i2c_driver.probe() path,
   for drivers that need to attach new devices (e.g. dummies).

 - Remove a redundant address check.  The driver model core does
   this as a consequence of guaranteeing unique names.

 - Move the "device registered" diagnostic so that it never lies;
   previously, on error paths it would falsely report success.

---
 drivers/i2c/i2c-core.c |   22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

--- at91.orig/drivers/i2c/i2c-core.c	2008-01-17 10:07:38.000000000 -0800
+++ at91/drivers/i2c/i2c-core.c	2008-01-17 11:53:01.000000000 -0800
@@ -752,13 +752,6 @@ int i2c_attach_client(struct i2c_client =

 	struct i2c_adapter *adapter =3D client->adapter;
 	int res =3D 0;
 =

-	mutex_lock(&adapter->clist_lock);
-	if (i2c_check_addr(client->adapter, client->addr)) {
-		res =3D -EBUSY;
-		goto out_unlock;
-	}
-	list_add_tail(&client->list,&adapter->clients);
-
 	client->usage_count =3D 0;
 =

 	client->dev.parent =3D &client->adapter->dev;
@@ -775,13 +768,17 @@ int i2c_attach_client(struct i2c_client =

 =

 	snprintf(&client->dev.bus_id[0], sizeof(client->dev.bus_id),
 		"%d-%04x", i2c_adapter_id(adapter), client->addr);
-	dev_dbg(&adapter->dev, "client [%s] registered with bus id %s\n",
-		client->name, client->dev.bus_id);
 	res =3D device_register(&client->dev);
 	if (res)
-		goto out_list;
+		goto out_err;
+
+	mutex_lock(&adapter->clist_lock);
+	list_add_tail(&client->list,&adapter->clients);
 	mutex_unlock(&adapter->clist_lock);
 =

+	dev_dbg(&adapter->dev, "client [%s] registered with bus id %s\n",
+		client->name, client->dev.bus_id);
+
 	if (adapter->client_register)  {
 		if (adapter->client_register(client)) {
 			dev_dbg(&adapter->dev, "client_register "
@@ -792,12 +789,9 @@ int i2c_attach_client(struct i2c_client =

 =

 	return 0;
 =

-out_list:
-	list_del(&client->list);
+out_err:
 	dev_err(&adapter->dev, "Failed to attach i2c client %s at 0x%02x "
 		"(%d)\n", client->name, client->addr, res);
-out_unlock:
-	mutex_unlock(&adapter->clist_lock);
 	return res;
 }
 EXPORT_SYMBOL(i2c_attach_client);


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
