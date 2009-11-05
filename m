From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 2/3] i2c-powermac: Simplify pmac_i2c_adapter_to_bus
Date: Thu, 05 Nov 2009 12:01:28 +1100
Message-ID: <1257382888.13611.81.camel@pasglop>
References: <20091014165743.279789a4@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091014165743.279789a4-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 2009-10-14 at 16:57 +0200, Jean Delvare wrote:
> pmac_i2c_adapter_to_bus can be simplified. We no longer need to walk
> the list of buses, we can get the right bus directly.
> 
> The only case where it makes a difference is if the provided adapter
> is _not_ a pmac_i2c_bus, but it is not supposed to happen anyway. So
> we can also drop the error checks.

Allright, I suspect that's the one causing my crashes, I need to confirm
it still since the crashes are ellusive.

The thing is, there are other i2c adapters on the machine that aren't
pmac_i2c, for example, the ones creates by the radeon driver for i2c
probing.

What happens then is that code such as the windfarm stuff does:

static int wf_sat_attach(struct i2c_adapter *adapter)
{
	struct device_node *busnode, *dev = NULL;
	struct pmac_i2c_bus *bus;

	bus = pmac_i2c_adapter_to_bus(adapter);
	busnode = pmac_i2c_get_bus_node(bus);

	while ((dev = of_get_next_child(busnode, dev)) != NULL)
		if (of_device_is_compatible(dev, "smu-sat"))
			wf_sat_create(adapter, dev);
	return 0;
}

That will not work when such an adapter is in the system with
your new code since pmac_i2c_adapter_to_bus() will return crap,
causing busnode to basically be random bits of unrelated memory.

Now, what would be nice would be to convert the SMU sat stuff
to use some new style OF based i2c probing but that is out of
scope right now, so we need to drop that patch of yours at
least for now.

I'll dbl check later today that this is indeed what's happening

Cheers,
Ben.

> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
> ---
>  arch/powerpc/platforms/powermac/low_i2c.c   |    7 +------
>  drivers/macintosh/windfarm_lm75_sensor.c    |    2 --
>  drivers/macintosh/windfarm_max6690_sensor.c |    2 --
>  drivers/macintosh/windfarm_smu_sat.c        |    2 --
>  sound/aoa/codecs/onyx.c                     |    2 --
>  sound/aoa/codecs/tas.c                      |    2 --
>  6 files changed, 1 insertion(+), 16 deletions(-)
> 
> --- linux-2.6.32-rc4.orig/arch/powerpc/platforms/powermac/low_i2c.c	2009-10-14 15:56:23.000000000 +0200
> +++ linux-2.6.32-rc4/arch/powerpc/platforms/powermac/low_i2c.c	2009-10-14 15:57:42.000000000 +0200
> @@ -1020,12 +1020,7 @@ EXPORT_SYMBOL_GPL(pmac_i2c_get_adapter);
>  
>  struct pmac_i2c_bus *pmac_i2c_adapter_to_bus(struct i2c_adapter *adapter)
>  {
> -	struct pmac_i2c_bus *bus;
> -
> -	list_for_each_entry(bus, &pmac_i2c_busses, link)
> -		if (&bus->adapter == adapter)
> -			return bus;
> -	return NULL;
> +	return container_of(adapter, struct pmac_i2c_bus, adapter);
>  }
>  EXPORT_SYMBOL_GPL(pmac_i2c_adapter_to_bus);
>  
> --- linux-2.6.32-rc4.orig/drivers/macintosh/windfarm_lm75_sensor.c	2009-10-05 10:45:49.000000000 +0200
> +++ linux-2.6.32-rc4/drivers/macintosh/windfarm_lm75_sensor.c	2009-10-14 15:57:42.000000000 +0200
> @@ -173,8 +173,6 @@ static int wf_lm75_attach(struct i2c_ada
>  	DBG("wf_lm75: adapter %s detected\n", adapter->name);
>  
>  	bus = pmac_i2c_adapter_to_bus(adapter);
> -	if (bus == NULL)
> -		return -ENODEV;
>  	busnode = pmac_i2c_get_bus_node(bus);
>  
>  	DBG("wf_lm75: bus found, looking for device...\n");
> --- linux-2.6.32-rc4.orig/drivers/macintosh/windfarm_max6690_sensor.c	2009-10-05 10:45:49.000000000 +0200
> +++ linux-2.6.32-rc4/drivers/macintosh/windfarm_max6690_sensor.c	2009-10-14 15:57:42.000000000 +0200
> @@ -135,8 +135,6 @@ static int wf_max6690_attach(struct i2c_
>  	const char *loc;
>  
>  	bus = pmac_i2c_adapter_to_bus(adapter);
> -	if (bus == NULL)
> -		return -ENODEV;
>  	busnode = pmac_i2c_get_bus_node(bus);
>  
>  	while ((dev = of_get_next_child(busnode, dev)) != NULL) {
> --- linux-2.6.32-rc4.orig/drivers/macintosh/windfarm_smu_sat.c	2009-10-05 10:45:49.000000000 +0200
> +++ linux-2.6.32-rc4/drivers/macintosh/windfarm_smu_sat.c	2009-10-14 15:57:42.000000000 +0200
> @@ -359,8 +359,6 @@ static int wf_sat_attach(struct i2c_adap
>  	struct pmac_i2c_bus *bus;
>  
>  	bus = pmac_i2c_adapter_to_bus(adapter);
> -	if (bus == NULL)
> -		return -ENODEV;
>  	busnode = pmac_i2c_get_bus_node(bus);
>  
>  	while ((dev = of_get_next_child(busnode, dev)) != NULL)
> --- linux-2.6.32-rc4.orig/sound/aoa/codecs/onyx.c	2009-10-01 09:44:36.000000000 +0200
> +++ linux-2.6.32-rc4/sound/aoa/codecs/onyx.c	2009-10-14 15:57:42.000000000 +0200
> @@ -1077,8 +1077,6 @@ static int onyx_i2c_attach(struct i2c_ad
>  	struct pmac_i2c_bus *bus;
>  
>  	bus = pmac_i2c_adapter_to_bus(adapter);
> -	if (bus == NULL)
> -		return -ENODEV;
>  	busnode = pmac_i2c_get_bus_node(bus);
>  
>  	while ((dev = of_get_next_child(busnode, dev)) != NULL) {
> --- linux-2.6.32-rc4.orig/sound/aoa/codecs/tas.c	2009-10-05 10:45:51.000000000 +0200
> +++ linux-2.6.32-rc4/sound/aoa/codecs/tas.c	2009-10-14 15:57:42.000000000 +0200
> @@ -958,8 +958,6 @@ static int tas_i2c_attach(struct i2c_ada
>  	struct pmac_i2c_bus *bus;
>  
>  	bus = pmac_i2c_adapter_to_bus(adapter);
> -	if (bus == NULL)
> -		return -ENODEV;
>  	busnode = pmac_i2c_get_bus_node(bus);
>  
>  	while ((dev = of_get_next_child(busnode, dev)) != NULL) {
> 
> 
