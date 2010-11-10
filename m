From: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] i2c: Remove obsolete cleanup for clientdata
Date: Wed, 10 Nov 2010 12:10:37 +0000
Message-ID: <20101110121037.37c61df8@linux.intel.com>
References: <1289392100-32668-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1289392100-32668-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

> --- a/drivers/misc/apds9802als.c
> +++ b/drivers/misc/apds9802als.c
> @@ -251,7 +251,6 @@ static int apds9802als_probe(struct i2c_client
> *client, 
>  	return res;
>  als_error1:
> -	i2c_set_clientdata(client, NULL);
>  	kfree(data);
>  	return res;
>  }

Acked-by: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

and noted for the future
