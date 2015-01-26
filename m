From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: designware-baytrail: use proper Kconfig dependencies
Date: Mon, 26 Jan 2015 22:00:24 +0100
Message-ID: <20150126210024.GB28095@katana>
References: <1422290974-24561-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MW5yreqqjyrRcusr"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1422290974-24561-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: David Box <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, kbuild-all-JC7UmRfGjtg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2015 at 05:49:34PM +0100, Wolfram Sang wrote:
> IOSF_MBI depends on PCI, so we should not select it but depend on it.
> This ensures also we compile on X86 only, other archs will break because
> of an arch specific include. Also depend on ACPI since this driver uses
> it.
>=20
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Applied to for-next, thanks!


--MW5yreqqjyrRcusr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUxqroAAoJEBQN5MwUoCm2emUP/jmCvvkE+AB9aKP92XdAxzLW
BnxYjldCMhRNSx4aIKXZd9kFZ1pAelbSyfOf/nnVWo2w2GaVKh9EakBe/fRe/D6+
O33lLDoolYCm7VZm/7Xetv2DstvwFU7xWpLqhp71FQetCqASooI5s02t44ndttoD
Fbfl1BLqxJF5Ml+ruJolFO3OE6rnfGwpYuuCcNMcAg6hB5awU4xmBqwgFQgiTtsG
bRudFdyfELQAH7yvGFH0bZPYC2xfjgohH/vfKOd0hs1Fis5JmjVc7gprZ8h8fvFR
QG9M6AlsEDRhXWU6xl3qhGUw3L8I3VeizVEOa8w96m8IdGyUSIzyhl7J9tELe9Nf
AN8fxYI6v4Xvi/INFJVshtsAogLSZtkkdz5KYBShFUByyxCy+r/UB5w0kyliaB5i
ot71Yz39uKNFYOosSh/Vjda21l23O5upziq9rBw8EXrRNlqSNHtFS3691RYo/VoB
l/loEHc+8ZUb/DJrhcaUzUNJFWnThPKF/JSUvMSdWnv31knbJKR8sH9Yj1zlazQv
gMH4AfAQK3EKPIdcIfvKrOrjnFYtZd+HGeJrxaPxZrDC3MvfYUDIpJ+ebM/ywaRn
lhNwEE1G78M/Lzig1PXL3fgUlcCuYBO14qCZnxkyFaqSED3Elmfn5x2hUGJ87JlX
iEAec1R9CLh+2EF8Zxho
=xL4u
-----END PGP SIGNATURE-----

--MW5yreqqjyrRcusr--
