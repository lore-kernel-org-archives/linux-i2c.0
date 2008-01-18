From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: i2c-remove-redundant-i2c_client-list.patch
Date: Fri, 18 Jan 2008 02:16:22 -0800
Message-ID: <200801180216.22363.david-b@pacbell.net>
References: <20071216052308.A0FB11668D7@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<200801171159.00291.david-b@pacbell.net>
	<20080118103209.4b92ac76@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080118103209.4b92ac76-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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

On Friday 18 January 2008, Jean Delvare wrote:
> Hi David,
> 
> On Thu, 17 Jan 2008 11:59:00 -0800, David Brownell wrote:
> > This goes on top of the patch removing most i2c_adapter.clients usage,
> > updating i2c_attach_client:
> > 
> > ...
> 
> This looks OK to me, I'll add this to my i2c tree. All it is really
> missing is your Signed-off-by line.

Feel free to cut'n'paste that one from another file.  :)


> This gave me the idea of a similar cleanup in i2c_detach_client: I fail
> to see why we hold the clist lock while unregistering the device. What
> do you think of the following cleanup?

Looks OK.  Similarly, i2c_new_probed_device() could
use a driver model iterator instead of clist_lock.

Something else to think about:  clist_lock isn't used
when iterating over i2c_adapter.clients.  Maybe it should
just be removed, and replaced *everywhere* by core_lists...

- Dave


> * * * * *
> 
> We only need to hold adapter->clist_lock when we touch the client list.
> 
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>---
>  drivers/i2c/i2c-core.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- linux-2.6.24-rc8.orig/drivers/i2c/i2c-core.c	2008-01-18 09:56:07.000000000 +0100
> +++ linux-2.6.24-rc8/drivers/i2c/i2c-core.c	2008-01-18 10:17:01.000000000 +0100
> @@ -768,9 +768,10 @@ int i2c_detach_client(struct i2c_client 
>  
>  	mutex_lock(&adapter->clist_lock);
>  	list_del(&client->list);
> +	mutex_unlock(&adapter->clist_lock);
> +
>  	init_completion(&client->released);
>  	device_unregister(&client->dev);
> -	mutex_unlock(&adapter->clist_lock);
>  	wait_for_completion(&client->released);
>  
>   out:
> 
> 
> -- 
> Jean Delvare
> 



_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
