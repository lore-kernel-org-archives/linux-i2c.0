From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH-v4 00/11] i2c: pxa: Fixes, cleanup and support for pxa910
 family
Date: Tue, 14 Jul 2015 13:34:36 +0200
Message-ID: <20150714113436.GD1517@katana>
References: <1436859410-28878-1-git-send-email-vaibhav.hiremath@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ycz6tD7Th1CMF4v7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436859410-28878-1-git-send-email-vaibhav.hiremath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Cc: linux-i2c@vger.kernel.org, robh+dt@kernel.org, robert.jarzmik@free.fr, yizhang@marvell.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--Ycz6tD7Th1CMF4v7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2015 at 01:06:39PM +0530, Vaibhav Hiremath wrote:
> This patch series fixes bugs/warnings, cleans up the code and adds
> support for PXA910 family of devices to PXA I2C bus driver.
>=20
> There has been one attempt made sometime back in 2012 to upstream
> some of the patches from below list, but did not get follow up later.
> I have consolidated all the patches, cleaned them up, splited into
> logical changes, added new patches and submitting it now.
>=20
> I tried to maintain authorship & Signoff except where I did some
> significant changes to the code/logic.

So, I applied patches 1-6 to for-next to make some progress.

The others need more thought because of the bindings which shall be
discussed replying to the patches in question.

Thanks for the updated work with lots of proper references.


--Ycz6tD7Th1CMF4v7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVpPPLAAoJEBQN5MwUoCm2NL8QAKXE9Qa9yJdAV2/MMCmStjw9
dudYnRX3IVIBCBo3t/ZfPzycobeBnCxcHHevkiBdFBIQjpqAHqdCc2BUfnwsuIZj
WrnXjzkIU6yW2aErg+3g7hrI2pGFOW9OTh+KaBXhfZhumpI1mhglCt0VdavpRc+Z
Bzrego23Ev86YdAnrdMNK+POHwC2G3ahBWo9Yn64gmWOkrV1DaR9PC55BwbN5ywk
t8QCW//cRlOq1BmPuqPN98hdZb1fInFhbndsGRhy3ZKz+ePZ6MXppMhtSFq6N1GM
bpbqUtyuEJ7yvZW/g2YaqK0WvupdcLe9DahKKY0JkYyG+Yff0wfNroFFpVVonb0d
toFCZMypisF98v8lhYQOLV1XaVfxoiDlsPHHA96K1sKD6WW9Xf18Wr50J/D+8v1w
fbB4aV0cVBzUvBNOsNbacfz9aAIq1Qck7nE1KuyVie27rNSt0viLGil5oB3ooaIM
rA+q8bVlVn63qRwETEzMnFPNvdl+N4VTQhXunx+RvCuDsJHDFyXu5SCUAs4WMgmB
9ecZJlkWrj1ZDOkzlqfs5leW2Y7MvZR3B2NdqHZRbPRH+1E4gt9rz4Vnx5walL/o
kWsb9IQBAwL/VI7Y4gU+++uHJRI5QrFpNnjQ7BCZqL1HYubus3sYOhlGMaFfar4z
B8A2LMOMuwv7JXITi5Sx
=Qyuc
-----END PGP SIGNATURE-----

--Ycz6tD7Th1CMF4v7--
