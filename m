From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 4/7] gpiolib: implement dev_gpiochip_{add,remove} calls
Date: Sat, 18 Oct 2008 01:29:42 +0400
Message-ID: <20081017212942.GA1919@oksana.dev.rtsoft.ru>
References: <20081016171222.GA24812@oksana.dev.rtsoft.ru> <20081016171259.GD5515@oksana.dev.rtsoft.ru> <200810171324.42650.david-b@pacbell.net>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755070AbYJQVaN@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200810171324.42650.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, David Brownell <dbrownell@users.sourceforge.net>, "Steven A. Falco" <sfalco@harris.com>, Grant Likely <grant.likely@secretlab.ca>, Jean Delvare <khali@linux-fr.org>, David Miller <davem@davemloft.net>, i2c@lm-sensors.org, linuxppc-dev@ozlabs.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Oct 17, 2008 at 01:24:42PM -0700, David Brownell wrote:
> On Thursday 16 October 2008, Anton Vorontsov wrote:
> > +/*
> > + * Platforms can define their own __dev_ versions to glue gpio_chi=
ps with the
> > + * architecture-specific code.
> > + */
> > +#ifndef __dev_gpiochip_add
> > +#define __dev_gpiochip_add __dev_gpiochip_add
> > +static inline int __dev_gpiochip_add(struct device *dev,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 struct gpio_chip *chip)
> > +{
> > +=A0=A0=A0=A0=A0=A0=A0chip->dev =3D dev;
> > +=A0=A0=A0=A0=A0=A0=A0return gpiochip_add(chip);
> > +}
> > +#endif /* __dev_gpiochip_add */
>=20
> This is pretty ugly, especially the implication that *EVERY* gpio_chi=
p
> provider needs modification to use these calls.

Anyway most of them need some modifications to work with OF...

> Surely it would be a lot simpler to just add platform-specific hooks
> to gpiochip_{add,remove}(), [...]

We have printk and dev_printk. kzalloc and devm_kzalloc (though I
aware that devm_ are different than just dev_).  So I thought that
dev_gpiochip_* would be logical order of things...

If you don't like it, I can readily implement hooks for
gpiochip_{add,remove}().


Thanks for the comments,

--=20
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
