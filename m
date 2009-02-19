From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Handling of i2c arbitration loss (Was: i2c-fix-i2c-mpc-driver-for-multi-master-i2c-busses.patch  added to -mm tree)
Date: Thu, 19 Feb 2009 11:15:07 -0800
Message-ID: <200902191115.07289.david-b@pacbell.net>
References: <200812222101.mBML1kn7021201@imap1.linux-foundation.org> <200902160358.48176.david-b@pacbell.net> <20090216140809.01acaea1@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090216140809.01acaea1-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Clifford Wolf <clifford-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Monday 16 February 2009, Jean Delvare wrote:
> Hi Dave,
>=20
> On Mon, 16 Feb 2009 03:58:47 -0800, David Brownell wrote:
> > On Monday 16 February 2009, Jean Delvare wrote:
> > > > There's no guarantee of idempotency in messages; only
> > > > callers can know if retrying a given partially completed
> > > > message is safe. =A0And since fault reporting is still goofy,
> > > > we can't know just where arbitration was lost... in the
> > > > first master transmit, second (after repeated START),
> > > > third, etc.
> > >=20
> > > As already explained by Clifford, arbitration loss is about messa=
ges
> > > which have not been transmitted at all. So retrying is always OK.
> >=20
> > I must have missed that.  It's not correct, in any case.
> > Messages can easily have been *partially* transmitted.
>=20
> Sorry, but no, really. On bus error or device error, yes, but not on
> arbitration loss, by definition of arbitration on I2C buses.

One "struct i2c_msg" can be, for example:

	- Transfer #1: write bytes to some address
	- Transfer #2: write bytes to some address
	- STOP always signifies message end

Now, arbitration happens only during TX, of address or
data.  (A "read" message includes two transfers.)  In
that example, there are two transfers which can trigger
arbitration loss faults.

So:  if two masters are using the bus at the same time,
it's possible they both have the same Transfer #1 but
don't do the same thing afterwards.  QED:  one master
observes a partial message transfer, losing arbitration
part way through the message.  The other observes no
fault at all.


> > Loss of arbitration appears at the first transmitted bit
> > where one master sends '0' and overrides another, which
> > is sending '1' instead.  Ideally it's while addressing a
> > device, but it could be after some data bytes have been
> > sent ... and, depending on the slave, acted upon.  Even
> > after one or more repeated starts.
>=20
> Please think about it all again. If two masters talk at the same time=
,
> as long as they send the same bits, none loses arbitration. The
> addressed slave OTOH has no clue that there are two masters talking, =
it
> sees the exact same data as if only one master was talking. At the
> moment one of the master loses arbitration it'll stop talking, and fr=
om
> the slave's point of view everything is as if it had never talked in
> the first place.

That's within the scope of a *single* transfer.  A message
can include any number of such transfers, each of which will
be individually arbitrated ... and it's clearly possible that
one such transfer can succeed, but a later one doesn't (due
to arbitration loss).


> The funny case being if both masters actually send the exact same
> message,

Same "transfer", not message ...


> 	because neither will lose arbitration, both think they=20
> succeeded, but the slave has really only received the message once, n=
ot
> twice. Which may or may not be a problem depending on what the slave =
is
> supposed to do out of the message in question - but this is a hardwar=
e
> limitation and up to the designers to think of and deal with.

Yes, but don't equate "transfer" with "message".  And the
point I'm making about partial failures is relevant very
specifically because it constrains what designers can do.

Consider the example above where both transfers have side
effects, and are non-idempotent.  It would be wrong to have
the i2c core assume it's safe to reissue Transfer #1 on the
assumption that it's safe to do so.

- Dave
