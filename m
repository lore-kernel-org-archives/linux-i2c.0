From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 0/6] i2c: Get rid of the legacy binding model
Date: Sat, 2 May 2009 12:14:02 -0700
Message-ID: <200905021214.02937.david-b@pacbell.net>
References: <20090502113856.39940f1e@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090502113856.39940f1e-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Saturday 02 May 2009, Jean Delvare wrote:
> =A0Documentation/feature-removal-schedule.txt | =A0 10 -
> =A0Documentation/i2c/writing-clients =A0 =A0 =A0 =A0 =A0| =A0 16 -
> =A0drivers/i2c/i2c-core.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
366 +++--------------------------
> =A0include/linux/i2c.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 57 +----

Which makes all but patch #4 *very* easy to review.
All they do is remove code.  Unless that breaks a
build, those removals have a hard time making any
trouble.  ;)


> =A04 files changed, 48 insertions(+), 401 deletions(-)
>=20
> From a binary perspective, "size" announces an 18% shrink.

And Linux now builds without all those warnings, yes?

Plus from a code complexity perspective, it's even
better ... it removes 100% of the high level confusion
associated with that legacy model, and the bugs and
fragility caused by that.  (Or maybe I should say
that it *finishes* removing that.)

Glad to see this.  I presume this will sit in -next
for a while and merge in 2.6.31-early?

- Dave
