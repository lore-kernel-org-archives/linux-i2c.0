From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 1/2] i2c: Multiplexed I2C bus core support
Date: Tue, 15 Jun 2010 11:00:18 +0200
Message-ID: <20100615110018.3260a511@hyperion.delvare>
References: <4BE01741.1010909@gmx.de>
	<20100610152411.5497461c@hyperion.delvare>
	<4C173F61.8000007@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C173F61.8000007-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Michael,

On Tue, 15 Jun 2010 10:52:49 +0200, Michael Lawnick wrote:
> Hi Jean,
> 
> Jean Delvare said the following:
> ...
> >>  	if (adapter->algo->smbus_xfer) {
> >> -		rt_mutex_lock(&adapter->bus_lock);
> >> +		i2c_mux_tree_lock(adapter);
> >>
> >>  		/* Retry automatically on arbitration loss */
> >>  		orig_jiffies = jiffies;
> >> @@ -1871,7 +1950,7 @@ s32 i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr, unsigned short flags,
> >>  				       orig_jiffies + adapter->timeout))
> >>  				break;
> >>  		}
> >> -		rt_mutex_unlock(&adapter->bus_lock);
> >> +		i2c_mux_tree_unlock(adapter);
> >>  	} else
> >>  		res = i2c_smbus_xfer_emulated(adapter,addr,flags,read_write,
> >>  					      command, protocol, data);
> >
> > I'm worried that this approach is risky. We now use i2c_mux_tree_*lock
> > internally, but still expose the i2c_*lock_adapter() API externally.
> > This API is _not_ mux-aware, and will do the wrong thing if called on a
> > bus segment behind a mux.
> >
> > I'd rather not have two APIs when we really only need one. Let's just
> > update the current public API to be mux-aware, and use that everywhere.
> 
> Agree, but I'd vote to do it not inline as its now. Otherwise we start to export
> mux implementation details in i2c.h

Of course. In fact I am preparing a patch which moves these functions
to i2c-core, uninlines them, and uses them as appropriate. Your
multiplexing patch would stack on top of it, so it is nice and clean
and self-contained.

> >> diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
> >> index f4110aa..da5327f 100755
> >> --- a/drivers/i2c/i2c-dev.c
> >> +++ b/drivers/i2c/i2c-dev.c
> >> @@ -193,12 +193,56 @@ static int i2cdev_check(struct device *dev, void *addrp)
> >>  	return dev->driver ? -EBUSY : 0;
> >>  }
> >>
> >> +static int i2cdev_parent_is_i2c_adapter(const struct i2c_adapter *adapter)
> >> +{
> >> +	return adapter->dev.parent != NULL
> >> +		&& adapter->dev.parent->bus == &i2c_bus_type;
> >> +}
> >
> > This is an exact duplicate of the same function in i2c-core. I'd rather
> > make it an inline function in <linux/i2c.h>, or export the one from
> > i2c-core.c. We have enough duplicate code in i2c-dev.c already :(
> 
> Must this and the above be done in an extra patch or can it be mixed into this mux patch?

Whatever is easier for you, both are fine with me.

-- 
Jean Delvare
