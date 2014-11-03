From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH] i2c: mux: create proper topology in sysfs
Date: Mon, 3 Nov 2014 12:39:51 -0800
Message-ID: <20141103203951.GA18530@roeck-us.net>
References: <1414960809-16860-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1414960809-16860-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Jeroen De Wachter <jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, Nov 02, 2014 at 09:40:09PM +0100, Wolfram Sang wrote:
> The current implementation creates muxed i2c-<n> busses as immediate
> children of their i2c-<n> parent bus. In case of multiple muxes on one
> bus, it is impossible to determine which muxed bus comes from which mux.
> 
> Change the topology so that they are created under the corresponding mux
> device. This way, multiple muxes on the same segment can coexist and
> children busses are grouped accordingly.
> 
> So for instance, by adding a pca9547 device with address 0x70 to
> bus i2c-0, instead of:
> 
> /sys/class/i2c-dev/i2c-0/device/i2c-1
> ...
> /sys/class/i2c-dev/i2c-0/device/i2c-8
> 
> we get:
> 
> /sys/class/i2c-dev/i2c-0/device/0-0070/i2c-1
> ...
> /sys/class/i2c-dev/i2c-0/device/0-0070/i2c-8
> 
> Symlinks for backward compatibility are provided.
> 
> Signed-off-by: Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
> 
> [wsa: Ported to top-of-tree (1 line left :)) and added the compatibility
> links.]
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Cc: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
> Cc: Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>
> Cc: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
> Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
> Cc: Jeroen De Wachter <jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>
> ---
> 
> So, this is what I came up with to fix the mux-topology problem. Since I don't
> really use muxes, please review/comment/test. And give Acks/Tested-by tags if
> this works for you.
> 
>  drivers/i2c/i2c-mux.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
> index 2d0847b6be62..5b482ea32faf 100644
> --- a/drivers/i2c/i2c-mux.c
> +++ b/drivers/i2c/i2c-mux.c
> @@ -138,7 +138,7 @@ struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
>  	priv->adap.owner = THIS_MODULE;
>  	priv->adap.algo = &priv->algo;
>  	priv->adap.algo_data = priv;
> -	priv->adap.dev.parent = &parent->dev;
> +	priv->adap.dev.parent = mux_dev;

Not sure if the reason is that i2c mux adapters assume that the parent 
device is the i2c adapter, but the code crashes all over the place for me
after applying this patch. I'll try to track it down.

Guenter
