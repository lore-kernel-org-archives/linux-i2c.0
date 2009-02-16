From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: + i2c-fix-i2c-mpc-driver-for-multi-master-i2c-busses.patch  added to -mm tree
Date: Mon, 16 Feb 2009 03:58:47 -0800
Message-ID: <200902160358.48176.david-b@pacbell.net>
References: <200812222101.mBML1kn7021201@imap1.linux-foundation.org> <200902151653.36860.david-b@pacbell.net> <20090216092000.13af2d74@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090216092000.13af2d74-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Clifford Wolf <clifford-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Monday 16 February 2009, Jean Delvare wrote:
> > There's no guarantee of idempotency in messages; only
> > callers can know if retrying a given partially completed
> > message is safe. =A0And since fault reporting is still goofy,
> > we can't know just where arbitration was lost... in the
> > first master transmit, second (after repeated START),
> > third, etc.
>=20
> As already explained by Clifford, arbitration loss is about messages
> which have not been transmitted at all. So retrying is always OK.

I must have missed that.  It's not correct, in any case.
Messages can easily have been *partially* transmitted.

Loss of arbitration appears at the first transmitted bit
where one master sends '0' and overrides another, which
is sending '1' instead.  Ideally it's while addressing a
device, but it could be after some data bytes have been
sent ... and, depending on the slave, acted upon.  Even
after one or more repeated starts.

- Dave
