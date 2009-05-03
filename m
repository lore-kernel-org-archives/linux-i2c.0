From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 0/6] i2c: Get rid of the legacy binding model
Date: Sun, 3 May 2009 09:05:53 +0200
Message-ID: <20090503090553.0351ddfd@hyperion.delvare>
References: <20090502113856.39940f1e@hyperion.delvare>
	<200905021214.02937.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200905021214.02937.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, 2 May 2009 12:14:02 -0700, David Brownell wrote:
> On Saturday 02 May 2009, Jean Delvare wrote:
> > =A0Documentation/feature-removal-schedule.txt | =A0 10 -
> > =A0Documentation/i2c/writing-clients =A0 =A0 =A0 =A0 =A0| =A0 16 -
> > =A0drivers/i2c/i2c-core.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0366 +++--------------------------
> > =A0include/linux/i2c.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 57 +----
>=20
> Which makes all but patch #4 *very* easy to review.
> All they do is remove code.  Unless that breaks a
> build, those removals have a hard time making any
> trouble.  ;)

Well, removing code can always break things. For example, say I remove
all the locking code in the kernel... ;)

> > =A04 files changed, 48 insertions(+), 401 deletions(-)
> >=20
> > From a binary perspective, "size" announces an 18% shrink.
>=20
> And Linux now builds without all those warnings, yes?

Yes it does :)

> Plus from a code complexity perspective, it's even
> better ... it removes 100% of the high level confusion
> associated with that legacy model, and the bugs and
> fragility caused by that.  (Or maybe I should say
> that it *finishes* removing that.)

Thanks for doing all the hard work :)

> Glad to see this.  I presume this will sit in -next
> for a while and merge in 2.6.31-early?

Exactly. Where "early" is unfortunately bound to the few remaining
legacy drivers, the conversion of which is supposed to be merged by
their respective maintainers. But anyway, the hard deadline is
2.6.31-rc1.

--=20
Jean Delvare
