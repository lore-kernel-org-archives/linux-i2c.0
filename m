From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/3] i2c-powermac: Simplify pmac_i2c_adapter_to_bus
Date: Thu, 5 Nov 2009 10:16:27 +0100
Message-ID: <20091105101627.0a086c04@hyperion.delvare>
References: <20091014165743.279789a4@hyperion.delvare>
	<1257382888.13611.81.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1257382888.13611.81.camel@pasglop>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Ben,

On Thu, 05 Nov 2009 12:01:28 +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2009-10-14 at 16:57 +0200, Jean Delvare wrote:
> > pmac_i2c_adapter_to_bus can be simplified. We no longer need to walk
> > the list of buses, we can get the right bus directly.
> > 
> > The only case where it makes a difference is if the provided adapter
> > is _not_ a pmac_i2c_bus, but it is not supposed to happen anyway. So
> > we can also drop the error checks.
> 
> Allright, I suspect that's the one causing my crashes, I need to confirm
> it still since the crashes are ellusive.
> 
> The thing is, there are other i2c adapters on the machine that aren't
> pmac_i2c, for example, the ones creates by the radeon driver for i2c
> probing.
> 
> What happens then is that code such as the windfarm stuff does:
> 
> static int wf_sat_attach(struct i2c_adapter *adapter)
> {
> 	struct device_node *busnode, *dev = NULL;
> 	struct pmac_i2c_bus *bus;
> 
> 	bus = pmac_i2c_adapter_to_bus(adapter);
> 	busnode = pmac_i2c_get_bus_node(bus);
> 
> 	while ((dev = of_get_next_child(busnode, dev)) != NULL)
> 		if (of_device_is_compatible(dev, "smu-sat"))
> 			wf_sat_create(adapter, dev);
> 	return 0;
> }
> 
> That will not work when such an adapter is in the system with
> your new code since pmac_i2c_adapter_to_bus() will return crap,
> causing busnode to basically be random bits of unrelated memory.

You are correct. Not sure how I missed this, as I am aware that the
radeonfb driver has its own I2C adapters.

> Now, what would be nice would be to convert the SMU sat stuff
> to use some new style OF based i2c probing but that is out of
> scope right now, so we need to drop that patch of yours at
> least for now.

I agree. Let's simply drop this one patch. It was only a clean-up and
the rest of the patches are still working and useful without it.

> I'll dbl check later today that this is indeed what's happening

I'm fairly certain your analysis is correct. As long as some drivers
still use i2c_driver.attach_adapter, we can't make any assumption about
which adapter is passed.

I had 6 i2c-powermac patches in my local queue:

i2c-powermac-01-multiple-msg-not-supported.patch
i2c-powermac-02-refactor-xfer.patch
i2c-powermac-03-report-errors.patch
i2c-powermac-04-include-adapter-in-bus.patch
i2c-powermac-05-simplify-pmac_i2c_adapter_to_bus.patch
i2c-powermac-06-no-temp-buffer-for-name.patch

I only have a formal ack from you for patch 01. Patches 01, 02 and 03
have been in linux-next for about a month now. I will delete patch 05
now. This leaves us with 4 patches still waiting for your ack (02, 03,
04 and 06.) I'm not sure which ones you tested so far?

Thanks,
-- 
Jean Delvare
