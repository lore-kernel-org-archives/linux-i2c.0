From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: Drop owner assignment from i2c_driver
Date: Sun, 2 Aug 2015 00:56:19 +0200
Message-ID: <20150801225619.GB1528@katana>
References: <1436507551-1370-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1436507551-1370-1-git-send-email-k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2015 at 02:52:31PM +0900, Krzysztof Kozlowski wrote:
> i2c_driver does not need to set an owner because i2c_register_driver()
> will set it.
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>=20

Applied to for-next, thanks!


--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVvU6TAAoJEBQN5MwUoCm2+RYQAIUdaCv91EuFqAXU6DY/Vywk
ACAsIwfWi4qmyzQ8m0q080WDNZj/gncVbWNTLgTIvO4J/R7KpfHqYGeVu+s6B9Ya
PMJ0WyLmba4i27EMUne1miaRKpoTD8JVW1HoLaNbGrLQU7KtbG0AgpSNbZGbPMtc
uhp7xBAmpLDjIgPEt9LVzsSDRbadebhW3nBT07XZ/baKAPr/PR3oxWIqtQ9lkgYS
VC2brb+5GNTYfuE2X4ex0gJzMK7Jfl3tjkut/Lor0TXrNIhdmhMC2FVBtxWzYzbB
GMXhBnLBfUcZL06gv8bcEVhT4SCk3Cal49TK0PoFbLm2lBKjejOBMG9mLBYChlon
AxRNVps0jkX8MMcfdxiJ/KDwVOR6OTCFh3RatbW9+cOD+KeQg5vW46BTyTuHL6I0
YfkrrnAdB2eIvMdNj4hKVz0N8cHjBl6NBAjyP4XXO1nKl681278pl9Cs87UkCIU5
4lkvzNkW68W6Hyw4/TZgv1G5ntj1mpBzd59Lq9ghzXyPti0BO37WsVgQzqpHDgqk
iaYYeiigdjYRx02N22YT8XqinM5Kl7k1nlWqpR6Hv6p3ixd3lHNuH2Do0rZ6zUtz
F4PxOfPYBYbUmmhcyLh2mIbbfHqssamkIbnVqlKnUVEp0MHrAIAuETUIDgLSOVzw
B6YrH5iBPp1vlH9l+DXl
=ZoXU
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--
