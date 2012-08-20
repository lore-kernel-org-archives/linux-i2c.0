From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [PATCH] i2c-i801: Add device tree support
Date: Mon, 20 Aug 2012 09:13:06 +0200
Message-ID: <20120820071306.GA2409@avionic-0098.mockup.avionic-design.de>
References: <1344409609-1904-1-git-send-email-thierry.reding@avionic-design.de>
 <20120818094846.GA24812@pengutronix.de>
 <20120818111745.GA15702@avionic-0098.mockup.avionic-design.de>
 <20120818121628.GB12839@pengutronix.de>
 <20120818123527.GA28701@avionic-0098.adnet.avionic-design.de>
 <20120818190152.GE19802@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120818190152.GE19802-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 18, 2012 at 09:01:52PM +0200, Wolfram Sang wrote:
>=20
> > > I thought to recall that busses which can be probed at runtime should
> > > not have nodes but should be probed. Maybe that was wrong. Can you po=
int
> > > me to a dts-file with an example?
> >=20
> > That approach doesn't work for I2C controllers, though because you
> > couldn't attach an slaves to them. The same goes for SPI controllers or
> > any other dumb busses that can't be probed.
>=20
> I understand the problem. I was wondering how it has been solved. Thanks
> for the pointer, I got the idea now.
>=20
> > arch/x86/platform/ce4100/falconfalls.dts is an example for an X86
> > platform where PCI devices have associated device tree nodes.
>=20
> Do you intend to send a dts file mainline which needs the patch you sent?

Yes. I have an x86 platform which has an lm63 temperature sensor
connected to the i801. There are a couple of loose ends that I need to
take care of before I can send the DTS. I can send it for reference, but
it won't be of much use because other things are still missing from the
kernel and I don't know in what timeframe they can be applied.

Thierry

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQMeOCAAoJEN0jrNd/PrOhdIoQAJpLYLtD66Q2pYMOsdSJOcTv
16qyRev7xDoXX30bhzlbBqOv3BsnPrDcMEMr5jcgM6GYNb91N7HzH//QV1sNBsoY
UZmbrvrYutW77u+avvn8tLIC6Cg8wIfl50tqLGzksE08DQX8OTVw73co/EZoo924
2sF7NmIJlLXs007zaHAk3ftS4Xtj6aVnARy8I88TLIJgXLMsdtbr7MdG9aKPCuHd
hiyDsgFaHfaXEBsUFvKtOpPDulNt36ecL2bQCmqTur/OaZm795/6sJh5ZqzQfHbd
x0gt+ZhrXZ4jRa4IfKg/laCHhy76VHI0J9R5KvPaZEf/9MXSVu93du4lwOguxV/K
WsWpUAI8ltbReC/QEPNseWhqNQNJlicRS28eyiSCazuQ8M1YRN7lp4L4UrYI3Y1t
PSceVladXZ885k1Fm1rhSgGMYQ3PAo+6MguxtBRNUFZX04ss4QnNCTiluoiL3v6D
rXcLIlosbYmY/vEGsk7P1D53bulTggiUkh+5prytI8tWz6ybEWHN3BmqiM1ZBWdp
T2nm4V9jK9zIlrfDrkKJi0PPq2xkoVop3D5vnwVXMUNzuVPhFlhL6lSw/TktX+nC
ySW6NuKkmwD5YikM87yv66ACdZg1Ys4zb7pWXZinKUpH0xA/o6eFLTfFnWbfxpH6
tc9mxAcDbdDEY9Dt/stT
=UuJ3
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
