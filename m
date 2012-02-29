From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c/designware: Provide optional i2c bus recovery
 function
Date: Wed, 29 Feb 2012 17:22:43 +0530
Message-ID: <4F4E118B.2030403@nvidia.com>
References: <0ca1d8990c23a45193a32d0e7e889620b995af59.1330082915.git.viresh.kumar@st.com>	<351031347b845920a0ea78e7491d955137e3d7aa.1330082915.git.viresh.kumar@st.com>	<CAM=Q2cudYcSqAKk4qNg7MQxRBCkJ-XXXSL-Bg=sZ2+hvS_Qcxw@mail.gmail.com>	<4F4B3072.6050903@nvidia.com>	<CAM=Q2cs-nCuSmkBFtv4odbqoRJcPkXk4Rz-H=9S6RDG3Z8kcEQ@mail.gmail.com>	<4F4B569F.3080607@st.com>	<4F4B5A9A.4050303@st.com> <CAOh2x=nfNGpBmHVd1bPT9+AezDMEjaC4ktj4hX9=yWg2_k7r3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOh2x=nfNGpBmHVd1bPT9+AezDMEjaC4ktj4hX9=yWg2_k7r3Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: viresh kumar <viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>, Rajeev KUMAR <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>, Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Armando VISCONTI <armando.visconti-qxv4g6HH51o@public.gmane.org>, Shiraz HASHIM <shiraz.hashim-qxv4g6HH51o@public.gmane.org>, Vipin KUMAR <vipin.kumar-qxv4g6HH51o@public.gmane.org>, Deepak SIKRI <deepak.sikri-qxv4g6HH51o@public.gmane.org>, Vipul Kumar SAMAR <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>, Amit VIRDI <Amit.VIRDI-qxv4g6HH51o@public.gmane.org>, Pratyush ANAND <pratyush.anand-qxv4g6HH51o@public.gmane.org>, Bhupesh SHARMA <bhupesh.sharma-qxv4g6HH51o@public.gmane.org>, Bhavna YADAV <bhavna.yadav-qxv4g6HH51o@public.gmane.org>, Vincenzo FRASCINO <Vincenzo.FRASCINO-qxv4g6HH51o@public.gmane.org>, Mirko GARDI <mirko.gardi-qxv4g6HH51o@public.gmane.org>, Salvatore DE DOMINICIS <salvatore.dedominicis-qxv4g6HH51o@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tuesday 28 February 2012 06:53 PM, viresh kumar wrote:
>
> This patch also adds in generic bus recovery routines gpio or scl line based
> which can be used by bus controller. In addition controller driver may provide
> its own version of the bus recovery routine.
>
> Signed-off-by: Viresh Kumar<viresh.kumar-qxv4g6HH51o@public.gmane.org>
> ---
>   drivers/i2c/i2c-core.c |   56 ++++++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/i2c.h    |   22 ++++++++++++++++++
>   2 files changed, 78 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index e9c1893..c9f0daf 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -26,7 +26,9 @@
>
>   #include<linux/module.h>
>   #include<linux/kernel.h>
> +#include<linux/delay.h>
>   #include<linux/errno.h>
> +#include<linux/gpio.h>
>   #include<linux/slab.h>
>   #include<linux/i2c.h>
>   #include<linux/init.h>
> @@ -103,6 +105,47 @@ static int i2c_device_uevent(struct device *dev,
> struct kobj_uevent_env *env)
>   #define i2c_device_uevent	NULL
>   #endif	/* CONFIG_HOTPLUG */
>
> +/* i2c bus recovery routines */
> +static int i2c_gpio_recover_bus(struct i2c_adapter *adap)
> +{
> +	int tmp, val = 1;
> +	unsigned long delay = 1000000;
> +
> +	tmp = gpio_request_one(adap->scl_gpio, GPIOF_DIR_OUT |
> +			GPIOF_INIT_LOW, "i2c-bus-recover");

Should rename tmp to ret or status. tmp does not looks appropriate.

> +	if (tmp<  0) {
> +		dev_warn(&adap->dev, "gpio request one fail: %d\n",
> +				adap->scl_gpio);
> +		return tmp;
> +	}
> +
> +	delay /= adap->clock_rate * 2;
Here delay is turning as micor sec and function used as the nano sec.
> +
> +	for (tmp = 0; tmp<  adap->clock_cnt * 2; tmp++, val = !val) {
> +		ndelay(delay);
should be udelay()?
> +		gpio_set_value(adap->scl_gpio, val);

I think it should check for the sda line for coming out of the loop. 
There may be possibility that we may not need 9 clock pulses.

> +	}
> +
> +	gpio_free(adap->clock_cnt);
> +
> +	return 0;
> +}
> +
> +static int i2c_scl_recover_bus(struct i2c_adapter *adap)
> +{
> +	int i, val = 0;
> +	unsigned long delay = 1000000;
> +
> +	delay /= adap->clock_rate * 2;
> +
> +	for (i = 0; i<  adap->clock_cnt * 2; i++, val = !val) {
> +		adap->set_scl(adap, val);
> +		ndelay(delay);
udelay()??
> +	}
> +
> +	return 0;
> +}
> +
>   static int i2c_device_probe(struct device *dev)
>   {
>   	struct i2c_client	*client = i2c_verify_client(dev);
> @@ -861,6 +904,19 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
>   			 "Failed to create compatibility class link\n");
>   #endif
>
> +	/* bus recovery specific initialization */
> +	if (!adap->recover_bus) {
> +		if (!adap->clock_cnt || !adap->clock_rate)
> +			goto warn_no_recovery;
> +		else if (adap->is_gpio_recovery)
> +			adap->recover_bus = i2c_gpio_recover_bus;
> +		else if (adap->set_scl)
> +			adap->recover_bus = i2c_scl_recover_bus;
> +
> +warn_no_recovery:
Always generated warning..
> +		dev_warn(&adap->dev, "doesn't have recovery method\n");
> +	}
> +
>   	/* create pre-declared device nodes */
>   	if (adap->nr<  __i2c_first_dynamic_bus_num)
>   		i2c_scan_static_board_info(adap);
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 8e25a91..b2a6d97 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -388,6 +388,28 @@ struct i2c_adapter {
>
>   	struct mutex userspace_clients_lock;
>   	struct list_head userspace_clients;
> +
> +	/*
> +	 * bus recovery specific fields: Either pass driver's recover_bus()
> +	 * routine, or pass it NULL to use generic ones. There are two type of
> +	 * generic one's available:
> +	 * 	- controlling scl line as gpio, pass is_gpio_recovery as true
> +	 * 	and valid scl_gpio number
> +	 * 	- controlling scl line directly via controller, pass
> +	 * 	is_gpio_recovery as false and valid set_scl routine's pointer
> +	 *
> +	 * Both schemes require valid values of
> +	 * 	- clock_cnt: total number of dummy clocks to be generated
> +	 * 	- clock_rate: rate of dummy clock
> +	 *
> +	 * scl_gpio.
> +	 */
> +	int (*recover_bus)(struct i2c_adapter *);
> +	void (*set_scl)(struct i2c_adapter *, int val);
> +	bool is_gpio_recovery;
> +	u8 scl_gpio;
gpio can be more than 256. better to use int.
Take scl_gpio_flag and use in the gpio_request_one.
> +	u8 clock_cnt;
> +	u32 clock_rate;	/* In KHz */
>   };
>   #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
>
>
> --
> viresh


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
