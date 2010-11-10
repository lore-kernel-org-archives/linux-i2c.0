From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: Remove obsolete cleanup for clientdata
Date: Wed, 10 Nov 2010 14:24:11 +0100
Message-ID: <20101110142411.6badf9d9@endymion.delvare>
References: <1289392100-32668-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1289392100-32668-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mauro Carvalho Chehab <mchehab-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, Janusz Krzysztofik <jkrzyszt-NCk8gXQAEuFz6jiHbVrK7g@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Hong Liu <hong.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Anantha Narayanan <anantha.narayanan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andres Salomon <dilinger-pFFUokh25LWsTnJN9+BGXg@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Wed, 10 Nov 2010 13:28:19 +0100, Wolfram Sang wrote:
> A few new i2c-drivers came into the kernel which clear the clientdata-pointer
> on exit. This is obsolete meanwhile, so fix it and hope the word will spread.

Thanks for actively tracking these.

> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
> 
> Like last time I suggest to collect acks from the driver authors and merge it
> vie Jean's i2c-tree.
> 
>  drivers/media/video/imx074.c          |    2 --
>  drivers/media/video/ov6650.c          |    2 --
>  drivers/misc/apds9802als.c            |    1 -
>  drivers/staging/olpc_dcon/olpc_dcon.c |    3 ---
>  4 files changed, 0 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/video/imx074.c b/drivers/media/video/imx074.c
> index 380e459..27b5dfd 100644
> --- a/drivers/media/video/imx074.c
> +++ b/drivers/media/video/imx074.c
> @@ -451,7 +451,6 @@ static int imx074_probe(struct i2c_client *client,
>  	ret = imx074_video_probe(icd, client);
>  	if (ret < 0) {
>  		icd->ops = NULL;
> -		i2c_set_clientdata(client, NULL);
>  		kfree(priv);
>  		return ret;
>  	}
> @@ -468,7 +467,6 @@ static int imx074_remove(struct i2c_client *client)
>  	icd->ops = NULL;
>  	if (icl->free_bus)
>  		icl->free_bus(icl);
> -	i2c_set_clientdata(client, NULL);
>  	client->driver = NULL;

This statement seems equally unneeded, maybe you could remove it too?

Unless you want to provide a separate patch for this, as there are 5
other drivers doing the same.

-- 
Jean Delvare
