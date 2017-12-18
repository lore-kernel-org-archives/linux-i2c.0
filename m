From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH 2/5 v3] Modify behaviour of request_*muxed_region()
Date: Mon, 18 Dec 2017 11:07:41 -0800
Message-ID: <20171218190741.GB6424@roeck-us.net>
References: <20171218084841.9979-1-zboszor@pr.hu>
 <20171218084841.9979-2-zboszor@pr.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171218084841.9979-2-zboszor-v1d7l9VOqKc@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zoltan Boszormenyi <zboszor-v1d7l9VOqKc@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Menzel <paulepanter-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Christian Fetzer <fetzer.ch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Nehal Shah <nehal-bakulchandra.shah-5C7GfCeVMHo@public.gmane.org>, Tim Small <tim-v0yPK6tSSg/10XsdtD+oqA@public.gmane.org>, kernel-i2qG/+7/Q79eoWH0uzbU5w@public.gmane.org, wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org, jlayton-vpEMnDpepFuMZCB2o+C8xQ@public.gmane.org, marc.2377-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, cshorler-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, regressions-rCxcAJFjeRkk+I/owrrOrA@public.gmane.org, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, lyude-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Toshi Kani <toshi.kani-ZPxbGqLxI0U@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jakub Sitnicki <jsitnicki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Dec 18, 2017 at 09:48:38AM +0100, Zoltan Boszormenyi wrote:
> From: Böszörményi Zoltán <zboszor-v1d7l9VOqKc@public.gmane.org>
> 
> In order to make request_*muxed_region() behave more like
> mutex_lock(), a possible failure case needs to be eliminated.
> When drivers do not properly share the same I/O region, e.g.
> one is using request_region() and the other is using
> request_muxed_region(), the kernel didn't warn the user about it.
> This change modifies IORESOURCE_MUXED behaviour so it always
> goes to sleep waiting for the resuorce to be freed and the

resource

> inconsistent resource flag usage is logged with KERN_ERR.
> 
> v2: Fixed checkpatch.pl warnings and extended the comment
>     about request_declared_muxed_region.
> 
> v3: Rebased for 4.15-rc4
> 
> Signed-off-by: Zoltán Böszörményi <zboszor-v1d7l9VOqKc@public.gmane.org>
> ---
>  kernel/resource.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 05db9c4e3992..0f26f887ac33 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -1143,6 +1143,7 @@ resource_size_t resource_alignment(struct resource *res)
>   *
>   * request_declared_muxed_region creates a new shared busy region
>   * described in an existing resource descriptor.
> + * It only returns if it succeeded.
>   *
>   * release_region releases a matching busy region.
>   * The region is only freed if it was allocated.
> @@ -1209,7 +1210,10 @@ struct resource *__request_declared_region(struct resource *parent,
>  				continue;
>  			}
>  		}
> -		if (conflict->flags & flags & IORESOURCE_MUXED) {
> +		if (flags & IORESOURCE_MUXED) {
> +			if (!(conflict->flags & IORESOURCE_MUXED))
> +				pr_err("Resource conflict between muxed \"%s\" and non-muxed \"%s\" I/O regions!\n",
> +					res->name, conflict->name);

With this, the muxed resource requestor will hang since the non-muxed
requestor will not release the resource. I understand that you are trying
to get rid of the error return, but is replacing it with a hang really
better ?

>  			add_wait_queue(&muxed_resource_wait, &wait);
>  			write_unlock(&resource_lock);
>  			set_current_state(TASK_UNINTERRUPTIBLE);
> -- 
> 2.13.6
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
