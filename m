From: Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/1] i2c: sun6i-p2wi: Remove duplicate inclusion of module.h
Date: Mon, 23 Jun 2014 14:08:45 +0200
Message-ID: <53A818CD.40205@free-electrons.com>
References: <1403522017-13861-1-git-send-email-sachin.kamat@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1403522017-13861-1-git-send-email-sachin.kamat-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sachin Kamat <sachin.kamat-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, spk.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.orgWolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


On 23/06/2014 13:13, Sachin Kamat wrote:
> module.h was included twice.
>
> Signed-off-by: Sachin Kamat <sachin.kamat-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>


> ---
>  drivers/i2c/busses/i2c-sun6i-p2wi.c |    1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-sun6i-p2wi.c b/drivers/i2c/busses/i2c-sun6i-p2wi.c
> index 09de4fd12d57..558fd24573b2 100644
> --- a/drivers/i2c/busses/i2c-sun6i-p2wi.c
> +++ b/drivers/i2c/busses/i2c-sun6i-p2wi.c
> @@ -26,7 +26,6 @@
>  #include <linux/i2c.h>
>  #include <linux/io.h>
>  #include <linux/interrupt.h>
> -#include <linux/module.h>

Oops, I guess this was introduced when I reordered inclusions in
alphabetic order.
I'd prefer the other inclusion to be removed instead, so that we could
keep it in alphabetic order.

Other than that you have my:

Acked-by: Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Thanks,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
