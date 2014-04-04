From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: I2C adapters protocol deviation
Date: Fri, 4 Apr 2014 13:49:11 +0200
Message-ID: <20140404114911.GE6199@lukather>
References: <20140403145528.GA6199@lukather>
 <533D7E81.4050900@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SNIs70sCzqvszXB4"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <533D7E81.4050900-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, boris-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--SNIs70sCzqvszXB4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 03, 2014 at 05:30:09PM +0200, Hans de Goede wrote:
> Hi,
>=20
> On 04/03/2014 04:55 PM, Maxime Ripard wrote:
> > Hi Wolfram,
> >=20
> > On the Allwinner A31, the PMIC communicates with the SoC through a bus
> > looking quite similar to I2C, while being pretty different.
> >=20
> > The communication starts with the PMIC through the regular I2C
> > protocol, but it's only used to initialize the PMIC, and switch to a
> > mode called "Push/Pull 2 Wire Interface".
> >=20
> > That bus is using SDA and SCL, with the start and stop conditions
> > exactly like I2C does, but:
> >   - Once the start condition has been issued, the address isn't sent,
> >     only a direction bit. Hence, it does not support multiple devices
> >     anymore.
> >   - Once that direction bit has been sent, the master sends the
> >     register it wants to read from/write to, over 8 bits, followed by
> >     one parity bit.
> >   - Whenever you're writing, the master then sends the data over 8
> >     bits, followed once again by a parity bit. Then, and only then, an
> >     ACK is issued by the slave.
> >   - Whenever you're reading, the master then clocks SDL and the slave
> >     drives SDA for 8 bits plus 1 parity bit. If there was some kind of
> >     error, the slave will pull SDA up for 9 cycles, resulting in a
> >     parity error. Like with I2C though, since it is the only and last
> >     byte it's receiving, the master won't issue an ACK.
> >=20
> > Obviously, to go ahead with the PMIC support, we need to support this
> > controller and bus first. I can't really decide whether it's within
> > the scope of the allowed protocol deviations of I2C or if we should
> > create a whole new bus for it.
>=20
> I've been thinking about this too. In the mean time I have slept quite a
> few nights on this now and swung my opinion from use i2c subsys to do our
> own bus and back again. But since I've actually added support for this
> to u-boot and I now know the device better I believe using the i2c
> subsys is the best solution for this.
>=20
> The PMIC does seem to start in i2c, and then gets switched to this new
> push-pull 2 wire i2c-ish protocol on init. So it does have a slave addres=
s,
> but that is used only once, and then the bus is for a single device only.
>=20
> Note there seems to be no way to use the host in a regular i2c mode. It h=
as
> a setup mode where it does a single regular i2c write (or so I believe) a=
nd
> then it is in its own custom mode from there on.

Well, in theory, you could. It has a register where you can control
the levels of SDA and SCL, so you could bitbang the bus using
them. But I'm not sure we want to do that :)

> So what we really have is a single slave i2c host sort of. At least
> we could model it like that. The host could be told which address to
> listen to (and which single i2c write to do to init the pmic) through
> devicetree and then all the differences would be hidden in the host
> driver, ie we would check the slave-address and if it is not the single
> one we support, we just return the appropriate error for a device not
> acking, and everything should work as a regular i2c host which
> only supports i2c_smbus_read_byte and i2c_smbus_write_byte.
>=20
> IOW the i2c_algorithm struct for the host would not set master_xfer,
> only smbus_xfer and its functionality function would return
> I2C_FUNC_SMBUS_BYTE

Yep, it would make sense.

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--SNIs70sCzqvszXB4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTPpw3AAoJEBx+YmzsjxAgcawP/0+0lKWMYaFlFnMqMMrDXicm
cjAsG0LwYezSpcPTpWM6Ufz5t63lzmXk7IO4g6Aq1BgSQ5zdSNoseW3Apprx3Rzo
YETaM5+Q85H4cnwwg2COyRXXkmxCnjtJ2dvr1tH7sq88vFUKAvkNhW0TBxFJ7aUe
yFm6NiIC0uNaZWgM6nYKJyx+vYIX8mg8KgdCd6JfMHnOG/kYgCBya3zOXDv34Wgy
awb0OMdxzlsem+BorKjxi+pLXXf+L5hsPWcfi05A7RNI5Mm5iTKqGiB3VHzUMOdR
P/zT4fOlZCJz/90/X1nRrnYLKr5LAA38AovH7J8BMubhcNnO8BqvsMSMTTBzlV2A
VQ2ncPWObG2fiNiJRfgy9e+G1HyIIUft/u4czodePIbZbqVRUN1SMLrdMtWgNJb9
z4EjNIGDtFZD1WO9VyadNYIk+VyZHnwUqC8OMf7xFKEtEy+ZfrDnPOKdyINfffJf
1OzjRPTCAEoRYDZpozRIPbfegy2DFb+ZQg0lvb1lBgwdJeoqv27cmyi/dxg7A8uh
mSRZmfErK0GBUNX06QjOJrLarotfolmGEqcEk7Rqu/OWFBTbHIiwD7KjoplRdtsV
lLk1yGrVkSQ94wOgTKeXyADpcIyzQsAeQ2Ve30WaQoOKQA/R9qAMtYW1Fh4F6+NV
PtNRCjji6uOd0PA/CB1i
=JvIK
-----END PGP SIGNATURE-----

--SNIs70sCzqvszXB4--
