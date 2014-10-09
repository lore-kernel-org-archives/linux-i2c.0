From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 1/3] mfd: add support for Cypress CYUSBS234 USB Serial
 Bridge controller
Date: Thu, 9 Oct 2014 11:59:50 +0100
Message-ID: <20141009105950.GP20647@lee--X1>
References: <1412606587-3323-1-git-send-email-muth@cypress.com>
 <20141009074029.GL20647@lee--X1>
 <20141009081520.GJ1990@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141009081520.GJ1990@localhost>
Sender: linux-gpio-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Muthu Mani <muth@cypress.com>, Samuel Ortiz <sameo@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, gregkh@linuxfoundation.org, linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Rajaram Regupathy <rera@cypress.com>
List-Id: linux-i2c@vger.kernel.org

On Thu, 09 Oct 2014, Johan Hovold wrote:

> On Thu, Oct 09, 2014 at 08:40:29AM +0100, Lee Jones wrote:
> > On Mon, 06 Oct 2014, Muthu Mani wrote:
>=20
> > > +static int update_ep_details(struct usb_interface *interface,
> > > +				struct cyusbs23x *cyusbs)
> > > +{
> > > +	struct usb_host_interface *iface_desc;
> > > +	struct usb_endpoint_descriptor *ep;
> > > +	int i;
> > > +
> > > +	iface_desc =3D interface->cur_altsetting;
> > > +
> > > +	for (i =3D 0; i < iface_desc->desc.bNumEndpoints; ++i) {
> > > +
> > > +		ep =3D &iface_desc->endpoint[i].desc;
> > > +
> > > +		if (!cyusbs->bulk_in_ep_num && usb_endpoint_is_bulk_in(ep))
> > > +			cyusbs->bulk_in_ep_num =3D ep->bEndpointAddress;
> > > +		if (!cyusbs->bulk_out_ep_num && usb_endpoint_is_bulk_out(ep))
> > > +			cyusbs->bulk_out_ep_num =3D ep->bEndpointAddress;
> > > +		if (!cyusbs->intr_in_ep_num && usb_endpoint_is_int_in(ep))
> > > +			cyusbs->intr_in_ep_num =3D ep->bEndpointAddress;
> > > +	}
> >=20
> > All of the USB specific code in this driver will require a USB Ack.
>=20
> I'll review it once the incomplete gpio-driver issue has been resolve=
d.

Okay, great.

> > > +	dev_dbg(&interface->dev, "%s intr_in=3D%d, bulk_in=3D%d, bulk_o=
ut=3D%d\n",
> > > +		__func__, cyusbs->intr_in_ep_num ,
> > > +		cyusbs->bulk_in_ep_num, cyusbs->bulk_out_ep_num);
> > > +
> > > +	if (!cyusbs->bulk_in_ep_num || !cyusbs->bulk_out_ep_num ||
> > > +		!cyusbs->intr_in_ep_num)
> > > +		return -ENODEV;
> > > +
> > > +	return 0;
> > > +}
>=20
> [...]
>=20
> > > diff --git a/include/linux/mfd/cyusbs23x.h b/include/linux/mfd/cy=
usbs23x.h
>=20
> > > +/* Serial interfaces (I2C, SPI, UART) differ in interface subcla=
ss */
> > > +enum cy_scb_modes {
> > > +	CY_USBS_SCB_DISABLED =3D 0,
> > > +	CY_USBS_SCB_UART =3D 1,
> > > +	CY_USBS_SCB_SPI =3D 2,
> > > +	CY_USBS_SCB_I2C =3D 3
> >=20
> > No need to number these.
>=20
> As it's not an arbitrary enumeration, I think they should be initiali=
sed
> explicitly.

No need.  You are protected by the C Standard:

6.7.2.2 Enumeration specifiers

"If the first enumerator has no =3D, the value of its enumeration
constant is 0. Each subsequent enumerator with no =3D defines its
enumeration constant as the value of the constant expression obtained
by adding 1 to the value of the previous enumeration constant."

There's nothing arbitrary about that.

> They could be defined in the mfd driver though, as they only
> appear to be needed during probe.


--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
