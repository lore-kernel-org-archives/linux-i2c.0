From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] misc: Remove obsolete cleanup for clientdata
Date: Tue, 30 Aug 2011 14:51:17 +0200
Message-ID: <20110830145117.4bc67f02@endymion.delvare>
References: <1314269645-18607-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1314269645-18607-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Minkyu Kang <mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Donggeun Kim <dg77.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 25 Aug 2011 12:54:04 +0200, Wolfram Sang wrote:
> A few new i2c-drivers came into the kernel which clear the clientdata-pointer
> on exit or error. This is obsolete meanwhile, the core will do it.
> 
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
> Cc: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Cc: Minkyu Kang <mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Cc: Donggeun Kim <dg77.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/misc/fsa9480.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/fsa9480.c b/drivers/misc/fsa9480.c
> index 5325a7e..22e22ad 100644
> --- a/drivers/misc/fsa9480.c
> +++ b/drivers/misc/fsa9480.c
> @@ -457,7 +457,6 @@ fail2:
>  	if (client->irq)
>  		free_irq(client->irq, NULL);
>  fail1:
> -	i2c_set_clientdata(client, NULL);
>  	kfree(usbsw);
>  	return ret;
>  }
> @@ -467,7 +466,6 @@ static int __devexit fsa9480_remove(struct i2c_client *client)
>  	struct fsa9480_usbsw *usbsw = i2c_get_clientdata(client);
>  	if (client->irq)
>  		free_irq(client->irq, NULL);
> -	i2c_set_clientdata(client, NULL);
>  
>  	sysfs_remove_group(&client->dev.kobj, &fsa9480_group);
>  	device_init_wakeup(&client->dev, 0);

You'll have to refresh this one, as the context was changed by
b89d5f17d4b02ae9f3a691c2cb260e1929c6261b.

-- 
Jean Delvare
