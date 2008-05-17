From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.26-rc1-git] i2c-core: return -Errno, not -1
Date: Sat, 17 May 2008 06:53:18 -0700
Message-ID: <200805170653.19424.david-b@pacbell.net>
References: <200805031306.16698.david-b@pacbell.net>
	<20080516091458.28f9f5ca@hyperion.delvare>
	<20080517081537.17220cd0@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080517081537.17220cd0-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Friday 16 May 2008, Jean Delvare wrote:
> > > =A0=A0=A0=A0default:
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0dev_err(&adapter->dev, "smbus_acc=
ess called with invalid size (%d)\n",
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0 size);
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -1;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -EOPNOTSUPP;
> > > =A0=A0=A0=A0}
> > =

> > I'd rather use -EINVAL here. (...)
> =

> Hmh, scratch this. Thinking about it some more (night helps)
> -EOPNOTSUPP is consistent with what we did for the bus drivers after
> all, and it also anticipates addition of new transaction types to
> <linux/i2c.h> or removal of support for some transaction types from
> i2c_smbus_xfer_emulated() ..

Right.


> > (..)
> > BTW, feel free to adjust the debugging message above, as you did in
> > some bus drivers already, to clearly say that we're speaking about a
> > transaction type and not a "size".

I must have missed a few.  Those updates weren't initially on
a list of things-to-change, but I guess some of the issues were
egregious enough to make me add them -- after that particular
confusion percolated long enough.  The third or fourth time
through a piece of code, it's a bit easier to notice that sort
of confusion.  (Probably worth someone's time to switch *ALL*
drivers from calling that a "size".  I think that bit of history
needs to be edited out of existence...)


> > All the rest looks OK to me from a functional point of view. As far as
> > style is concerned, please keep the alignment on opening parenthesis
> > when the original code did that. i2c-core uses this style consistently
> > and I like it.
> =

> I'll do all this myself now, no need to resend.

Good.  In general, when it's down to the last set of small
comments like this, it's probably easier all around if you
do stuff like that (rather than writing it up in email, having
someone like me both read it and make time to act on it, then
have you re-review).  That's fairly common maintainer practice.

- Dave




_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
