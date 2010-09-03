From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [MeeGo-Dev][PATCH] Topcliff: Update PCH_I2C driver to 2.6.35
Date: Fri, 3 Sep 2010 14:26:20 +0200
Message-ID: <20100903122619.GC4813@pengutronix.de>
References: <4C80CBC0.5050908@dsn.okisemi.com>
 <20100903133613.1c519c49@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100903133613.1c519c49-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Masayuki Ohtak <masa-korg-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>, "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, srinidhi kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, andrew.chih.howe.khor-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, arjan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Tomoya MORINAGA <morinaga526-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 03, 2010 at 01:36:13PM +0100, Alan Cox wrote:
> > +config PCH_I2C_CH_COUNT
> > +	int "PCH I2C the number of channel count"
> > +	range 1 2
> > +	depends on PCH_I2C
> > +	help
> > +	  This driver is for PCH(Platform controller Hub) I2C of Topcliff whi=
ch
> > +	  is an IOH(Input/Output Hub) for x86 embedded processor.
> > +	  The number of I2C buses/channels supported by the PCH I2C controlle=
r.
> > +	  PCH I2C of Topcliff supports only one channel.
>=20
> These sort of settings need to be runtime so one kernel can be built for
> many platform variants. In this case if I understand correctly the
> current device only has one channel so the define could just be moved
> into the driver for now and made a variable later as/when/if new hardware
> with more channels appears.
>=20
>=20
>=20
> > +static s32 pch_wait_for_xfer_complete(struct i2c_algo_pch_data *adap)
> > +{
> > +	s32 ret;
> > +	ret =3D wait_event_interruptible_timeout(pch_event,
> > +			(adap->pch_event_flag !=3D 0), msecs_to_jiffies(50));
> > +	if (ret < 0) {
> > +		pch_err(adap, "timeout: %x\n", adap->pch_event_flag);
> > +		return ret;
> > +	}
>=20
> You are reporting a timeout when _interruptible can also be woken by a
> signal to the process (eg the user hitting ^C)

Sidenote: a number of embedded drivers decided to switch to
wait_event_timeout() recently because reacting to a signal may have
subtle issues and must be carefully implemented and tested. Stalled
busses were often the consequence. I don't know if this applies here but
better keep it in mind.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyA6WsACgkQD27XaX1/VRvuegCePEjeDK6jbUpGowZEgn4sypLr
SF0An3IpzLGC7sR79cqh3JN8jUABMu3P
=0AiJ
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--
