From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 1/2] i2c: Multiplexed I2C bus core support
Date: Fri, 11 Jun 2010 11:40:03 +0200
Message-ID: <20100611114003.01c15f62@hyperion.delvare>
References: <4BE01741.1010909@gmx.de>
	<20100610152411.5497461c@hyperion.delvare>
	<4C11D85F.7010604@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C11D85F.7010604-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Michael,

On Fri, 11 Jun 2010 08:31:59 +0200, Michael Lawnick wrote:
> Jean Delvare said the following:
> > Hi Michael,
> > 
> >> +	list_add_tail(&priv->adap.mux_list, &parent->mux_list_head);
> > 
> > The driver core maintains a device tree already, do you really need to
> > keep your own? We've tried hard to remove all redundancy between
> > i2c-core and the driver core in the last couple years, so I really would
> > like us to not add such redundancy back now.
> > 
> > If you have a good reason to have your own list, please explain. If
> > not, please get rid of it.
> > 
> this is a core part of mux management. You need it for checking whether
> the current client that is to be added is already present.
> The problem is to efficiently parse down a mux tree towards the leaves.
> Sub-muxes are registered as i2c clients to their upper bus.

This is correct, but irrelevant, as far as I can see. When walking an
I2C segment tree towards the leaves, you care about the segments
themselves (struct i2c_adapter), not the mux chips. In your
architecture, muxed segments are direct children of the root segment
from the device tree perspective, not children of the mux chip.

> I found no way to separate muxes from normal clients.

If you have to, it is easy, the driver core has support for this
already. Search for i2c_client_type and i2c_adapter_type in i2c-core.c.
We could add i2c_mux_type easily. But as I wrote above, I don't think
we need this.

> So there were two ideas:
> invent a client-type field in i2c-client or to hold a separate list.
> The first one e.g. would have the possibility to provide basic info in sysFs
> but I feared a general debate. So I decided to go the other way which is
> hidden to the outer world.
> 
> If you don't like this way, I'd need some ideas how to do it.

I would walk the device tree maintained by the driver core (using
device_for_each_child) and filtering out irrelevant devices. Basically
filtering on dev->type == &i2c_adapter_type should do the trick,
methinks. Is there anything I am missing?

Thanks,
-- 
Jean Delvare
