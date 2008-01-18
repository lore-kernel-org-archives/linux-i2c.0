From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c-remove-redundant-i2c_client-list.patch
Date: Fri, 18 Jan 2008 11:14:01 +0100
Message-ID: <20080118111401.7ffdccc5@hyperion.delvare>
References: <20071216052308.A0FB11668D7@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<200801091321.29212.david-b@pacbell.net>
	<20080110143105.456ddaf0@hyperion.delvare>
	<200801141420.49274.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200801141420.49274.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Mon, 14 Jan 2008 14:20:48 -0800, David Brownell wrote:
> OK, here's the trimmed-down patch that leaves the deletion
> paths untouched until we have a better solution.  I've only
> build-tested it, but it's basically $SUBJECT without those
> troublesome paths.
> 
> - Dave
> 
> =======	CUT HERE
> The i2c_adapter.clients list of i2c_client nodes duplicates driver
> model state.  This patch starts removing that list, letting us remove
> most existing users of those i2c-core lists.
> 
>  * The core I2C code now iterates over the driver model's list instead
>    of the i2c-internal one in some places where it's safe:
>       - Passing a command/ioctl to each client, a mechanims
>         used almost exclusively by DVB adapters;
>       - Device address checking, in both i2c-core and i2c-dev.
> 
>  * Provide i2c_verify_client() to use with driver model iterators.
> 
>  * Flag the relevant i2c_adapter and i2c_client fields as deprecated,
>    to help prevent new users from appearing.
> 
> For the moment the list needs to stick around, since some issues show
> up when deleting devices created by legacy I2C drivers.  (They don't
> follow standard driver model rules.  Removing those devices can cause
> self-deadlocks.)
> 
> Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> ---
>  drivers/i2c/i2c-core.c |   78 ++++++++++++++++++++++++++++---------------------
>  drivers/i2c/i2c-dev.c  |   29 +++++++-----------
>  include/linux/i2c.h    |    8 +++--
>  3 files changed, 63 insertions(+), 52 deletions(-)
> 
> --- at91.orig/drivers/i2c/i2c-core.c	2008-01-14 13:56:28.000000000 -0800
> +++ at91/drivers/i2c/i2c-core.c	2008-01-14 14:01:50.000000000 -0800
> (...)
> @@ -713,28 +732,19 @@ EXPORT_SYMBOL(i2c_del_driver);
>  
>  /* ------------------------------------------------------------------------- */
>  
> -static int __i2c_check_addr(struct i2c_adapter *adapter, unsigned int addr)
> +static int __i2c_check_addr(struct device *dev, void *addrp)
>  {
> -	struct list_head   *item;
> -	struct i2c_client  *client;
> +	struct i2c_client	*client = i2c_verify_client(dev);
> +	int			addr = *(int *)addrp;
>  
> -	list_for_each(item,&adapter->clients) {
> -		client = list_entry(item, struct i2c_client, list);
> -		if (client->addr == addr)
> -			return -EBUSY;
> -	}
> +	if (client && client->addr == addr)
> +		return -EBUSY;
>  	return 0;
>  }
>  
>  static int i2c_check_addr(struct i2c_adapter *adapter, int addr)
>  {
> -	int rval;
> -
> -	mutex_lock(&adapter->clist_lock);
> -	rval = __i2c_check_addr(adapter, addr);
> -	mutex_unlock(&adapter->clist_lock);
> -
> -	return rval;
> +	return device_for_each_child(&adapter->dev, &addr, __i2c_check_addr);
>  }
>  
>  int i2c_attach_client(struct i2c_client *client)

With this patch applied, any reason why i2c_new_probed_device() still
acquires adapter->clist_lock? My understanding is that it was there
because i2c_check_addr() was originally walking the internal client
list, but as this is no longer the case, the locking is no longer
needed, is it?

Thanks,
-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
