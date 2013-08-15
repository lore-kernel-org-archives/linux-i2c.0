From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/8] i2c: imx: use struct representing i2c clk{div, val}
 pair
Date: Thu, 15 Aug 2013 16:15:54 +0200
Message-ID: <20130815141554.GL17155@katana>
References: <1375866343-2074-1-git-send-email-b35083@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5VuzLDXibKSJvVYD"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1375866343-2074-1-git-send-email-b35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingchang Lu <b35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--5VuzLDXibKSJvVYD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2013 at 05:05:36PM +0800, Jingchang Lu wrote:
> using struct representing the i2c clk{div, val} pair would
> make the i2c_clk_div array more clear.
>=20
> Signed-off-by: Jingchang Lu <b35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Applied series to for-next, thanks! Please use --cover-letter next time.


--5VuzLDXibKSJvVYD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSDOKaAAoJEBQN5MwUoCm2gH0P/3VsXwl9ZIWkkzJRC13mEDsG
0GDxSvbjDWiTWAZ93jdgXJ8yUqzxLMCDiJzG6xT5nS7wMBHBGu0x+jyrFJtLS56h
a1LcEdORf4mjYwKb9D9S0zJi/Nw5QXtUUaVOXyFCcWgmdi87F36HuGuM84Hiwh/l
Dd3sW/rcpZGa+rb0QDlSz1qDTr0/u2IPd9+mh/EQq9cqjwdzt/et0+sfJOAUxl4I
4XR0g4l24YOtZ8vGC5ZCFe3qFvxTjpTQ70ItwAPi35go9hKVntlXEdIr34JBBpBu
J1csIFB8etIsoGlf8809kJmNfpQiYcSr8COrVUtUh/2NiSEU2QAfYuVVyYMb7hMB
mvYi+6ztYFkpdP9wJGyYxDBCfgk+m41tYZpxcUrwvgCwF3Edo63oCSplfOXKr5JN
TYgNJjCW5cui0Bp5FpYtV1T6cRKH9eBjeEPqq30yYsN8zh/yIvehnh4fi/n9E4bW
+XzH4F8tqDBIuO5uFnxAXKbX9Irtadh/kwjP+l517wys6pJ4Kcr0qgGopvpb9GOR
lCFKv0Hcx49xjsWYkLCPzftAZPTTboNEvZ2eFMOcrX4hUKvRD5f6fUtN/YCbiJpr
q9xPhudzyzkAZs4sV3ptQctfVXA4PACy/Mm/yXdlsb7dQH5kEyrBCxiuOX0/YK5N
Ee3Ls/C4ENBw9an4aERM
=vnJ4
-----END PGP SIGNATURE-----

--5VuzLDXibKSJvVYD--
