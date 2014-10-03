From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3 2/3] i2c: hix5hd2: add i2c controller driver
Date: Fri, 3 Oct 2014 14:09:26 +0200
Message-ID: <20141003120926.GF1349@katana>
References: <1412079628-6316-1-git-send-email-zhangfei.gao@linaro.org>
 <1412079628-6316-3-git-send-email-zhangfei.gao@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0rSojgWGcpz+ezC3"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1412079628-6316-3-git-send-email-zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, haifeng.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jchxue-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Yan <sledge.yanwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--0rSojgWGcpz+ezC3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 30, 2014 at 08:20:27PM +0800, Zhangfei Gao wrote:
> From: Wei Yan <sledge.yanwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>=20
> I2C drivers for hix5hd2 soc series, including following chipset
> Hi3716CV200, Hi3719CV100, Hi3718CV100, Hi3719MV100, Hi3718MV100.
>=20
> Signed-off-by: Wei Yan <sledge.yanwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Looks good to me. You probably want to have a look at this patch
http://patchwork.ozlabs.org/patch/394648/

an do something similar here, I guess.

BTW what tests have you performed?

Thanks,

   Wolfram


--0rSojgWGcpz+ezC3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJULpH2AAoJEBQN5MwUoCm277cQALC8EZrzQ1wtmwAK3mNAIh6i
QkP2wzXAdpG+VDYzBPSmBiaenbh9AI+hDKnbGhu+l/q1kBQy7mr/lwVfRgx/vL0m
jCOOAAT1IOXqU3s5Pb6Z7Ri7MCyhKBfhyteTV+OdMTUMNF+X/KiUknFsLz4gTQU7
YHuQErswjuLDNfYTY61k34JyXYAm7b1lMR/WWXq44oHPb/SdJWzBClrt0VRjmJ63
YBPUojwWyj8YOtUhO7GhV+ziZsQbwNILltKioZ0lOKWczCdSb0bH5A1blRwAQXpn
bSYqMr+4l4uhyZsJF3yXg/Ynhu+ctrhOgc6D2DXMln43qI9qwrJfOdy6Rnqjvojw
8GWDN4taTvF6DMmdRoOg+YNZMw7HwnSbPQ6A9MbaSZNTOCZfHhXUqgRxFhfMoGq1
A8nYFh6yZ9e5IquttAULAuBSrU2ii/UATJT45eoz+XkkU8DXZ2jyHyKPssWtkXJP
Z1WvaI3fhDGXukX0WhWUylNOPEDjCdCsS+W2f2V5x3IdPyziwkUX3XmppHmIoZ/g
+por2S0+Bwqh2apPppZMMs5Iy0KR98m4H2Nkud8adI4LrQdE876b2zy4e7mBjBpO
Wlz7xBcP9Fkk8zhQJYwysIfSHPNcmPz6UpBlebEI0zDQudF0r4nL0mxT91zTRoI0
og1w4D6TNH8dXyd7IJC9
=Igv+
-----END PGP SIGNATURE-----

--0rSojgWGcpz+ezC3--
