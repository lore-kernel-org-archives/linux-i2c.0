From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: remove obsolete cleanup for clientdata
Date: Tue, 24 Aug 2010 07:16:39 +0200
Message-ID: <20100824051639.GA436@pengutronix.de>
References: <1282575908-16555-1-git-send-email-w.sang@pengutronix.de> <AANLkTikupuVAhC9Dj-9QgDzMVBd6vfh5OjFXGsXnwnFK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikupuVAhC9Dj-9QgDzMVBd6vfh5OjFXGsXnwnFK-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Hemanth V <hemanthv-l0cyMroinI0@public.gmane.org>, Liam Girdwood <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Gortmaker <p_gortmaker-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Roy Zang <tie-fei.zang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Jingchang Lu <b22599-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Mingkai Hu <Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 23, 2010 at 05:58:17PM -0400, Mike Frysinger wrote:
> On Mon, Aug 23, 2010 at 11:05, Wolfram Sang <wrote:
> > A few new i2c-drivers came into the kernel which clear the clientdata-p=
ointer
> > on exit. This is obsolete meanwhile, so fix it and hope the word will s=
pread.
>=20
> on a related note, do we need to clear it when erroring at probe time
> ?  doesnt seem like that is necessary either ...

Correct, you don't have to. The core will do it.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkxzVbcACgkQD27XaX1/VRtUJACgpRoADMt+2wWflWiR16/XDxYx
BkIAoJeO0XtvOqgJn0ZHD420NJq89llw
=FzSa
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
