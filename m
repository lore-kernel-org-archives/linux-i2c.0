From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [RFC] misc/at24: add experimental OF support for the generic
	eeprom driver
Date: Fri, 9 Oct 2009 07:14:09 +0200
Message-ID: <20091009051409.GA2361@pengutronix.de>
References: <1255010672-21656-1-git-send-email-w.sang@pengutronix.de>
	<20091008143301.GA6084@oksana.dev.rtsoft.ru>
	<fa686aa40910080753v6f597b0h4ce835db9f7a653@mail.gmail.com>
	<20091008151007.GA21328@oksana.dev.rtsoft.ru>
	<fa686aa40910080848r459c47baob73fc70a95a08604@mail.gmail.com>
	<20091008202723.GA8116@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4963436087820861936=="
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20091008202723.GA8116@pengutronix.de>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org, linux-i2c@vger.kernel.org, linux-embedded@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--===============4963436087820861936==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Will check this tomorrow.

And while doing this and figuring the pro/cons of those methods, I stumbled=
 over this commit:

	gpio: pca953x: Get platform_data from OpenFirmware
	(1965d30356c1c65660ba3330927671cfe81acdd5)

It looks to me that it missed all people involved in OF/DT-development and =
now we
have undocumented and IMO questionable properties in the kernel.

Conclusions I draw:

a) we better solve the pdata-problem rather sooner than later ;)
b) we need to spread the word about devicetree-discuss
c) more documentation may help, too

I know, 'send patches'...

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrOxqEACgkQD27XaX1/VRtfIgCgxkVLjSvyhESdWX4zl30z7TVU
o+cAoIVf/pKmZnENA/PTqnZrKRSN+BqH
=6cNt
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--

--===============4963436087820861936==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@lists.ozlabs.org
https://lists.ozlabs.org/listinfo/linuxppc-dev
--===============4963436087820861936==--
