From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Handling of i2c arbitration loss (Was:
 i2c-fix-i2c-mpc-driver-for-multi-master-i2c-busses.patch  added to -mm
 tree)
Date: Thu, 19 Feb 2009 22:31:59 +0100
Message-ID: <20090219223159.32abaf27@hyperion.delvare>
References: <200812222101.mBML1kn7021201@imap1.linux-foundation.org>
	<200902160358.48176.david-b@pacbell.net>
	<20090216140809.01acaea1@hyperion.delvare>
	<200902191115.07289.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200902191115.07289.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Clifford Wolf <clifford-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi David,

On Thu, 19 Feb 2009 11:15:07 -0800, David Brownell wrote:
> On Monday 16 February 2009, Jean Delvare wrote:
> > On Mon, 16 Feb 2009 03:58:47 -0800, David Brownell wrote:
> > > I must have missed that.  It's not correct, in any case.
> > > Messages can easily have been *partially* transmitted.
> > 
> > Sorry, but no, really. On bus error or device error, yes, but not on
> > arbitration loss, by definition of arbitration on I2C buses.
> 
> One "struct i2c_msg" can be, for example:
> 
> 	- Transfer #1: write bytes to some address
> 	- Transfer #2: write bytes to some address
> 	- STOP always signifies message end

Actually, no, one struct i2c_msg can't be that. An array of 2 struct
i2c_msg, yes.

> Now, arbitration happens only during TX, of address or
> data.  (A "read" message includes two transfers.)  In

The other way around...

> that example, there are two transfers which can trigger
> arbitration loss faults.
> 
> So:  if two masters are using the bus at the same time,
> it's possible they both have the same Transfer #1 but
> don't do the same thing afterwards.  QED:  one master
> observes a partial message transfer, losing arbitration
> part way through the message.  The other observes no
> fault at all.

No. I am sorry I have to insist. There is no such thing as a partial
message transfer followed by an arbitration loss. If a master ever
loses arbitration, then _everything_ it sent over the wire since the
previous start (_not_ repeated start) condition has simply never
existed for anybody else on the bus (masters and slave alike). Whether
this happens while sending the slave address of the first message, or
the last data byte of the last message, doesn't make any difference.

> > > Loss of arbitration appears at the first transmitted bit
> > > where one master sends '0' and overrides another, which
> > > is sending '1' instead.  Ideally it's while addressing a
> > > device, but it could be after some data bytes have been
> > > sent ... and, depending on the slave, acted upon.  Even
> > > after one or more repeated starts.
> > 
> > Please think about it all again. If two masters talk at the same time,
> > as long as they send the same bits, none loses arbitration. The
> > addressed slave OTOH has no clue that there are two masters talking, it
> > sees the exact same data as if only one master was talking. At the
> > moment one of the master loses arbitration it'll stop talking, and from
> > the slave's point of view everything is as if it had never talked in
> > the first place.
> 
> That's within the scope of a *single* transfer.  A message
> can include any number of such transfers, each of which will
> be individually arbitrated ... and it's clearly possible that
> one such transfer can succeed, but a later one doesn't (due
> to arbitration loss).

Arbitration is per transfer (from start condition to stop condition)
not per individual message (from start condition to repeated start
condition or repeated start condition to stop condition.)

> > The funny case being if both masters actually send the exact same
> > message,
> 
> Same "transfer", not message ...

Funny that you dare correcting me on this when you are the one being
confused here ;) As far as Linux' i2c implementation is concerned, an
I2C transfer can made of one or more messages (i2c_transfer takes an
array of struct i2c_msg as a parameter). The I2C specification doesn't
seem to really make a difference, as far as I can see it uses "message"
for everything.

> > 	because neither will lose arbitration, both think they 
> > succeeded, but the slave has really only received the message once, not
> > twice. Which may or may not be a problem depending on what the slave is
> > supposed to do out of the message in question - but this is a hardware
> > limitation and up to the designers to think of and deal with.
> 
> Yes, but don't equate "transfer" with "message".  And the
> point I'm making about partial failures is relevant very
> specifically because it constrains what designers can do.
> 
> Consider the example above where both transfers have side
> effects, and are non-idempotent.  It would be wrong to have
> the i2c core assume it's safe to reissue Transfer #1 on the
> assumption that it's safe to do so.

We don't care if the message has side effects, because it never existed
in the first place.

As far as non-idempotent messages are concerned, the problem is
inherent to multi-master I2C buses. If two masters send the exact same
message at the exact same time, arbitration doesn't even trigger, and
the message only goes once on the bus. There is nothing the OS can do
about this.

-- 
Jean Delvare
