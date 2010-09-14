From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH 05/25] drivers/i2c: Use static const char arrays
Date: Tue, 14 Sep 2010 20:48:06 +0100
Message-ID: <20100914194806.GA26693@n2100.arm.linux.org.uk>
References: <cover.1284406638.git.joe@perches.com> <b0c83cb1b42c6adf38f6322066fb457693f7ac3b.1284406638.git.joe@perches.com> <4C8E84A0.1010606@jic23.retrosnub.co.uk> <19599.9719.562406.692216@ipc1.ka-ro> <4C8F7157.9060005@jic23.retrosnub.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4C8F7157.9060005-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <kernel-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org>
Cc: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Cameron <arm-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org>, "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Sep 14, 2010 at 01:57:59PM +0100, Jonathan Cameron wrote:
> On 09/14/10 08:36, Lothar Wa=DFmann wrote:
> > Hi,
> >=20
> > Jonathan Cameron writes:
> >>  Commit message is  somewhat inaccurate...
> >>
> >> On 09/13/10 20:47, Joe Perches wrote:
> >>> Signed-off-by: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
> >>> ---
> >>>  drivers/i2c/busses/i2c-stu300.c |    4 ++--
> >>>  1 files changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/i2c/busses/i2c-stu300.c b/drivers/i2c/busses=
/i2c-stu300.c
> >>> index 495be45..2f7c09c 100644
> >>> --- a/drivers/i2c/busses/i2c-stu300.c
> >>> +++ b/drivers/i2c/busses/i2c-stu300.c
> >>> @@ -871,7 +871,7 @@ stu300_probe(struct platform_device *pdev)
> >>>  	struct resource *res;
> >>>  	int bus_nr;
> >>>  	int ret =3D 0;
> >>> -	char clk_name[] =3D "I2C0";
> >>> +	char clk_name[sizeof("I2Cx")];
> >>> =20
> >>>  	dev =3D kzalloc(sizeof(struct stu300_dev), GFP_KERNEL);
> >>>  	if (!dev) {
> >>> @@ -881,7 +881,7 @@ stu300_probe(struct platform_device *pdev)
> >>>  	}
> >>> =20
> >>>  	bus_nr =3D pdev->id;
> >>> -	clk_name[3] +=3D (char)bus_nr;
> >>> +	sprintf(clk_name, "I2C%c", '0' + bus_nr);
> >> I'm guessing that there are never more than a couple of these.
> >> Why is this method a better bet than just putting %d?
> >>
> > '%c' will only ever produce one byte of output while '%d' may
> > produce up to 11 bytes depending on the value of bus_nr thus
> > overflowing the buffer.
> Then use an snprintf, or apply a check to ensure it isn't bigger than
> 9.
>=20
> If you don't mind having clocks named i2c$ or something equally
> silly then I guess this is fine.  To my mind, if that is possible
> this is a bug that should be fixed rather than avoided.

Even better, fix the implementation so that it conforms to the API
spec rather than doing its own thing with the consumer connection ID
argument and ignoring the struct device argument.
