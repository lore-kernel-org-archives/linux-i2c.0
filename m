From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] Add support for SCCB devices into PXA27x I2C
 controller
Date: Mon, 24 Nov 2014 18:27:54 +0100
Message-ID: <20141124172753.GA25434@katana>
References: <54711397.9060601@tul.cz>
 <20141123083112.GA1932@katana>
 <54725DE2.9090800@tul.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54725DE2.9090800-qphu/3gb4gc@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Petr Cvek <petr.cvek-qphu/3gb4gc@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 23, 2014 at 11:21:22PM +0100, Petr Cvek wrote:

> I created this patch by fixing both I2C controller and SCCB device, so
> it seems I incorrectly used I2C_M_NOSTART instead I2C_M_STOP. Problem
> with I2C_M_STOP is that it causes bus freeze when using userspace
> utility "i2cget" on SCCB device (unfreeze can be done with i2c-pxa
> module reload). But this can be probably repaired in i2cget.

Please CC Jean Delvare, he maintains the I2C tools.

> Patched kernel was from vanilla 3.18.0-rc5 commit fc14f9c1272f62c3e8d01300f52467c0d9af50f9

Thanks but all these paragraphs describing the updates should have gone
below the "---" line. Your original commit message was more apropriate
and should have stayed.

>  static u32 i2c_pxa_functionality(struct i2c_adapter *adap)
>  {
> -	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL |
> +		I2C_FUNC_PROTOCOL_MANGLING | I2C_FUNC_NOSTART;

Okay, so NOSTART was previously implemented but not advertised? Please
update the commit log to say that this will be also fixed by your patch.


--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUc2qZAAoJEBQN5MwUoCm2A3wP/0nvzQfuXA2210jrfU92ejYV
geLt+iBMJYFiJUkviBF+ImqZEP/tFds5ROTS9VYNsbJmwmlzDbkgOhPEGlHFWp+4
n8GLFrNW/8sktELMommAieRhLkp7003MHZJ6uM/2RdGtGF1S6wIuk7HcpC1agsnB
CbkeiX0HbtKNVGSmOmPDCxI8IKMUb7S4SZ9JbzCHkBIb/0ko8KedGpQCbCVnJS9c
+r/bGmZP433GFGzv1hiy8zz4oB2Gx2K2MV0OrsMWsfd+A9ABe8RChAYH31sf8nTu
k4Ae2ZoEiePA7Dw9iZXHUqXS6CB6TBGvPTdgWhfWrF3Ovm9KNhycq+BZ2HcZvA12
8CiBVcfaHU7ae7mt8dup+AYFQpAEMbKBbfqwx3y9GYcY7uLumL+GSOzqvgg1w7k8
jxIgtDDu8U/RWwFqopUJvHBetk3ImNIyi9sk6TC9ip2uTrUcn9tuTKA8WceZq+On
oi/fignpzfuknq4o7gCC73Jynino1Q9XXwlSGiO6dpNaczwMjVS0msi+QxdRW+ii
JdypdwZP+r/Bl3a0g8KIyg2OXmo1FNeuUQFrrzezMBG0r0kUJb0GVwR7ZIXwpy/B
pSkB88eIlAz90iXpVtTN1l7UtPUmcEs1oRkrVAOwSD+KX+A7vrRr5EAKIznrGeH2
7lxM06xAVmpu69/9M7PL
=nbwe
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
