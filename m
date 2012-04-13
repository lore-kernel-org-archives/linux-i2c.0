From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v9 3/4] drivers/i2c/busses/i2c-at91.c: add new driver
Date: Fri, 13 Apr 2012 13:39:41 +0300
Message-ID: <20120413103937.GH7154@arwen.pp.htv.fi>
References: <cover.1322479017a.git.n.voss@weinmann.de>
 <201203191534.q2JFYl1b012744@gatekeeper.vosshq.de>
 <CAFfN3gWCu5RnKb6dK4YMCAhpkfLncYdk1Cwqxb3wxMVznSiSFQ@mail.gmail.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qM81t570OJUP5TU/"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAFfN3gWCu5RnKb6dK4YMCAhpkfLncYdk1Cwqxb3wxMVznSiSFQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hubert Feurstein <h.feurstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Nikolaus Voss <n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--qM81t570OJUP5TU/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 13, 2012 at 12:17:59PM +0200, Hubert Feurstein wrote:
> Hi Niko,
>=20
> I'm using this driver since a while a now in my system
> (soc:at91sam9m10; kernel:v3.2.14) and it works quite well. But
> occasionally it happens that wrong data is read from my devices. I've
> traced down the issue to the way how you do the interrupt handling. In
> your code you do not consider that both status-flags (TXCOMP and
> RXRDY) may be pending at the same time. So you handle the TXCOMP but
> NOT the RXRDY which will cause a data-loss on the current transfer. As
> a consequence also the next transfer will be corrupt, because you
> start with old data in RHR. So I would suggest the following changes:
>=20
> static irqreturn_t atmel_twi_interrupt(int irq, void *dev_id)
> {
> 	struct at91_twi_dev *dev =3D dev_id;
> 	const unsigned status =3D at91_twi_read(dev, AT91_TWI_SR);
> 	unsigned irqstatus =3D status & at91_twi_read(dev, AT91_TWI_IMR);
>=20
> 	if (irqstatus & AT91_TWI_RXRDY) {
> 		at91_twi_read_next_byte(dev);
> 		irqstatus &=3D ~AT91_TWI_RXRDY;
> 	}
>=20
> 	if (irqstatus & AT91_TWI_TXRDY) {
> 		at91_twi_write_next_byte(dev);
> 		irqstatus &=3D ~AT91_TWI_TXRDY;
> 	}
>=20
> 	if (irqstatus & AT91_TWI_TXCOMP) {
> 		at91_disable_twi_interrupts(dev);
> 		dev->transfer_status =3D status;
> 		complete(&dev->cmd_complete);
> 		irqstatus &=3D ~AT91_TWI_TXCOMP;
> 	}
> =09
> 	if (irqstatus) {
> 		/* There should be no pending interrupt anymore. *)
> 		return IRQ_NONE;
> 	}

Dude, I remember asking the exact same thing when he first posted this
driver. That whole if...else if... else if ... else didn't look right.

Can you send this in patch format Hubert ? Take a look at
Documentation/SumittingPatches if you have never done it before.

--=20
balbi

--qM81t570OJUP5TU/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPiAJpAAoJEIaOsuA1yqREWcQQAKXiKzLPUHdoBrX7+Tl1LRJR
EM1NRqmOtonC6Y8aktDTeVJDIMWSPDQ2jIVe93zZbkh3bG9nbkKKzT7I9SFP6h/m
kcuDAOBUe8ZKXCvWF0PiraxgooYM4ecFFTVc+9BGxauUoA03c7aD/TV7I1TpLeL8
q/eu/paT3bp0H3Tkfpv+ei3pZ4zQE9hp+harG0jjywOhe+9va00D9T/q5ubOrmVg
H595oQd7B95VbNtVX+i6tf24A0+6Nco2A3rrTX35OCmp4FAu/FeOaqa0/0Q7lA1G
ceVXRjiwRlHMDuXBJIv2jTPlMlz45sO9ruPOXneAmXF7zWtFUpV4wU65K4O3I76/
jsgqOAplAvIXXyPzgsXvYGDtulqleF9nvHVLY0fdCLgekUe0yTmLyqio6wAp+p0y
XgE2BxICo0xWkA5KfkKfjYhfFeORK6oQbgtasNGnOYiVdKXmPd/Ur3zYuM+tkwf1
H50Wh1eYOE0aJ+b1Hu3KOUHUnTnZJf0JXRK2o39hsR5UdrDk0aKMkdbJBgD/JD3b
X+y60u2rJlocetRw43BAngDa96foMN0H3qh8ohT6jq67MbFtOIZOklXfjIyk7DJh
QxAstqFT8VTmuGRpqTPjSK3/zad76Fa9ze/3rhy8dlAgUrpAlBi0LNI4uR2G6Hq9
l/0f0yn9rK+JSA7eCTGs
=KPi4
-----END PGP SIGNATURE-----

--qM81t570OJUP5TU/--
