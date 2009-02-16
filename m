From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: + i2c-fix-i2c-mpc-driver-for-multi-master-i2c-busses.patch
 added to -mm tree
Date: Mon, 16 Feb 2009 09:20:00 +0100
Message-ID: <20090216092000.13af2d74@hyperion.delvare>
References: <200812222101.mBML1kn7021201@imap1.linux-foundation.org>
	<20090109100145.GA12376@clifford.at>
	<20090214121745.39dfddf9@hyperion.delvare>
	<200902151653.36860.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200902151653.36860.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Clifford Wolf <clifford-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi David,

Switching to the i2c list, so that others can participate...

On Sun, 15 Feb 2009 16:53:36 -0800, David Brownell wrote:
> On Saturday 14 February 2009, Jean Delvare wrote:
> > From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > Subject: i2c: Automatically retry transfers on arbitration loss
> > 
> > Automatically retry transfers on arbitration loss. Each i2c_adapter
> > controls how many attempts will be made, using the retries value.
> > 
> > Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > Cc: Clifford Wolf <clifford-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org>
> > Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
> 
> Seems fair to me, except that the retry count is coupled
> to the adapter not to the specific request.  Automatic
> retry also seems problematic, unless the caller wants it.
> 
> There's no guarantee of idempotency in messages; only
> callers can know if retryig a given partially completed
> message is safe.  And since fault reporting is still goofy,
> we can't know just where arbitration was lost... in the
> first master transmit, second (after repeated START),
> third, etc.

As already explained by Clifford, arbitration loss is about messages
which have not been transmitted at all. So retrying is always OK.

> Note that only multi-master configurations will arbitrate
> for master transmit ... which means only I2C busses, not
> SMBus ones.  Thus it's odd to see i2c_smbus_transfer()
> arbitrate.

SMBus can have multiple masters just as I2C does. From the SMBus 2.0
specification document, section 4.3.1:

"A situation may occur in which more than one master is trying to place
clock signals on the bus at the same time."

And even if not, i2c_smbus_transfer() is meant for both I2C and SMBus,
the whole point of this function being to allow for portable drivers
working on both bus types.

> So I think it might be better to just create a new I2C
> call taking a specified number of retries ... and get rid
> of the old adap->retries field, as I though was the plan.

That was the plan, before Clifford came up with a legitimate use case.
Now I'd rather reuse the existing infrastructure to handle arbitration.

> Analyse the SMBus calls to see which ones (if any) are
> appropriate for automagic retries; include that answer
> in source code comment, and the function definitions.

There's such thing as "SMBus call which are appropriate for automagic
retries". It's all about the failure reason (arbitration loss or
something else) not the transfer type.

> I have no problem with using a retry count instead of a
> timeout.  Again there is an SMBus difference here; SMBus
> specifies (low level) protocol timeouts, but I2C allows
> transfers to be arbitrarily long.
> 
> One issue is how should you measure a timeout in the I2C
> stack.  Normally I'd expect it to start from issuing the
> request ... that is, to include any queue delays incurred
> while waiting for previous transfers from this host/master to
> complete, which might include letting other masters finish.
> 
> But i2c-core doesn't actually enforce such timeouts.  Again,
> this should be a per-request thing.

I see very little use for per-request timeout values in practice.

> I confess the only time I've actually needed to cope with
> arbitration was when doing some I2C slave firmware, with
> the SMBALERT# protocol.  Slave transmit there arbitrates
> which alert gets to the host; not Linux code at all.  And
> there's no issue of non-idempotent messages, it's a case
> of responding to the ARA until the response is acked, and
> then stop pulling SMBALERT# low.  (Other slaves may still
> pull it low, keeping the IRQ active.)

SMBALERT# protocol patches which are still pending, BTW... Are you ever
going to polish them and send them to me?

Thanks,
-- 
Jean Delvare
