From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: designware-pci: Add Baytrail PCI IDs
Date: Sat, 15 Feb 2014 16:27:37 +0100
Message-ID: <20140215152736.GF2579@katana>
References: <1391524279-23409-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HCdXmnRlPgeNBad2"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1391524279-23409-1-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--HCdXmnRlPgeNBad2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 04, 2014 at 04:31:19PM +0200, Mika Westerberg wrote:
> Intel Baytrail I2C controllers can be enumerated from PCI as well as from
> ACPI. In order to support this add the Baytrail PCI IDs to the driver.
>=20
> Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Basically fine, one question:

> -	snprintf(adap->name, sizeof(adap->name), "i2c-designware-pci-%d",
> -		adap->nr);
> +
> +	if (adap->nr < 0)
> +		snprintf(adap->name, sizeof(adap->name), "i2c-designware-pci");
> +	else
> +		snprintf(adap->name, sizeof(adap->name),
> +			 "i2c-designware-pci-%d", adap->nr);

Maybe we just drop the "-%d" suffix entirely?


--HCdXmnRlPgeNBad2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJS/4doAAoJEBQN5MwUoCm2GB8P/j9VCAviKxfPzMl1/+dAV7nD
qTbdMaUTqSN3hSiBFGEbYnSr8r2rJeliJGW9h/Hr2UjmtRky9SqXSV2lscenPOjM
fqKOBUsvsbiqNcl40XhvSdqVA9n4KXW+5BXAUXCMSzzuZkafjy7vn3jyiWflavdK
YNIP30fyIm4afPEONhBA+Wu/rsVnc9dnWdgmLe9sZsezSjSYB/c4zTqpScqgi9Py
doLWbA/phExjqpunI5/v9arDRDi/ac75L6rwbIdkmEMqyARXpjgvwAPDwG/s8ugT
ml7IU3EcvSYIxBqh9L1pg2Gi7rlSTRPjrboA2H4CRGZYhqzA6Tt/lkKVarUDHg1x
TsvNW3QXWLGYme8EHT30o+6gEa6uxe3+974MhdXPzmczDw2u9M3AkVUTA15mCiEr
RrIiifQgeuowZig8hCKrXdiy+lfkCpM82EZQac98r2vA/PN0OqfSzQ/9TfjndAYN
tJJP0HyVNQYnNonvtyvGP1sfZbB4X575zDSY8K2iaAVoq1w1V+iuh6qPLnhY41TW
sGpT4FKoupofmds3Xkashi0HuuPbszJR57lvdBiAJLtWDSc0xeR3ZX73c+ZgLqad
fveVVnVhZBlI5u3y0Lg9BCnwK9pSncSkvYxukz0Z/497OncgBS6zK5Ls12ca9Ju0
Tc3c4FAIXbOWSRSwvMEe
=1GZm
-----END PGP SIGNATURE-----

--HCdXmnRlPgeNBad2--
