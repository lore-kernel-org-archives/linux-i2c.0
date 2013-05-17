From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 9/9] I2C: mv64xxx: fix race between FSM/interrupt and
 process context
Date: Fri, 17 May 2013 11:51:51 +0200
Message-ID: <20130517095149.GI17056@katana>
References: <20130516202921.GW18614@n2100.arm.linux.org.uk>
 <E1Ud4xE-0004KB-2T@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E1Ud4xE-0004KB-2T-eh5Bv4kxaXIANfyc6IWni62ZND6+EDdj@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Mark A. Greer" <mgreer-luAo+O/VEmrlveNOaEYElw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


> @@ -271,12 +273,25 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
>  {
>  	switch(drv_data->action) {
>  	case MV64XXX_I2C_ACTION_SEND_RESTART:
> +		/* We should only get here if we have further messages */
> +		BUG_ON(drv_data->num_msgs == 0);
> +

...

> @@ -453,16 +463,20 @@ static int
>  mv64xxx_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>  {
>  	struct mv64xxx_i2c_data *drv_data = i2c_get_adapdata(adap);
> -	int	i, rc;
> +	int rc, ret = num;
>  
> -	for (i = 0; i < num; i++) {
> -		rc = mv64xxx_i2c_execute_msg(drv_data, &msgs[i],
> -						i == 0, i + 1 == num);
> -		if (rc < 0)
> -			return rc;
> -	}
> +	BUG_ON(drv_data->msgs != NULL);

Can't we handle this more gracefully than to halt the kernel? Like
WARN_ON and resetting the controller or disabling the bus or...
