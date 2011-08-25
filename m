From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] staging/olpc_dcon: Remove obsolete cleanup for
 clientdata
Date: Thu, 25 Aug 2011 13:04:26 +0200
Message-ID: <20110825130426.08ee06e5@endymion.delvare>
References: <1314269628-18325-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1314269628-18325-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-i2c@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Andres Salomon <dilinger@queued.net>, Andrew Morton <akpm@linux-foundation.org>, Marek Belisko <marek.belisko@open-nandra.com>, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 25 Aug 2011 12:53:30 +0200, Wolfram Sang wrote:
> A few new i2c-drivers came into the kernel which clear the clientdata-pointer
> on exit or error. This is obsolete meanwhile, the core will do it.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Cc: Andres Salomon <dilinger@queued.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Marek Belisko <marek.belisko@open-nandra.com>
> Cc: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/staging/olpc_dcon/olpc_dcon.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/olpc_dcon/olpc_dcon.c b/drivers/staging/olpc_dcon/olpc_dcon.c
> index 750fe50..a235330 100644
> --- a/drivers/staging/olpc_dcon/olpc_dcon.c
> +++ b/drivers/staging/olpc_dcon/olpc_dcon.c
> @@ -712,7 +712,6 @@ static int dcon_probe(struct i2c_client *client, const struct i2c_device_id *id)
>   eirq:
>  	free_irq(DCON_IRQ, dcon);
>   einit:
> -	i2c_set_clientdata(client, NULL);
>  	kfree(dcon);
>  	return rc;
>  }
> @@ -721,8 +720,6 @@ static int dcon_remove(struct i2c_client *client)
>  {
>  	struct dcon_priv *dcon = i2c_get_clientdata(client);
>  
> -	i2c_set_clientdata(client, NULL);
> -
>  	fb_unregister_client(&dcon->fbevent_nb);
>  	unregister_reboot_notifier(&dcon->reboot_nb);
>  	atomic_notifier_chain_unregister(&panic_notifier_list, &dcon_panic_nb);

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare
