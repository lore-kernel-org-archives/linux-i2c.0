From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH RESEND V4 1/4] i2c: busses: add SLIMpro I2C device driver
 on APM X-Gene platform
Date: Tue, 12 May 2015 22:11:31 +0200
Message-ID: <20150512201131.GH4449@schokonusskuchen.bad>
References: <1429913873-13627-1-git-send-email-fkan@apm.com>
 <1429913873-13627-2-git-send-email-fkan@apm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8/pVXlBMPtxfSuJG"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1429913873-13627-2-git-send-email-fkan-qTEPVZfXA3Y@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Feng Kan <fkan-qTEPVZfXA3Y@public.gmane.org>
Cc: patches-qTEPVZfXA3Y@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hieu Le <hnle-qTEPVZfXA3Y@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--8/pVXlBMPtxfSuJG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2015 at 03:17:50PM -0700, Feng Kan wrote:
> Add SLIMpro I2C device driver on APM X-Gene platform. This I2C
> device driver use the SLIMpro Mailbox driver to tunnel message to
> the SLIMpro coprocessor to do the work of accessing I2C components.
>=20
> Signed-off-by: Feng Kan <fkan-qTEPVZfXA3Y@public.gmane.org>
> Signed-off-by: Hieu Le <hnle-qTEPVZfXA3Y@public.gmane.org>

Applied to for-next, thanks!

One comment though:

> +	adapter->class =3D I2C_CLASS_HWMON;

Since you have DT and ACPI, you most likely won't need that, or?
It speeds up boot time if you don't use classes. Send me an incremental
patch if you want to change this.


--8/pVXlBMPtxfSuJG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJVUl5zAAoJEBQN5MwUoCm2rxAQALRJ13LIgj+Vutdxq/tSL9qT
+NfmJgcrErvO9u9q5b7CnpA+uaJdWhWbVIkeocoZX10UjqZqa+Y+hCiFHgAom1nQ
+ek5bU+F3kfQLrxnlxuG9vikNgPnwEOGDj98dzeHhO9QpgcnwKPqLwiJcWPm26Fo
P/jm2Wm4sjZ6WryblbADDinDpSEIkQP3NCvO0hki9zN4+d+CyyVkEzxhtFFs3ZQW
lKFPnOqC5PaXt72fQ9bMljloW8OfaJfbUefanMeplFAnb4t6WF2GvTIvVzrvA1ls
LKiByg+eCr4zOBUAKWD5N8iqVGRbRevtjvAE/9znwgYNmgOW9bz2c8o3+XB2UR0y
AZw5ZzYMiR6pDhYE1Gthj6qXQA4a8YibR7DLceXjIxNkMRsIA7wlx1JbOTvimx9b
Y/M0ani6IpjIssmvObvhTZeL7KxNfbwm88L/iFW3tTWKpJQPLo/Dx1QZafVQC5Xx
E6tl+hxEd4aHb8rRkEBgWz9SFH7ya+AttvlqphxIUDW+dLotrPntStgjPRNh+oyl
W9f2G1a4l/Ue79JVhWD1+6HuVBZyMgBGwqLZsBfgIrEGPxUTRVeDvM8IIFC+r/ZQ
sN7byU5Jx5VSkEvgaQhz1s+ejBGxBbJ56fdIwf56Tz/jFXKr7io64KhWtPM3nD6N
/0hKhuyPcti0XnLLDvXL
=CE6d
-----END PGP SIGNATURE-----

--8/pVXlBMPtxfSuJG--
