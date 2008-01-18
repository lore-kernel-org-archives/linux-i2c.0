From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c-remove-redundant-i2c_client-list.patch
Date: Fri, 18 Jan 2008 10:32:09 +0100
Message-ID: <20080118103209.4b92ac76@hyperion.delvare>
References: <20071216052308.A0FB11668D7@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<200801091321.29212.david-b@pacbell.net>
	<200801171135.45797.david-b@pacbell.net>
	<200801171159.00291.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200801171159.00291.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi David,

On Thu, 17 Jan 2008 11:59:00 -0800, David Brownell wrote:
> This goes on top of the patch removing most i2c_adapter.clients usage,
> updating i2c_attach_client:
> 
>  - Don't call device_register() while holding clist_lock.  This
>    removes a self-deadlock when on the i2c_driver.probe() path,
>    for drivers that need to attach new devices (e.g. dummies).
> 
>  - Remove a redundant address check.  The driver model core does
>    this as a consequence of guaranteeing unique names.
> 
>  - Move the "device registered" diagnostic so that it never lies;
>    previously, on error paths it would falsely report success.
> 
> ---
>  drivers/i2c/i2c-core.c |   22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
> 
> --- at91.orig/drivers/i2c/i2c-core.c	2008-01-17 10:07:38.000000000 -0800
> +++ at91/drivers/i2c/i2c-core.c	2008-01-17 11:53:01.000000000 -0800
> @@ -752,13 +752,6 @@ int i2c_attach_client(struct i2c_client 
>  	struct i2c_adapter *adapter = client->adapter;
>  	int res = 0;
>  
> -	mutex_lock(&adapter->clist_lock);
> -	if (i2c_check_addr(client->adapter, client->addr)) {
> -		res = -EBUSY;
> -		goto out_unlock;
> -	}
> -	list_add_tail(&client->list,&adapter->clients);
> -
>  	client->usage_count = 0;
>  
>  	client->dev.parent = &client->adapter->dev;
> @@ -775,13 +768,17 @@ int i2c_attach_client(struct i2c_client 
>  
>  	snprintf(&client->dev.bus_id[0], sizeof(client->dev.bus_id),
>  		"%d-%04x", i2c_adapter_id(adapter), client->addr);
> -	dev_dbg(&adapter->dev, "client [%s] registered with bus id %s\n",
> -		client->name, client->dev.bus_id);
>  	res = device_register(&client->dev);
>  	if (res)
> -		goto out_list;
> +		goto out_err;
> +
> +	mutex_lock(&adapter->clist_lock);
> +	list_add_tail(&client->list,&adapter->clients);
>  	mutex_unlock(&adapter->clist_lock);
>  
> +	dev_dbg(&adapter->dev, "client [%s] registered with bus id %s\n",
> +		client->name, client->dev.bus_id);
> +
>  	if (adapter->client_register)  {
>  		if (adapter->client_register(client)) {
>  			dev_dbg(&adapter->dev, "client_register "
> @@ -792,12 +789,9 @@ int i2c_attach_client(struct i2c_client 
>  
>  	return 0;
>  
> -out_list:
> -	list_del(&client->list);
> +out_err:
>  	dev_err(&adapter->dev, "Failed to attach i2c client %s at 0x%02x "
>  		"(%d)\n", client->name, client->addr, res);
> -out_unlock:
> -	mutex_unlock(&adapter->clist_lock);
>  	return res;
>  }
>  EXPORT_SYMBOL(i2c_attach_client);

This looks OK to me, I'll add this to my i2c tree. All it is really
missing is your Signed-off-by line.

This gave me the idea of a similar cleanup in i2c_detach_client: I fail
to see why we hold the clist lock while unregistering the device. What
do you think of the following cleanup?

* * * * *

We only need to hold adapter->clist_lock when we touch the client list.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>---
 drivers/i2c/i2c-core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.24-rc8.orig/drivers/i2c/i2c-core.c	2008-01-18 09:56:07.000000000 +0100
+++ linux-2.6.24-rc8/drivers/i2c/i2c-core.c	2008-01-18 10:17:01.000000000 +0100
@@ -768,9 +768,10 @@ int i2c_detach_client(struct i2c_client 
 
 	mutex_lock(&adapter->clist_lock);
 	list_del(&client->list);
+	mutex_unlock(&adapter->clist_lock);
+
 	init_completion(&client->released);
 	device_unregister(&client->dev);
-	mutex_unlock(&adapter->clist_lock);
 	wait_for_completion(&client->released);
 
  out:


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
