From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [RFC] i2c: mux: add mux device to the adapter name
Date: Wed, 5 Nov 2014 10:38:34 -0800
Message-ID: <20141105183834.GB22304@roeck-us.net>
References: <1415048456-13456-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415048456-13456-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Jeroen De Wachter <jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Nov 03, 2014 at 10:00:56PM +0100, Wolfram Sang wrote:
> If there are multiple muxes on one bus, then specifying the channel only
> is not sufficient for a distinguishable name. We need the actual device,
> too.
> 
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Cc: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
> Cc: Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>
> Cc: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
> Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
> Cc: Jeroen De Wachter <jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>
> ---
> 
> This is probably the least "ABI" breaking solution? RFC for now...
> 
>  drivers/i2c/i2c-mux.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
> index 5b482ea32faf..26aa84902ada 100644
> --- a/drivers/i2c/i2c-mux.c
> +++ b/drivers/i2c/i2c-mux.c
> @@ -134,7 +134,8 @@ struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
>  
>  	/* Now fill out new adapter structure */
>  	snprintf(priv->adap.name, sizeof(priv->adap.name),
> -		 "i2c-%d-mux (chan_id %d)", i2c_adapter_id(parent), chan_id);
> +		 "i2c-%d-mux (chan_id %d) (mux_device %s)",
> +		 i2c_adapter_id(parent), chan_id, dev_name(mux_dev));

This yields pretty long names, longer than the maximum supported length,
if the mux is not an i2c adapter (eg i2c-mux-pinctrl).

i2c-17-mux (chan_id 5) (mux_device i2c-mux-pinctrl)

has 52 characters, and the maximum name length is 48.
Maybe just use "mux" instead of "mux_adapter" ?

The result still fails for me because the application code doesn't expect
to see "(mux...)", but I guess there will always be some problem :-(.

I still need to figure out what causes the failure with the other patch.

Guenter

>  	priv->adap.owner = THIS_MODULE;
>  	priv->adap.algo = &priv->algo;
>  	priv->adap.algo_data = priv;
> -- 
> 2.1.1
> 
