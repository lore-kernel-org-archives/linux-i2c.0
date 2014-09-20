From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: designware: Add support for AMD I2C controller
Date: Sat, 20 Sep 2014 11:36:34 +0200
Message-ID: <20140920093633.GG1612@katana>
References: <1411032367-20274-1-git-send-email-mika.westerberg@linux.intel.com>
 <1411032367-20274-2-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="64j1qyTOoGvYcHb1"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1411032367-20274-2-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Carl Peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--64j1qyTOoGvYcHb1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2014 at 12:26:07PM +0300, Mika Westerberg wrote:
> From: Carl Peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>=20
> Add support for AMD version of the DW I2C host controller. The device is
> enumerated from ACPI namespace with ACPI ID AMD0010. Because the core
> driver needs an input source clock, and this is not an Intel LPSS device
> where clocks are provided through drivers/acpi/acpi_lpss.c, we register t=
he
> clock ourselves if the clock rate is given in ->driver_data.
>=20
> Signed-off-by: Carl Peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---

Applied to for-next, still wondering...

>  drivers/i2c/busses/Kconfig                  |  1 +
>  drivers/i2c/busses/i2c-designware-platdrv.c | 27 +++++++++++++++++++++++=
++++
>  2 files changed, 28 insertions(+)
>=20
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 2ac87fa3058d..9384498ef3c1 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -422,6 +422,7 @@ config I2C_DESIGNWARE_CORE
> =20
>  config I2C_DESIGNWARE_PLATFORM
>  	tristate "Synopsys DesignWare Platform"
> +	depends on COMMON_CLK

=2E.. do all previous users have COMMON_CLK?


--64j1qyTOoGvYcHb1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUHUqhAAoJEBQN5MwUoCm28Z8P/j/yv4fxelCtpC5LP/lFmTW5
LEVC5GlOrdGrFxqJgJ4Rcoi4s8yiUE3M2hNF/4EcehAIWg9JQITZfiIZJrtOybZI
EFSJk+iTqVOjgHyhlenS4+EjeP4tUkG6pZUByFTB/tchhBnMnT4gfQGf3dukCYTM
V9nxPnAfrETIGDwpvg/bfDIyV/6BDZlWLYP/GcMkL1DQ/e7T7y9Xi4l99jqZg+cR
MxBQhXzA45lqHnXRAM0bfWsxK5OUlu4OI+wpzwrSu6GkhpPXCltjvJjy9O4Bzr40
U77Mf6all9fZESUouGdlcHvrSJdlMA/Qla1APoSKr+ENiduJ4kmJNXhzNw4FPiwG
hN9OcIFquCDhm2Fo3HyFMNc8BCIW4rcCj+MxfVsLPsY1C7qlTVuGsVXfHbmuh6m/
HAb09h4Zo5fpcBYk2bb+pYZh/fuL/MaQf0AscmpCSxAOevkxN/dUxf2Be+Lgz42C
4C5ZmRQbrIhjDVFtaYdgg767Jq+4vIvTXhrWLeTvsIvDXpXMWLqvSVGV/AvD9+9z
BeggEQjVrPuS//Jf+CDtOqWKIJQgnm+GhmYKQQ/jBILNPjM4z21E5pQw4rlbuSM3
r8zoMwJrMNuNsfE6h7+uMyQhP/JRuJMYUdvJobr+YHgqV+IfB7zHty/rmPyTEdg2
RMVga6c5OylYIjbXVQay
=5z4+
-----END PGP SIGNATURE-----

--64j1qyTOoGvYcHb1--
