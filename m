From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c-remove-redundant-i2c_client-list.patch
Date: Tue, 8 Jan 2008 15:21:59 +0100
Message-ID: <20080108152159.0b974a86@hyperion.delvare>
References: <20071216052308.A0FB11668D7@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<200712291905.15160.david-b@pacbell.net>
	<20080106122356.78556b8a@hyperion.delvare>
	<200801061143.34020.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200801061143.34020.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 6 Jan 2008 11:43:33 -0800, David Brownell wrote:
> Remove further duplication between i2c core and driver model:  the
> per-adapter list of clients (adapter->clients,  client->list) and
> its lock (adapter->clist_lock) duplicate adapter->dev.children.
> 
> Add and use a new i2c_verify_client() routine to help code which
> traverses the driver model tree.
>  
> Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> ---
> LIGHTLY TESTED ... goes on top of two patches from Jean's I2C queue,
> 
> 	i2c-remove-redundant-i2c_adapter-list.patch
> 	i2c-remove-redundant-i2c_driver-list.patch
> 
> Updated per Jean's comments.  (Note that the i2c_verify_client
> bit might usefully be split out into a separate patch, to simplify
> converting the V4L code that uses this i2c client list.)

Agreed, I'll split things up as needed so that we have a clean
incremental patch set.

> (...)
>  static inline struct i2c_client *kobj_to_i2c_client(struct kobject *kobj)
>  {
> -	struct device * const dev = container_of(kobj, struct device, kobj);
> -	return to_i2c_client(dev);
> +	return i2c_verify_client(container_of(kobj, struct device, kobj));
>  }

Unless you have a reason to think that this is really needed, I think
I'll back this change out as explained in my previous post. All the
rest looks just fine to me, thanks!

-- 
Jean Delvare
