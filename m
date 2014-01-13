From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [lm-sensors] I2C support for AMD Hudson-1
Date: Mon, 13 Jan 2014 14:04:26 +0100
Message-ID: <20140113130426.GG2586@katana>
References: <20131217063226.GD25105@phys.ethz.ch>
 <20131217180131.GB2840@roeck-us.net>
 <20131217181053.GE7071@katana>
 <20131220134349.GV25105@phys.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9Iq5ULCa7nGtWwZS"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131220134349.GV25105-vpGm2Noi6jeZvKxeG3EEhw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Herzog <herzog-vpGm2Noi6jeZvKxeG3EEhw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--9Iq5ULCa7nGtWwZS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2013 at 02:43:49PM +0100, Christian Herzog wrote:
> Dear list,
>=20
> thanks for your instructions. I slightly modified the driver so that it b=
uilds
> on 3.13-rc4. I can confirm that it works well. I also talked to the compa=
ny
> (www.men.de) that released the original patch and they would love to get =
it
> into the kernel. Please find attached the patch to i2c-piix4.c of 3.13-rc=
4.
> I also prepared a .tgz that contains
> - the original archive from men.de
> - my modified driver
> - the patch itself

Thanks for posting a patch known to work with a recent kernel. Yet, this
is way too intrusive. We need minimal changes in logical steps to get a
new feature supported. Ping to Jean for the details, x86 drivers are his
expertise.


--9Iq5ULCa7nGtWwZS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJS0+RaAAoJEBQN5MwUoCm2H5AQAJ4WuLF61gFZK9V0C94Z5EMO
Vbu0i/pimOoI2CmMedRdcqUNJHR4YiLZ5psmcal3iG6FxcHGqDE52TMl+Yq/tpqz
rUEfdSaa9k2WOUG2+pfxMzvTLZELNk0owvODGx0k2QU/pkl4UfcuBStwpzMfcxuR
eJT9sIqrgmpLHRYdhOoHA7DQ67+rSaTNROzBK93276famtTQmQ+7X/QcI2IDoip3
Q1NLYN0cTXK2ex/7pHzBuU+UrprMedTzb1En9sa1FIjAoQW5jsh8GU7Q1i+cFCNU
5m6o+7quqgdKaXQyTGlhm4ZCPTUls5zWE2tBM8raWw1F2+wU55ju36rEqc1ikv4T
VkBO5/grqUWeYSvn/PwDKcJ/xdTKbBDIznETJ+PxuehpCb3rLGIjxjiMh8kFGGki
EHFlACZYMR9h9oeXamAmQUukZ7j/oVno/NwG9fiLfNxThvr7kklbCCGSb8NhWRua
oOKUezLh4DxDLomwFutH+KO3M5/eFcsj+Tm7WpgCdonnWsf8cits65pDKULAmjxg
KAo+14CrGonzurbI5Sfo4PwSA5PYqkGL0rB5Py2ofEJRx6ijbaUdaGznfKlS4xrC
Y18l+1LCIMgBrYJF2Ww1ESFPsp4Hc6+qtGS97mRnvTiGuQC0+eHtEfflpDwR6DmQ
E215jJ7WafipMhIE7u5i
=cYv9
-----END PGP SIGNATURE-----

--9Iq5ULCa7nGtWwZS--
