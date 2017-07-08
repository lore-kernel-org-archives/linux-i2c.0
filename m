From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [2/5,v2] Modify behaviour of request_*muxed_region()
Date: Sat, 8 Jul 2017 08:37:02 -0700
Message-ID: <20170708153702.GA17711@roeck-us.net>
References: <20170622132134.7200-3-zboszor@pr.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170622132134.7200-3-zboszor-v1d7l9VOqKc@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?B?Wm9sdOFuIEL2c3r2cm3pbnlp?= <zboszor-v1d7l9VOqKc@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Menzel <paulepanter-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Christian Fetzer <fetzer.ch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Nehal Shah <nehal-bakulchandra.shah-5C7GfCeVMHo@public.gmane.org>, Tim Small <tim-v0yPK6tSSg/10XsdtD+oqA@public.gmane.org>, kernel-i2qG/+7/Q79eoWH0uzbU5w@public.gmane.org, wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org, jlayton-vpEMnDpepFuMZCB2o+C8xQ@public.gmane.org, marc.2377-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, cshorler-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, regressions-rCxcAJFjeRkk+I/owrrOrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Jun 22, 2017 at 03:21:31PM +0200, Zoltán Böszörményi wrote:
> In order to make request_*muxed_region() behave more like
> mutex_lock(), a possible failure case needs to be eliminated.
> When drivers do not properly share the same I/O region, e.g.
> one is using request_region() and the other is using
> request_muxed_region(), the kernel didn't warn the user about it.
> This change modifies IORESOURCE_MUXED behaviour so it always
> goes to sleep waiting for the resuorce to be freed and the
> inconsistent resource flag usage is logged with KERN_ERR.
> 
> v2: Fixed checkpatch.pl warnings and extended the comment
>     about request_declared_muxed_region.
> 
> Signed-off-by: Zoltán Böszörményi <zboszor-v1d7l9VOqKc@public.gmane.org>

It might make sense to go through your series, determine who touched
the files you are changing and who was Cc:'d, and use that to create
a useful list of people to Cc:. You copied a lot of people, but I don't
see anyone who recently touched this file. The same is true for your other
'core' patches. In some cases you did not even copy the maintainer(s).
It might also make sense to add explicit "Cc:" entries, to inform people
that you expect them to provide feedback.

As it is, it will be all but impossible to get your patch series accepted,
simply because the people in position to approve the core changes don't
know about it.

Guenter

> ---
>  kernel/resource.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 2be7029..5df2731 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -1125,6 +1125,7 @@ resource_size_t resource_alignment(struct resource *res)
>   *
>   * request_declared_muxed_region creates a new shared busy region
>   * described in an existing resource descriptor.
> + * It only returns if it succeeded.
>   *
>   * release_region releases a matching busy region.
>   * The region is only freed if it was allocated.
> @@ -1191,7 +1192,10 @@ struct resource *__request_declared_region(struct resource *parent,
>  				continue;
>  			}
>  		}
> -		if (conflict->flags & flags & IORESOURCE_MUXED) {
> +		if (flags & IORESOURCE_MUXED) {
> +			if (!(conflict->flags & IORESOURCE_MUXED))
> +				pr_err("Resource conflict between muxed \"%s\" and non-muxed \"%s\" I/O regions!\n",
> +					res->name, conflict->name);
>  			add_wait_queue(&muxed_resource_wait, &wait);
>  			write_unlock(&resource_lock);
>  			set_current_state(TASK_UNINTERRUPTIBLE);
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
