From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/3] mfd: add support for Cypress CYUSBS234 USB Serial
 Bridge controller
Date: Fri, 10 Oct 2014 17:17:18 +0100
Message-ID: <20141010161718.GA8767@lee--X1>
References: <1412606587-3323-1-git-send-email-muth@cypress.com>
 <20141009074029.GL20647@lee--X1>
 <db79d07038e44d428f8ca6d82508d4ad@BN1PR06MB069.namprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <db79d07038e44d428f8ca6d82508d4ad-W5EIp8XyyIo12s5EQIJpXb9PrO6axcR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Muthu Mani <muth-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rajaram Regupathy <rera-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

> > -----Original Message-----
> > From: Lee Jones [mailto:lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org]
> > Sent: Thursday, October 09, 2014 1:10 PM
> > To: Muthu Mani
> > Cc: Samuel Ortiz; Wolfram Sang; Linus Walleij; Alexandre Courbot;
> > gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> > gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> > kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Rajaram Regupathy; Johan Hovold
> > Subject: Re: [PATCH v3 1/3] mfd: add support for Cypress CYUSBS234 =
USB
> > Serial Bridge controller

Why is this in here?

> > > +     cyusbs->usb_dev =3D usb_get_dev(interface_to_usbdev(interfa=
ce));
> >=20
> > Can you do this last?  Then you can remove the 'error' error path.
>=20
> mfd_add_devices would utlimately invoke the cell drivers' probe befor=
e returning and cell drivers use usb_dev in their probe.
> So, leaving it as such.

Can you move it down to just about mfd_add_devices() then.  That way
can you at least return directly in the other error paths.

[...]

> > > +MODULE_AUTHOR("Rajaram Regupathy <rera-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>");
> > > +MODULE_AUTHOR("Muthu Mani <muth-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>");
> > > +MODULE_DESCRIPTION("Cypress CYUSBS23x mfd core driver");
> >=20
> > s/mfd/MFD/
>=20
> Is there a typo?

Yes mfd should be MFD, as I sed (spelt this way on purpose).

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
