From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] I2C: add i2c_master_send_exact() and friends
Date: Sat, 16 Feb 2013 13:52:23 -0800
Message-ID: <20130216215223.GC22044@core.coreip.homeip.net>
References: <20130216024235.GA25913@core.coreip.homeip.net>
 <20130216222524.0980b297@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130216222524.0980b297-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Feb 16, 2013 at 10:25:24PM +0100, Jean Delvare wrote:
> Hi Dmitry,
> 
> On Fri, 15 Feb 2013 18:42:35 -0800, Dmitry Torokhov wrote:
> > Many i2c users consider short transfers to be an error and would prefer
> > getting -EIO instead of a positive return value and having to convert
> > it to error code by themselves. So let's add the following new helpers:
> > 
> > 	i2c_master_send_exact()
> > 	i2c_master_recv_exact()
> > 	i2c_transfer_exact()
> 
> This is interesting, so far people had been complaining that
> i2c_transfer() wasn't telling enough to the caller on error. You're the
> first one asking for less detail. But in a way this is the same
> request: the current API can't report both errors and number of
> transferred messages/bytes, so the interface ends up being too complex
> for what it can actually do.
> 
> There was a proposal to improve that but it required touching struct
> i2c_msg in a way that would break binary compatibility on some
> architectures, so it was rejected.
> 
> At this point I can only think of two ways to address the issue
> properly: either introduce a new i2c_msg-like structure, or add an
> optional u16* parameter to i2c_transfer(), pointing to an array with
> the same size as msgs, where the number of transferred bytes for each
> message would be recorded. The latter doesn't look as nice but would be
> better performance-wise (no need to convert between old and new i2c_msg
> structures in compatibility paths.) In both cases, this would have to
> be implemented optionally on a per-driver basis, and user-space
> wouldn't benefit of it unless someone explicitly adds new ioctls to the
> i2c-dev interface.
> 
> If this ever happens then your proposal makes sense. Otherwise it might
> actually make more sense to just simplify the current API by only
> returning success (0) or a negative error code, and adding some
> compatibility code into i2c-dev.c so that user-space doesn't see the
> change.

I'd be OK with this as well. What I want to avoid is the checks below
repeated in every input driver for I2C devices. If you look at them they
all care about getting (or transmitting) the whole structure and neither
of them is happy with partial transfers.

I am pretty sure if I look into other subsystems I will find more
examples of that.

> 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> > 
> > Resending to Wolfram's new address...
> > 
> >  drivers/i2c/i2c-core.c |   69 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/i2c.h    |   11 ++++++++
> >  2 files changed, 80 insertions(+)
> > 
> > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> > index e388590..6cddb5d 100644
> > --- a/drivers/i2c/i2c-core.c
> > +++ b/drivers/i2c/i2c-core.c
> > @@ -1430,6 +1430,33 @@ int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
> >  EXPORT_SYMBOL(i2c_transfer);
> >  
> >  /**
> > + * i2c_transfer_exact - transfer given number of I2C messages
> > + * @adap: Handle to I2C bus
> > + * @msgs: One or more messages to execute before STOP is issued to
> > + *	terminate the operation; each message begins with a START.
> > + * @num: Number of messages to be executed.
> > + *
> > + * Returns negative errno (including -EIO on short transfer),
> > + * or 0 if all messages have been tranferred successfully.
> > + *
> > + * Note that there is no requirement that each message be sent to
> > + * the same slave address, although that is the most common model.
> > + */
> > +int i2c_transfer_exact(struct i2c_adapter *adap,
> > +		       struct i2c_msg *msgs, int num)
> > +{
> > +	int ret;
> > +
> > +	ret = i2c_transfer(adap, msgs, num);
> > +	if (ret == num)
> > +		return 0;
> > +
> > +	return ret < 0 ? ret : -EIO;
> > +
> > +}
> > +EXPORT_SYMBOL(i2c_transfer_exact);
> 
> Two questions here which apply to other functions as well:
> * Why don't you use EXPORT_SYMBOL_GPL()?

2 reasons:

1. I am following the rest of the file which uses standard
EXPORT_SYMBOL()

2. I find EXPORT_SYMBOL_GPL() is stupid idea as it does not really add
anything over standard EXPORT_SYMBOL(). The entire kernel is GPL and a
particular code is either derivative work or it is not. If it is and it
is not GPL then it is in violation of the license and can not use any of
the symbols. And if it is not a derivative work, then again GPL vs
non-GPL symbols make no real difference.

However if you prefer EXPORT_SYMBOL_GPL() I can change it.

> * Did you check if an inline function wouldn't be cheaper in practice?
>   i2c_transfer() is already a wrapper around __i2c_transfer(), and
>   i2c_master_send/recv() are wrappers around i2c_transfer(). Adding one
>   more wrapper level is going to do no good to performance and stack
>   usage.

I'll check, but I do not expect a wrapper adding any performance
penalties. We'd also pass most of the parameters in registers so I do
not think the stack usage is an issue either.

Thanks.

-- 
Dmitry
