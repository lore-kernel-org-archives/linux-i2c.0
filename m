From: Clifford Wolf <clifford-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org>
Subject: Re: Handling of i2c arbitration loss (Was:
	i2c-fix-i2c-mpc-driver-for-multi-master-i2c-busses.patch  added to
	-mm tree)
Date: Thu, 19 Feb 2009 22:08:37 +0100
Message-ID: <20090219210837.GB16107@clifford.at>
References: <200812222101.mBML1kn7021201@imap1.linux-foundation.org> <200902160358.48176.david-b@pacbell.net> <20090216140809.01acaea1@hyperion.delvare> <200902191115.07289.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200902191115.07289.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

On Thu, Feb 19, 2009 at 11:15:07AM -0800, David Brownell wrote:
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
> 
> Now, arbitration happens only during TX, of address or
> data.  (A "read" message includes two transfers.)  In
> that example, there are two transfers which can trigger
> arbitration loss faults.
> 
> So:  if two masters are using the bus at the same time,
> it's possible they both have the same Transfer #1 but
> don't do the same thing afterwards.  QED:  one master
> observes a partial message transfer, losing arbitration
> part way through the message.  The other observes no
> fault at all.

still: no.

there are two scenarios:

1.) the transfers are seperated with a restart condition.

in this case no new arbitration happens and so an arbitration loss may only
happen when both masters sent the "message" from the first transfer on in
sync. obviously there is no problem there.

2.) the transfers are seperated by a stop and a new start condition.

in this case we have new arbitration. that means that a 2nd master could
always get arbitration and interrupt the message by sending something else
inbetween the two transfers. this is a problem - but not related to
arbitration lost but related to sending a stop and a start condition where
a restart condition should have been sent. this is imo clearly a bug in the
i2c adapter driver or hardware and should never happen...

> Consider the example above where both transfers have side
> effects, and are non-idempotent. It would be wrong to have
> the i2c core assume it's safe to reissue Transfer #1 on the
> assumption that it's safe to do so.

so as you can hopefully see now:
it is always safe to restart transfering a message after arbitration loss.

but it is vital that in case of an arbitration loss the whole message, not
only the last transfer is retransmitted. I haven't checked the code but I'm
pretty sure it is done this way in the current code..

yours,
 - clifford

-- 
Prof: So the American government went to IBM to come up with
a data encryption standard and they came up with ...
Student: EBCDIC!
