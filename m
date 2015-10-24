From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 1/2] acpi: add acpi_preset_companion() stub
Date: Sat, 24 Oct 2015 18:41:24 +0200
Message-ID: <20151024164123.GA1583@katana>
References: <1439510358-16664-1-git-send-email-dustin@cumulusnetworks.com>
 <1445628427-29244-1-git-send-email-dustin@cumulusnetworks.com>
 <1445628427-29244-2-git-send-email-dustin@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445628427-29244-2-git-send-email-dustin@cumulusnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dustin Byford <dustin@cumulusnetworks.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jean Delvare <jdelvare@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, rjw@rjwysocki.net, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Puustinen, Ismo" <ismo.puustinen@intel.com>
List-Id: linux-i2c@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2015 at 12:27:06PM -0700, Dustin Byford wrote:
> Add a stub for acpi_preset_companion().  Fixes build failures when
> acpi_preset_companion() is used and CONFIG_ACPI is not set.
>=20
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Dustin Byford <dustin@cumulusnetworks.com>

Waiting for Rafael's ack here...

> ---
>  include/linux/acpi.h | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 43856d1..43b55e7 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -477,6 +477,11 @@ static inline bool has_acpi_companion(struct device =
*dev)
>  	return false;
>  }
> =20
> +static inline void acpi_preset_companion(struct device *dev,
> +					 struct acpi_device *parent, u64 addr)
> +{
> +}
> +
>  static inline const char *acpi_dev_name(struct acpi_device *adev)
>  {
>  	return NULL;
> --=20
> 2.1.4
>=20

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWK7SzAAoJEBQN5MwUoCm2mO8P/igm83/IA0242UaLxcQHFKdP
F0pLetqWS0miTkl0pJWUlSubnmkPJjGmTqCAZpUuKdxpBhTYOcj54aBLyhsSbWwW
EiiaXEUAytKmUDEvfHdeWD8QI8XlJCvIDT2mc/sOdYt+yyukNBgHGOvbcx1iEjwe
YjwZaMp2TRMqbgBOSHvmq7vTf5P6mLC27F2G4+5CHR4MW9wLXRUnLWM+BHW6xaTE
GBv6pmTUXYp1Rulp19PgqJy86CsB+OuM0MyADQ/miJt0cU5UxpjoNiZHwV3wvQou
s+sCMgSUg1Ya+jxATRdEt+DoTWVD+0cdqxbaWiWfZTaWOq4gVMXCetHL6sze3FIg
qkH4z2QYysoyP2+JEDDTlvf1Wy18xtqpM0X5uv2P9oFvv6NW3HHLxF3hX+yZaE0v
OL6Ffx4pLElZEihKkeCqLgLc9YZiU8V6pjK6XxXqImqh8Bv5JNTj23YAJlPEhqnW
pldqvfSgvGSHn6tEfgOmOE+CcN+cnSJ2tm4u9N+yGaZzNWeDUWMkPaOdXmggYONr
PNBFZMytLF5/Ygen7HmLdHY/QTGIP8wyWalrQ8clbYGI1GKWYOvXxBoxYLhHZYhQ
+g38VY+GyNX8hQm8iL0uNjL6Iyr99Vg79b6bp8nh8X3LglFlbQS7nEiHVNE2CfrH
koeK2n1uCqldEgOg4Iy2
=qQp3
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
