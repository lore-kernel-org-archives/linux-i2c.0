From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: acpi: remove unneeded variable initialization
Date: Tue, 18 Nov 2014 16:05:37 +0100
Message-ID: <20141118150537.GB30004@katana>
References: <1416319963-28946-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1416319963-28946-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2014 at 03:12:43PM +0100, Wolfram Sang wrote:
> No need to initialize 'ret' if it gets assigned directly after that.
>=20
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Applied to for-next, thanks!


--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUa2BBAAoJEBQN5MwUoCm2mqgP/jM1v05aTSD0JNnkYFBREL3S
koYmdfIqj9+fpx1KGrdemShBik7L4KykTUWg8mdxh0fGU76FfFqc/BBrLnXI0ni+
wfoqYOfIhxmyvJRoegFRaSUEjD3FqWQBIBdUT0kH4DkNXyb0aJe52ZDZNXf6DWE0
MfRMeD9BMA10QB50P5tOVnVWN99/W3T8eqK5nLaVf/opScvnyMsBPVuye90GunWM
7ZUyh5UQSHW0uga194D44FszsvxWHWB6vQn9PItceiM1JlAhYhTtvuVAdNXXYBGY
Od2HsAIXSAXJcpx2Y39PwLur9e3eJ1MahIvOF4aj3LFqGRwPKJGhpd3gpEcsRtHB
UM3e4tw5v0v7ufHdvWammGcrsS8/+HmiK7Z8tZHdXMLS5K+oSo1ALJ7G6RXcWwqo
kT5/soF1ap+XxuzOxcB/IQuauuvu0J1XfnJcBmWbR6Ak4O3sYeCJqs8s5ihiuZ/u
37MxnkGykZuk3PysB9hZLfd7qtMfiVtS8VoSI3Cv774kL2GH1A3PxezgvhI0KYAQ
6chJhJehLWuKVU5Yt0XpBlsUfqgalEVhBKpooQZuJRpREpL/ROKy0nVB8kY1Cf30
jEPyCEMFukLxa9iIokLbjkKzyWvcBpPtSHBqSpbt2g8/3uqyOfLYY0+MawAYRLN+
20uvxtlMZXY5iUnPdVm1
=S1rv
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
