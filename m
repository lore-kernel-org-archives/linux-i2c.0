From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: Mark instantiated device nodes with OF_POPULATE
Date: Wed, 22 Apr 2015 09:40:19 +0200
Message-ID: <20150422074019.GA1511@katana>
References: <1422083789-18905-1-git-send-email-pantelis.antoniou@konsulko.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1422083789-18905-1-git-send-email-pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 24, 2015 at 09:16:29AM +0200, Pantelis Antoniou wrote:
> Mark (and unmark) device nodes with the POPULATE flag as appropriate.
> This is required to avoid multi probing when using I2C and device
> overlays containing a mux.
> This patch is also more careful with the release of the adapter device
> which caused a deadlock with muxes, and does not break the build
> on !OF since the node flag accessors are not defined then.
>=20
> Signed-off-by: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>

Now, that the dependency is upstream: applied to for-current, thanks!


--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVN1BjAAoJEBQN5MwUoCm2BpcQAJFIyyKQohNqnCruePHQHKJQ
Ogdei8do3/ZTmGmLbI807YwflQOIxkMlJqhaA5h4+joGXCRKIQ2ebmkg3y/iPAkh
rtaM4wvpCxxbk3Q49k5d9zCtTGpNxnpY8jm4co5fw1Dvfq0bQra0jJWjy10hiPH+
5NxdN+6qCmFBdLz6Qy9vH/iEG+nY7usKUlAJpkBgCtTaXPFsGykFP92DoFBr5FyI
Ky0RN63VPwIEcYIZ2aR5Ys8x2eCJMW8qBr4YAQU5nXwyZil9JFohUprHHu/Oumpd
auDQ67gREEXE962G5V2rwI2/NK9VkLMTeVDWDJmTNlxKiKC0NzTKFVbbSP3XNmiV
BTQIowSNWHxSo6mztHqlBxP8u8/hiph6emfp0XfUN4PnekVa3UK226xs6XskK9Rp
I3lziBdwcSv7uxeKrp9OJuw9B0j/J0Trpa2kmOB1dtJlIp4FdcvfiXU5NC6wPUoC
6jBHVnRJxOlPOfXbGu+VbH08v6NRy9UzaJAEVIoSN/HuLzd55AFGqHF6dnam/gS7
+oZ3r2Roa/gkPvsTheEB5f9I+DmHppv4RxqZBbdWR5bimnN7XUpQl9JLYCLjMxmX
BDKAxHj/wXhfK7sNEE6G1Sj3kSrXzvZWLZ3CaHQ7+9AoPwCCmJ4oMfWEPoWYchho
KRm+L6d0qsxbxCz+y0/m
=pEzW
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
