From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 4/7] gpiolib: implement dev_gpiochip_{add,remove} calls
Date: Fri, 17 Oct 2008 13:24:42 -0700
Message-ID: <200810171324.42650.david-b@pacbell.net>
References: <20081016171222.GA24812@oksana.dev.rtsoft.ru> <20081016171259.GD5515@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756513AbYJQUb7@vger.kernel.org>
In-Reply-To: <20081016171259.GD5515@oksana.dev.rtsoft.ru>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: linux-kernel@vger.kernel.org, David Brownell <dbrownell@users.sourceforge.net>, "Steven A. Falco" <sfalco@harris.com>, Grant Likely <grant.likely@secretlab.ca>, Jean Delvare <khali@linux-fr.org>, David Miller <davem@davemloft.net>, i2c@lm-sensors.org, linuxppc-dev@ozlabs.org
List-Id: linux-i2c@vger.kernel.org

On Thursday 16 October 2008, Anton Vorontsov wrote:
> +/*
> + * Platforms can define their own __dev_ versions to glue gpio_chips=
 with the
> + * architecture-specific code.
> + */
> +#ifndef __dev_gpiochip_add
> +#define __dev_gpiochip_add __dev_gpiochip_add
> +static inline int __dev_gpiochip_add(struct device *dev,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 struct gpio_chip *chip)
> +{
> +=A0=A0=A0=A0=A0=A0=A0chip->dev =3D dev;
> +=A0=A0=A0=A0=A0=A0=A0return gpiochip_add(chip);
> +}
> +#endif /* __dev_gpiochip_add */

This is pretty ugly, especially the implication that *EVERY* gpio_chip
provider needs modification to use these calls.

Surely it would be a lot simpler to just add platform-specific hooks
to gpiochip_{add,remove}(), so that no providers need to be changed??


> +#ifndef __dev_gpiochip_remove
> +#define __dev_gpiochip_remove __dev_gpiochip_remove
> +static inline int __dev_gpiochip_remove(struct device *dev,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0struct gpio_chip *chip)
> +{
> +=A0=A0=A0=A0=A0=A0=A0return gpiochip_remove(chip);
> +}
> +#endif /* __dev_gpiochip_remove */
