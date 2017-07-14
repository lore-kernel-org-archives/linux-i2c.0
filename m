From: Boszormenyi Zoltan <zboszor-v1d7l9VOqKc@public.gmane.org>
Subject: Re: [PATCH 1/5 v2] Extend the request_region() infrastructure
Date: Fri, 14 Jul 2017 10:33:47 +0200
Message-ID: <f8e2e529-c07b-baa8-27bd-de1b5b553b8f@pr.hu>
References: <20170621035349.4125-1-zboszor@pr.hu>
 <20170622132134.7200-1-zboszor@pr.hu> <20170622132134.7200-2-zboszor@pr.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170622132134.7200-2-zboszor-v1d7l9VOqKc@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Menzel <paulepanter-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Christian Fetzer <fetzer.ch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Nehal Shah <nehal-bakulchandra.shah-5C7GfCeVMHo@public.gmane.org>, Tim Small <tim-v0yPK6tSSg/10XsdtD+oqA@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, kernel-i2qG/+7/Q79eoWH0uzbU5w@public.gmane.org, wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org, jlayton-vpEMnDpepFuMZCB2o+C8xQ@public.gmane.org, marc.2377-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, cshorler-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, regressions-rCxcAJFjeRkk+I/owrrOrA@public.gmane.org, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Toshi Kani <toshi.kani-ZPxbGqLxI0U@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jakub Sitnicki <jsitnicki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Vive
List-Id: linux-i2c@vger.kernel.org

2017-06-22 15:21 keltezéssel, Zoltán Böszörményi írta:
> Add a new IORESOURCE_ALLOCATED flag that is automatically used
> when alloc_resource() is used internally in kernel/resource.c
> and free_resource() now takes this flag into account.
> 
> The core of __request_region() was factored out into a new function
> called __request_declared_region() that needs struct resource *
> instead of the (start, n, name) triplet.
> 
> These changes allow using statically declared struct resource
> data coupled with the pre-existing DEFINE_RES_IO_NAMED() static
> initializer macro. The new macro exploiting
> __request_declared_region() is request_declared_muxed_region()
> 
> v2:
> 
> Fixed checkpatch.pl warnings and errors and extended the macro
> API with request_declared_region() and release_declared_region()
> 
> Reversed the order of __request_declared_region and __request_region
> 
> Added high level description of the muxed and declared variants
> of the macros.
> 
> Signed-off-by: Zoltán Böszörményi <zboszor-v1d7l9VOqKc@public.gmane.org>
> ---
>   include/linux/ioport.h | 14 ++++++++++++++
>   kernel/resource.c      | 40 +++++++++++++++++++++++++++++++++++++---
>   2 files changed, 51 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 6230064..6ebcd39 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -52,6 +52,7 @@ struct resource {
>   #define IORESOURCE_MEM_64	0x00100000
>   #define IORESOURCE_WINDOW	0x00200000	/* forwarded by bridge */
>   #define IORESOURCE_MUXED	0x00400000	/* Resource is software muxed */
> +#define IORESOURCE_ALLOCATED	0x00800000	/* Resource was allocated */
>   
>   #define IORESOURCE_EXT_TYPE_BITS 0x01000000	/* Resource extended types */
>   #define IORESOURCE_SYSRAM	0x01000000	/* System RAM (modifier) */
> @@ -215,7 +216,14 @@ static inline bool resource_contains(struct resource *r1, struct resource *r2)
>   
>   /* Convenience shorthand with allocation */
>   #define request_region(start,n,name)		__request_region(&ioport_resource, (start), (n), (name), 0)
> +#define request_declared_region(res)		__request_region( \
> +							&ioport_resource, \
> +							(res), 0)
>   #define request_muxed_region(start,n,name)	__request_region(&ioport_resource, (start), (n), (name), IORESOURCE_MUXED)
> +#define request_declared_muxed_region(res)	__request_declared_region( \
> +							&ioport_resource, \
> +							(res), \
> +							IORESOURCE_MUXED)
>   #define __request_mem_region(start,n,name, excl) __request_region(&iomem_resource, (start), (n), (name), excl)
>   #define request_mem_region(start,n,name) __request_region(&iomem_resource, (start), (n), (name), 0)
>   #define request_mem_region_exclusive(start,n,name) \
> @@ -227,8 +235,14 @@ extern struct resource * __request_region(struct resource *,
>   					resource_size_t n,
>   					const char *name, int flags);
>   
> +extern struct resource *__request_declared_region(struct resource *parent,
> +					struct resource *res, int flags);
> +
>   /* Compatibility cruft */
>   #define release_region(start,n)	__release_region(&ioport_resource, (start), (n))
> +#define release_declared_region(res)	__release_region(&ioport_resource, \
> +						(res)->start, \
> +						(res)->end - (res)->start + 1)
>   #define release_mem_region(start,n)	__release_region(&iomem_resource, (start), (n))
>   
>   extern void __release_region(struct resource *, resource_size_t,
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 9b5f044..2be7029 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -184,6 +184,9 @@ static void free_resource(struct resource *res)
>   	if (!res)
>   		return;
>   
> +	if (!(res->flags & IORESOURCE_ALLOCATED))
> +		return;
> +
>   	if (!PageSlab(virt_to_head_page(res))) {
>   		spin_lock(&bootmem_resource_lock);
>   		res->sibling = bootmem_resource_free;
> @@ -210,6 +213,8 @@ static struct resource *alloc_resource(gfp_t flags)
>   	else
>   		res = kzalloc(sizeof(struct resource), flags);
>   
> +	res->flags = IORESOURCE_ALLOCATED;
> +
>   	return res;
>   }
>   
> @@ -1110,8 +1115,19 @@ resource_size_t resource_alignment(struct resource *res)
>    * the IO flag meanings (busy etc).
>    *
>    * request_region creates a new busy region.
> + * The resource descriptor is allocated by this function.
> + *
> + * request_declared_region creates a new busy region
> + * described in an existing resource descriptor.
> + *
> + * request_muxed_region creates a new shared busy region.
> + * The resource descriptor is allocated by this function.
> + *
> + * request_declared_muxed_region creates a new shared busy region
> + * described in an existing resource descriptor.
>    *
>    * release_region releases a matching busy region.
> + * The region is only freed if it was allocated.
>    */
>   
>   static DECLARE_WAIT_QUEUE_HEAD(muxed_resource_wait);
> @@ -1128,7 +1144,6 @@ struct resource * __request_region(struct resource *parent,
>   				   resource_size_t start, resource_size_t n,
>   				   const char *name, int flags)
>   {
> -	DECLARE_WAITQUEUE(wait, current);
>   	struct resource *res = alloc_resource(GFP_KERNEL);
>   
>   	if (!res)
> @@ -1138,6 +1153,26 @@ struct resource * __request_region(struct resource *parent,
>   	res->start = start;
>   	res->end = start + n - 1;
>   
> +	if (!__request_declared_region(parent, res, flags)) {
> +		free_resource(res);
> +		res = NULL;
> +	}
> +
> +	return res;
> +}
> +EXPORT_SYMBOL(__request_region);
> +
> +/**
> + * __request_declared_region - create a new busy resource region
> + * @parent: parent resource descriptor
> + * @res: child resource descriptor
> + * @flags: IO resource flags
> + */
> +struct resource *__request_declared_region(struct resource *parent,
> +				   struct resource *res, int flags)
> +{
> +	DECLARE_WAITQUEUE(wait, current);
> +
>   	write_lock(&resource_lock);
>   
>   	for (;;) {
> @@ -1166,14 +1201,13 @@ struct resource * __request_region(struct resource *parent,
>   			continue;
>   		}
>   		/* Uhhuh, that didn't work out.. */
> -		free_resource(res);
>   		res = NULL;
>   		break;
>   	}
>   	write_unlock(&resource_lock);
>   	return res;
>   }
> -EXPORT_SYMBOL(__request_region);
> +EXPORT_SYMBOL(__request_declared_region);
>   
>   /**
>    * __release_region - release a previously reserved resource region
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
