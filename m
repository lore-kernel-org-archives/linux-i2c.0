From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: Multiplexed I2C bus core support.
Date: Fri, 16 Apr 2010 13:21:44 +0200
Message-ID: <20100416132144.5ea8b0b1@hyperion.delvare>
References: <4B5D8AFC.5060209@gmx.de>
	<20100415144906.2a20588d@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100415144906.2a20588d-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

One thing I forgot:

On Thu, 15 Apr 2010 14:49:06 +0200, Jean Delvare wrote:
> On Mon, 25 Jan 2010 13:13:48 +0100, Michael Lawnick wrote:
> > +static int i2c_check_clients(struct i2c_adapter *adapter, int addr)
> > +{
> > +	int result = 0;
> 
> Useless initialization.
> 
> > +
> > +	result = device_for_each_child(&adapter->dev, &addr, __i2c_check_addr);
> > +
> > +	if (!result && (adapter->dev.parent->bus == &i2c_bus_type))
> 
> All devices don't have a parent, so you should first check that
> adapter->dev.parent isn't NULL. Try your code with i2c-stub for
> example, it would crash.
> 
> > +		result = i2c_check_clients(to_i2c_adapter(adapter->dev.parent), addr);
> > +	
> > +	return result;
> > +}

As discussed some weeks ago, this isn't actually sufficient. You don't
only need to check the parent segments for address business, you also
need to check all child segments, recursively. If any child segment has
a device using the address in question, then you can't use it.

This may be more difficult to implement. In particular, you'll have to
pay attention to locking.

-- 
Jean Delvare
