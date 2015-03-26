From: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-mux-gpio: Change log level to debug for probe
 deferrals
Date: Thu, 26 Mar 2015 10:09:51 +0100
Message-ID: <5513CCDF.4090301@nokia.com>
References: <20150325174351.GB5209@ulegcpding.emea.nsn-net.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150325174351.GB5209-w/hiR2Wfoz+b6vRP15A4uhaOaYmgohGe0e7PPNI6Mm0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ioan Nicu <ioan.nicu.ext-OYasijW0DpE@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mathias Rulf <mathias.rulf-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 25/03/15 18:43, Ioan Nicu wrote:
> Probe deferral is not an error case. It happens only when
> the necessary dependencies are not there yet.
> 
> The driver core is already printing a message when a driver
> requests probe deferral, so this can be traced in the logs
> without these error prints.
> 
> This patch changes the error messages from these deferral cases
> to debug messages.
> 
> Signed-off-by: Ionut Nicu <ioan.nicu.ext-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

Acked-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

> ---
>  drivers/i2c/muxes/i2c-mux-gpio.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
> index f5798eb..9f1cfca 100644
> --- a/drivers/i2c/muxes/i2c-mux-gpio.c
> +++ b/drivers/i2c/muxes/i2c-mux-gpio.c
> @@ -77,7 +77,7 @@ static int i2c_mux_gpio_probe_dt(struct gpiomux *mux,
>         }
>         adapter = of_find_i2c_adapter_by_node(adapter_np);
>         if (!adapter) {
> -               dev_err(&pdev->dev, "Cannot find parent bus\n");
> +               dev_dbg(&pdev->dev, "Cannot find parent bus\n");
>                 return -EPROBE_DEFER;
>         }
>         mux->data.parent = i2c_adapter_id(adapter);
> @@ -178,7 +178,7 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
>  
>         parent = i2c_get_adapter(mux->data.parent);
>         if (!parent) {
> -               dev_err(&pdev->dev, "Parent adapter (%d) not found\n",
> +               dev_dbg(&pdev->dev, "Parent adapter (%d) not found\n",
>                         mux->data.parent);
>                 return -EPROBE_DEFER;
>         }

-- 
Best regards,
Alexander Sverdlin.
