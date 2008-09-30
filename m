From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.27-rc7] i2c: guard against oopses from bad
	init sequences
Date: Tue, 30 Sep 2008 08:50:41 -0700
Message-ID: <200809300850.42213.david-b@pacbell.net>
References: <200809231138.19583.david-b@pacbell.net>
	<20080930112920.11d0326c@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080930112920.11d0326c-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tuesday 30 September 2008, Jean Delvare wrote:

> > --- a/drivers/i2c/i2c-core.c
> > +++ b/drivers/i2c/i2c-core.c
> > @@ -443,6 +443,12 @@ static int i2c_register_adapter(struct i
> >  
> >  	mutex_lock(&core_lock);
> >  
> > +	/* can't register until after driver model init */
> > +	if (WARN_ON(!i2c_bus_type.p)) {
> > +		res = -ENOENT;
> > +		goto out_list;
> > +	}
> > +
> 
> Why don't you test before acquiring core_lock? Or even, before doing
> anything else, as you do in i2c_register_driver. That's more consistent
> and makes the error path lighter.

One or the other was an afterthought.  I don't recall which one.  ;)


> So, I would apply the following patch if that's OK with you:

Sure ... I'll be happy to have such issues be more diagnosable.

- Dave


>  drivers/i2c/i2c-core.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> --- linux-2.6.27-rc8.orig/drivers/i2c/i2c-core.c	2008-09-30 10:14:21.000000000 +0200
> +++ linux-2.6.27-rc8/drivers/i2c/i2c-core.c	2008-09-30 11:19:30.000000000 +0200
> @@ -437,6 +437,10 @@ static int i2c_register_adapter(struct i
>  {
>  	int res = 0, dummy;
>  
> +	/* Can't register until after driver model init */
> +	if (WARN_ON(!i2c_bus_type.p))
> +		return -EAGAIN;
> +
>  	mutex_init(&adap->bus_lock);
>  	mutex_init(&adap->clist_lock);
>  	INIT_LIST_HEAD(&adap->clients);
> @@ -696,6 +700,10 @@ int i2c_register_driver(struct module *o
>  {
>  	int res;
>  
> +	/* Can't register until after driver model init */
> +	if (WARN_ON(!i2c_bus_type.p))
> +		return -EAGAIN;
> +
>  	/* new style driver methods can't mix with legacy ones */
>  	if (is_newstyle_driver(driver)) {
>  		if (driver->attach_adapter || driver->detach_adapter
> 
> 

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
