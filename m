From: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 5/8] i2c: mux: add support for 'i2c-mux', 'i2c-arb' and
 'i2c-gate' DT subnodes
Date: Mon, 15 Aug 2016 16:55:13 +0300
Message-ID: <53bd470f-4243-c7fe-485a-3d8ec7cc034d@mentor.com>
References: <1471268431-5148-1-git-send-email-peda@axentia.se>
 <1471268431-5148-6-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1471268431-5148-6-git-send-email-peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Crestez Dan Leonard <leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Peter,

On 08/15/2016 04:40 PM, Peter Rosin wrote:
> Backwards compatibility is preserved; the subnodes are in practice
> optional.
>
> However, the mux core needs to know what subnode it should examine, so add
> a couple of new flags for i2c_mux_alloc for this purpose.
>
> The rule is that if the mux core finds a 'reg' property in the appropriate
> subnode, e.g. if 'reg' exists in the 'i2c-mux' subnode, then the mux core
> will assume that this is an old style entry and not an i2c-mux subnode
> (correspondingly for arbitrators and gates with 'i2c-arb' and 'i2c-gate').
>
> Signed-off-by: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
> ---
>  drivers/i2c/i2c-mux.c   | 44 ++++++++++++++++++++++++++++++++++++--------
>  include/linux/i2c-mux.h |  8 ++++++--
>  2 files changed, 42 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
> index 8eee98634cda..c1ae719d1a7a 100644
> --- a/drivers/i2c/i2c-mux.c
> +++ b/drivers/i2c/i2c-mux.c
> @@ -255,6 +255,10 @@ struct i2c_mux_core *i2c_mux_alloc(struct i2c_adapter *parent,
>  	muxc->dev = dev;
>  	if (flags & I2C_MUX_LOCKED)
>  		muxc->mux_locked = true;
> +	if (flags & I2C_MUX_ARBITRATOR)
> +		muxc->arbitrator = true;
> +	if (flags & I2C_MUX_GATE)
> +		muxc->gate = true;
>  	muxc->select = select;
>  	muxc->deselect = deselect;
>  	muxc->max_adapters = max_adapters;
> @@ -335,18 +339,42 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
>  	 * nothing if !CONFIG_OF.
>  	 */
>  	if (muxc->dev->of_node) {
> -		struct device_node *child;
> +		struct device_node *dev_node = muxc->dev->of_node;
> +		struct device_node *mux_node, *child = NULL;
>  		u32 reg;
>
> -		for_each_child_of_node(muxc->dev->of_node, child) {
> -			ret = of_property_read_u32(child, "reg", &reg);
> -			if (ret)
> -				continue;
> -			if (chan_id == reg) {
> -				priv->adap.dev.of_node = child;
> -				break;

missing of_node_put(child);

Also adding an empty line would be perfect.

> +		if (muxc->arbitrator)
> +			mux_node = of_get_child_by_name(dev_node, "i2c-arb");
> +		else if (muxc->gate)
> +			mux_node = of_get_child_by_name(dev_node, "i2c-gate");
> +		else
> +			mux_node = of_get_child_by_name(dev_node, "i2c-mux");
> +
> +		if (mux_node) {
> +			/* A "reg" property indicates an old-style DT entry */
> +			if (!of_property_read_u32(mux_node, "reg", &reg)) {
> +				of_node_put(mux_node);
> +				mux_node = NULL;
> +			}
> +		}
> +
> +		if (!mux_node)
> +			mux_node = of_node_get(dev_node);
> +		else if (muxc->arbitrator || muxc->gate)
> +			child = of_node_get(mux_node);
> +
> +		if (!child) {
> +			for_each_child_of_node(mux_node, child) {
> +				ret = of_property_read_u32(child, "reg", &reg);
> +				if (ret)
> +					continue;
> +				if (chan_id == reg)
> +					break;

missing of_node_put(child);

>  			}
>  		}
> +
> +		priv->adap.dev.of_node = child;
> +		of_node_put(mux_node);
>  	}
>
>  	/*
> diff --git a/include/linux/i2c-mux.h b/include/linux/i2c-mux.h
> index d4c1d12f900d..bd74d5706f3b 100644
> --- a/include/linux/i2c-mux.h
> +++ b/include/linux/i2c-mux.h
> @@ -32,7 +32,9 @@
>  struct i2c_mux_core {
>  	struct i2c_adapter *parent;
>  	struct device *dev;
> -	bool mux_locked;
> +	unsigned int mux_locked:1;
> +	unsigned int arbitrator:1;
> +	unsigned int gate:1;
>
>  	void *priv;
>
> @@ -51,7 +53,9 @@ struct i2c_mux_core *i2c_mux_alloc(struct i2c_adapter *parent,
>  				   int (*deselect)(struct i2c_mux_core *, u32));
>
>  /* flags for i2c_mux_alloc */
> -#define I2C_MUX_LOCKED BIT(0)
> +#define I2C_MUX_LOCKED     BIT(0)
> +#define I2C_MUX_ARBITRATOR BIT(1)
> +#define I2C_MUX_GATE       BIT(2)
>
>  static inline void *i2c_mux_priv(struct i2c_mux_core *muxc)
>  {
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
