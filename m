From: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>
Subject: Re: [PATCH 1/2] mfd: dln2: fix _dln2_transfer return code
Date: Tue, 11 Nov 2014 17:18:18 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1411111717270.2047@localhost6.localdomain6>
References: <1415708457-18798-1-git-send-email-octavian.purdila@intel.com> <1415708457-18798-2-git-send-email-octavian.purdila@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1415708457-18798-2-git-send-email-octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 11 Nov 2014, Octavian Purdila wrote:

> If wait_for_completion_interruptible_timeout returns a positive value
> it may be propagated as the return value of _dln2_transfer. This
> contradicts the documentation of the function and exposes unnecessary
> internals to the callers.
> 
> This patch makes sure to set the return value to 0 in that case.

I didn't keep around the code or the address of the git tree, but I wonder 
if this makes a later assignment of ret to 0 unnecessary?

julia

> Reported-by: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>
> Signed-off-by: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/mfd/dln2.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
> index 9765a17..f0747a1 100644
> --- a/drivers/mfd/dln2.c
> +++ b/drivers/mfd/dln2.c
> @@ -462,7 +462,8 @@ static int _dln2_transfer(struct dln2_dev *dln2, u16 handle, u16 cmd,
>  		if (!ret)
>  			ret = -ETIMEDOUT;
>  		goto out_free_rx_slot;
> -	}
> +	} else
> +		ret = 0;
>  
>  	if (dln2->disconnect) {
>  		ret = -ENODEV;
> -- 
> 1.9.1
> 
> 
