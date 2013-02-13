From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH v1 4/4] i2c-mux: i2c_add_mux_adapter() should use -1 for
 auto bus num
Date: Wed, 13 Feb 2013 12:34:29 -0800
Message-ID: <20130213203429.GA12948@roeck-us.net>
References: <1360778532-7480-1-git-send-email-dianders@chromium.org>
 <1360778532-7480-4-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1360778532-7480-4-git-send-email-dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Yuvaraj Kumar <yuvaraj.cd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Girish Shivananjappa <girish.shivananjappa-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, bhushan.r-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sreekumar.c-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Prashanth G <prashanth.g-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Barry Song <baohua.song-kQvG35nSl+M@public.gmane.org>, Guan Xuetao <gxt-TG0Ac1+ktVc@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Feb 13, 2013 at 10:02:12AM -0800, Doug Anderson wrote:
> The force_nr parameter to i2c_add_mux_adapter() uses 0 to signify that
> we don't want to force the bus number of the adapter.  This is
> non-ideal because:
> * 0 is actually a valid bus number to request
> * i2c_add_numbered_adapter() (which i2c_add_mux_adapter() calls) uses
>   -1 to mean the same thing.  That means extra logic in
>   i2c_add_mux_adapter().
> 
> Fix i2c_add_mux_adapter() to use -1 and update all mux drivers
> accordingly.
> 
> Signed-off-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
> Notes:
> - If there's a good reason that force_nr uses 0 for auto then feel
>   free to drop this patch.  I've place it at the end of the series to
>   make it easy to just drop it.
> 
>  drivers/i2c/i2c-mux.c               | 10 +++-------
>  drivers/i2c/muxes/i2c-arbitrator.c  |  2 +-
>  drivers/i2c/muxes/i2c-mux-gpio.c    |  2 +-
>  drivers/i2c/muxes/i2c-mux-pca9541.c |  2 +-
>  drivers/i2c/muxes/i2c-mux-pca954x.c |  2 +-
>  drivers/i2c/muxes/i2c-mux-pinctrl.c |  4 ++--
>  include/linux/i2c-mux.h             |  2 +-
>  7 files changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
> index d94e0ce..8ad1a56 100644
> --- a/drivers/i2c/i2c-mux.c
> +++ b/drivers/i2c/i2c-mux.c
> @@ -103,7 +103,7 @@ static unsigned int i2c_mux_parent_classes(struct i2c_adapter *parent)
>  
>  struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
>  				struct device *mux_dev,
> -				void *mux_priv, u32 force_nr, u32 chan_id,
> +				void *mux_priv, int force_nr, u32 chan_id,
>  				unsigned int class,
>  				int (*select) (struct i2c_adapter *,
>  					       void *, u32),
> @@ -168,12 +168,8 @@ struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
>  		}
>  	}
>  
> -	if (force_nr) {
> -		priv->adap.nr = force_nr;
> -		ret = i2c_add_numbered_adapter(&priv->adap);
> -	} else {
> -		ret = i2c_add_adapter(&priv->adap);
> -	}
> +	priv->adap.nr = force_nr;
> +	ret = i2c_add_numbered_adapter(&priv->adap);
>  	if (ret < 0) {
>  		dev_err(&parent->dev,
>  			"failed to add mux-adapter (error=%d)\n",
> diff --git a/drivers/i2c/muxes/i2c-arbitrator.c b/drivers/i2c/muxes/i2c-arbitrator.c
> index c3bbdf7..89d0d06 100644
> --- a/drivers/i2c/muxes/i2c-arbitrator.c
> +++ b/drivers/i2c/muxes/i2c-arbitrator.c
> @@ -173,7 +173,7 @@ static int i2c_arbitrator_probe(struct platform_device *pdev)
>  		arb->wait_free_us = 50000;
>  
>  	/* Actually add the mux adapter */
> -	arb->child = i2c_add_mux_adapter(arb->parent, &pdev->dev, arb, 0, 0, 0,
> +	arb->child = i2c_add_mux_adapter(arb->parent, &pdev->dev, arb, -1, 0, 0,
>  					 i2c_arbitrator_select,
>  					 i2c_arbitrator_deselect);
>  	if (WARN_ON(!arb->child)) {
> diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
> index 9f50ef0..301ed0b 100644
> --- a/drivers/i2c/muxes/i2c-mux-gpio.c
> +++ b/drivers/i2c/muxes/i2c-mux-gpio.c
> @@ -208,7 +208,7 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
>  	}
>  
>  	for (i = 0; i < mux->data.n_values; i++) {
> -		u32 nr = mux->data.base_nr ? (mux->data.base_nr + i) : 0;
> +		int nr = mux->data.base_nr ? (mux->data.base_nr + i) : -1;
>  		unsigned int class = mux->data.classes ? mux->data.classes[i] : 0;
>  
>  		mux->adap[i] = i2c_add_mux_adapter(parent, &pdev->dev, mux, nr,
> diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
> index f3b8f9a..a58b3c2 100644
> --- a/drivers/i2c/muxes/i2c-mux-pca9541.c
> +++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
> @@ -350,7 +350,7 @@ static int pca9541_probe(struct i2c_client *client,
>  
>  	/* Create mux adapter */
>  
> -	force = 0;
> +	force = -1;
>  	if (pdata)
>  		force = pdata->modes[0].adap_id;
>  	data->mux_adap = i2c_add_mux_adapter(adap, &client->dev, client,
> diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
> index 8e43872..4663ce6 100644
> --- a/drivers/i2c/muxes/i2c-mux-pca954x.c
> +++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
> @@ -215,7 +215,7 @@ static int pca954x_probe(struct i2c_client *client,
>  
>  	/* Now create an adapter for each channel */
>  	for (num = 0; num < chips[data->type].nchans; num++) {
> -		force = 0;			  /* dynamic adap number */
> +		force = -1;			  /* dynamic adap number */
>  		class = 0;			  /* no class by default */
>  		if (pdata) {
>  			if (num < pdata->num_modes) {
> diff --git a/drivers/i2c/muxes/i2c-mux-pinctrl.c b/drivers/i2c/muxes/i2c-mux-pinctrl.c
> index a43c0ce..401ff5d 100644
> --- a/drivers/i2c/muxes/i2c-mux-pinctrl.c
> +++ b/drivers/i2c/muxes/i2c-mux-pinctrl.c
> @@ -217,8 +217,8 @@ static int i2c_mux_pinctrl_probe(struct platform_device *pdev)
>  	}
>  
>  	for (i = 0; i < mux->pdata->bus_count; i++) {
> -		u32 bus = mux->pdata->base_bus_num ?
> -				(mux->pdata->base_bus_num + i) : 0;
> +		int bus = mux->pdata->base_bus_num ?
> +				(mux->pdata->base_bus_num + i) : -1;

Maybe this should be:
		int bus = mux->pdata->base_bus_num >= 0 ?
				(mux->pdata->base_bus_num + i) : -1;

Otherwise you still can not assign bus number 0 as 1st bus. Also, if base_bus_num
ends up being provided as -1, the result would be pretty much unpredictable.

Thanks,
Guenter
