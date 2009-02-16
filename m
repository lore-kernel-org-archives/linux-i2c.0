From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Handling of i2c arbitration loss (Was:
 i2c-fix-i2c-mpc-driver-for-multi-master-i2c-busses.patch  added to -mm
 tree)
Date: Mon, 16 Feb 2009 14:08:09 +0100
Message-ID: <20090216140809.01acaea1@hyperion.delvare>
References: <200812222101.mBML1kn7021201@imap1.linux-foundation.org>
	<200902151653.36860.david-b@pacbell.net>
	<20090216092000.13af2d74@hyperion.delvare>
	<200902160358.48176.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200902160358.48176.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Clifford Wolf <clifford-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Dave,

On Mon, 16 Feb 2009 03:58:47 -0800, David Brownell wrote:
> On Monday 16 February 2009, Jean Delvare wrote:
> > > There's no guarantee of idempotency in messages; only
> > > callers can know if retrying a given partially completed
> > > message is safe. =A0And since fault reporting is still goofy,
> > > we can't know just where arbitration was lost... in the
> > > first master transmit, second (after repeated START),
> > > third, etc.
> >=20
> > As already explained by Clifford, arbitration loss is about message=
s
> > which have not been transmitted at all. So retrying is always OK.
>=20
> I must have missed that.  It's not correct, in any case.
> Messages can easily have been *partially* transmitted.

Sorry, but no, really. On bus error or device error, yes, but not on
arbitration loss, by definition of arbitration on I2C buses.

> Loss of arbitration appears at the first transmitted bit
> where one master sends '0' and overrides another, which
> is sending '1' instead.  Ideally it's while addressing a
> device, but it could be after some data bytes have been
> sent ... and, depending on the slave, acted upon.  Even
> after one or more repeated starts.

Please think about it all again. If two masters talk at the same time,
as long as they send the same bits, none loses arbitration. The
addressed slave OTOH has no clue that there are two masters talking, it
sees the exact same data as if only one master was talking. At the
moment one of the master loses arbitration it'll stop talking, and from
the slave's point of view everything is as if it had never talked in
the first place.

The funny case being if both masters actually send the exact same
message, because neither will lose arbitration, both think they
succeeded, but the slave has really only received the message once, not
twice. Which may or may not be a problem depending on what the slave is
supposed to do out of the message in question - but this is a hardware
limitation and up to the designers to think of and deal with.

--=20
Jean Delvare
