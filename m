From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: Re: [PATCH v13 03/10] mux: minimal mux subsystem and gpio-based mux
 controller
Date: Wed, 19 Apr 2017 14:00:54 +0200
Message-ID: <da90526b-7274-c52c-07e8-9f0d75cf1cbf@axentia.se>
References: <1492101794-13444-1-git-send-email-peda@axentia.se>
 <1492101794-13444-4-git-send-email-peda@axentia.se>
 <1492592817.2970.14.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1492592817.2970.14.camel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 2017-04-19 11:06, Philipp Zabel wrote:
> On Thu, 2017-04-13 at 18:43 +0200, Peter Rosin wrote:
>> Add a new minimalistic subsystem that handles multiplexer controllers.
>> When multiplexers are used in various places in the kernel, and the
>> same multiplexer controller can be used for several independent things,
>> there should be one place to implement support for said multiplexer
>> controller.
>>
>> A single multiplexer controller can also be used to control several
>> parallel multiplexers, that are in turn used by different subsystems
>> in the kernel, leading to a need to coordinate multiplexer accesses.
>> The multiplexer subsystem handles this coordination.
>>
>> This new mux controller subsystem initially comes with a single backend
>> driver that controls gpio based multiplexers. Even though not needed by
>> this initial driver, the mux controller subsystem is prepared to handle
>> chips with multiple (independent) mux controllers.
>>
>> Reviewed-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> Signed-off-by: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
>> ---

*snip*

>> +int mux_control_select(struct mux_control *mux, int state)
> 
> If we let two of these race, ...

The window for this "race" is positively huge. If there are several
mux consumers of a single mux controller, it is self-evident that
if one of them grabs the mux for a long time, the others will suffer.

The design is that the rwsem is reader-locked for the full duration
of a select/deselect operation by the mux consumer.

>> +{
>> +	int ret;
>> +
>> +	if (down_read_trylock(&mux->lock)) {
>> +		if (mux->cached_state == state)
>> +			return 0;
>> +		/* Sigh, the mux needs updating... */
>> +		up_read(&mux->lock);
> 
> ... and both decide the mux needs updating ...
> 
>> +	}
>> +
>> +	/* ...or it's just contended. */
>> +	down_write(&mux->lock);
> 
> ... then the last to get to down_write will just wait here forever (or
> until the first consumer calls mux_control_deselect, which may never
> happen)?

It is vital that the mux consumer call _deselect when it is done with
the mux. Not doing so will surely starve out any other mux consumers.
The whole thing is designed around the fact that mux consumers should
deselect the mux as soon as it's no longer needed.

It's simply not possible to share something as fundamental as a mux
without some cooperation. It's not like suffering mux consumers can
go off and use some other mux, and it's also not possible for a
"competing" mux consumer to just clobber the mux state.

>> +
>> +	if (mux->cached_state == state) {
>> +		/*
>> +		 * Hmmm, someone else changed the mux to my liking.
>> +		 * That makes me wonder how long I waited for nothing?
>> +		 */
>> +		downgrade_write(&mux->lock);
>> +		return 0;
>> +	}
>> +
>> +	ret = mux_control_set(mux, state);
>> +	if (ret < 0) {
>> +		if (mux->idle_state != MUX_IDLE_AS_IS)
>> +			mux_control_set(mux, mux->idle_state);
>> +
>> +		up_write(&mux->lock);
>> +		return ret;
>> +	}
>> +
>> +	downgrade_write(&mux->lock);
>> +
>> +	return 1;
>> +}
>> +EXPORT_SYMBOL_GPL(mux_control_select);
> 
> I wonder if these should be called mux_control_lock/unlock instead,
> which would allow for try_lock and lock_timeout variants.

Maybe, I'm not totally against it. Do others care to opine?

But mux_control_try_select and mux_control_select_timeout does not
look all that bad either. But maybe foo_lock is making it clearer
that a foo_unlock is needed, if you compared it to foo_select and
foo_unselect? I'm probably not the best person to make the call,
as I know all to well what to expect from the functions...

Cheers,
peda

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
