From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: Mark instantiated device nodes with OF_POPULATE
Date: Tue, 13 Jan 2015 13:05:30 +0100
Message-ID: <20150113120530.GF7660@katana>
References: <1421082094-10267-1-git-send-email-pantelis.antoniou@konsulko.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MZf7D3rAEoQgPanC"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1421082094-10267-1-git-send-email-pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--MZf7D3rAEoQgPanC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2015 at 07:01:34PM +0200, Pantelis Antoniou wrote:
> Mark (and unmark) device nodes with the POPULATE flag as appropriate.
> This is required to avoid multi probing when using I2C and device
> overlays containing a mux.
>=20
> Signed-off-by: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>

Looks good. I'd think this is 3.19 material?


--MZf7D3rAEoQgPanC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtQoKAAoJEBQN5MwUoCm2610P/0p6i6e6VKHQHbBqVNDV72zg
rVmFgwWfxshTAN1hi9UJVcxZY02BaMC3301e48kBC1FvePcFCFQNm/ah80D6j8VJ
77quvBN1MAuq0KxydmnZN1qjswNg6yJbiLxlIofP0EQBx+EFW5d9U016bH6nvYWZ
tiVIFtKCtsrzOqgnovpWkK6LmzROLhVNaFwlLjFEqps3wCcpu++36OUQhNQ+EZiD
+AJNf28U+a6wp9BiNia8Bd6SWotxmy6r4p9/Nus3c7HMRN5P+zti5YHHTcFAAoNT
2X8tN105C4TlBdTNn1Lwa88PHayzJg6wHcogxnNwOhvpzSWxvgXUWkPWu4a0z8Vs
3GpNNKqEsQLiMWntex3KMsXbyIw7bdiDI0jB1aSV2A4eo1VLg2KkQOGSj29zScDt
c91pCAhqVnJrsW6D9SQFES1IxslMaAFHSjVGXp+XrILUWqsSIeRXwC6qAEpbWUdU
s1hNxDUM0qIczmSsf4fOX8P3wKZba0x4qJtnmuPAzq+JANdcyAayZIejns/tmF+8
ZePqd9HoaZtZ3zH4mWtM/IUphRxe1MIOpB8rNOBkNT2e3pkDul/+PADYjFdyY7EJ
g+PtFQT8zCiy84zoa/owdhGErSiL96v2pD+dvzrZUdaG0BwqRzgmlVjt21PlncYD
oJcXkDahndIQxjooELwC
=y0RB
-----END PGP SIGNATURE-----

--MZf7D3rAEoQgPanC--
