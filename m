From: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-mv64xxx: Add I2C Transaction Generator support
Date: Fri, 7 Jun 2013 18:21:57 +0200
Message-ID: <20130607182157.34188f72@skate>
References: <1370619743-15245-1-git-send-email-gregory.clement@free-electrons.com>
	<1370619743-15245-2-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1370619743-15245-2-git-send-email-gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Maen Suleiman <maen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Eran Ben-Avi <benavi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yehuda Yitschak <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ike Pan <ike.pan-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Chris Van Hoof <vanhoof-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Dan Frazier <dann.frazier-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Leif Lindholm <leif.lindholm-5wv7dgnIgG8@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Marlin <dmarlin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Zbigniew Bodek <zbb-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, Piotr Ziecik <kosmo-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Gregory CLEMENT,

On Fri,  7 Jun 2013 17:42:22 +0200, Gregory CLEMENT wrote:

>  /* Driver states */
>  enum {
>  	MV64XXX_I2C_STATE_INVALID,
> @@ -110,6 +133,7 @@ struct mv64xxx_i2c_data {
>  	spinlock_t		lock;
>  	struct i2c_msg		*msg;
>  	struct i2c_adapter	adapter;
> +	int			bridge_enabled;

bool ?

> @@ -528,6 +652,7 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
>  {
>  	u32 bus_freq, tclk;
>  	int rc = 0;
> +	const char *bridge_status;
>  
>  	/* CLK is mandatory when using DT to describe the i2c bus. We
>  	 * need to know tclk in order to calculate bus clock
> @@ -554,6 +679,15 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
>  	 * So hard code the value to 1 second.
>  	 */
>  	drv_data->adapter.timeout = HZ;
> +
> +	/*
> +	 * Acquire information on Transaction Generator support.
> +	 */
> +	bridge_status = of_get_property(np, "", NULL);

It is not clear to me what this new bridge_status local variable is
doing.

> +	if (of_property_read_bool(np, "i2c,i2c-bridge"))
> +		drv_data->bridge_enabled = 1;
> +	else
> +		drv_data->bridge_enabled = 0;

This could be written directly as:

	drv_data->bridge_enabled = of_property_read_bool(np, "i2c,i2c-bridge");

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
