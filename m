From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: busses: i2c-pxa.c:  Fix for possible null pointer
 dereference
Date: Sun, 1 Jun 2014 22:26:47 +0200
Message-ID: <20140601202647.GD3853@katana>
References: <1400346848-25098-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6Nae48J/T25AfBN4"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1400346848-25098-1-git-send-email-rickard_strandqvist-IW2WV5XWFqGZkjO+N0TKoMugMpMbD5Xr@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rickard Strandqvist <rickard_strandqvist-IW2WV5XWFqGZkjO+N0TKoMugMpMbD5Xr@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Leilei Shang <shangll-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--6Nae48J/T25AfBN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 17, 2014 at 07:14:08PM +0200, Rickard Strandqvist wrote:
> There is otherwise a risk of a possible null pointer dereference.
>=20
> Was largely found by using a static code analysis program called cppcheck.

It is useful to put the output of the analyzer here.

>=20
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.s=
e>
> ---
>  drivers/i2c/busses/i2c-pxa.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index bbe6dfb..dbe5ebe 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -1269,7 +1269,9 @@ eremap:
>  eclk:
>  	kfree(i2c);
>  emalloc:
> -	release_mem_region(res->start, resource_size(res));
> +	if(res) {
> +		release_mem_region(res->start, resource_size(res));
> +	}

The proper fix is to move the release to the proper place, before kfree.
Even better would probably be a devm_* conversion.


--6Nae48J/T25AfBN4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTi4yHAAoJEBQN5MwUoCm2srIP/2Bzq0A7nG1yYYFw+2uTsySq
nghaF8EWjCnF3TZL5jPhRpX15YOQt5RdLI9wPsWVfc8gvVTX6ZHky7eNffTHAIyA
RgYDLBSdRsEyNAnvcHfw5Vnj+nKSktX5XKegsA5ECeLAITqZglk6CNLhs/ncBTJD
VQeIVZ7v7bS+5lmmkb1zEnsdw56BAphnFy4TufaVBdavA46WJTdCHHz0k1f3DWg7
jmfF70mNR22urU8M+ZgxWyY+Jdpf4oQXJrXhjaXcvkEvLSK+cUd/k0KKrosQFzGg
7rUQNw+EEHMWMjeoxyvIm22bl5GZzO0M8PglRdtUByV+y+2LlkdBg42Xig01hy1J
YuzjVrBZi5lMsA4CsZP56SEKejaKVvyWJoG9J59f+qPDtgkvA2u3IxGSgQXxhQul
kPddKCJskxvJxCbti2f6E5aOXAESFMy5myJsztGGmcXnHl9RsFRAttwORU0oM4wp
4zEORdrMcOBZQVcvZqCuZ0dx+wuFfbStTgE+zpEqNm6HCxwdsnnFn84TeznVQ22r
qi9aT+b073fXzR7taU5bSFgAa63X+d3NwCmLUTDOJiQ80SMsyJaZAMOUa5x1qLqH
3LZ2bGGFVk9XsMGYptg5Mac0XPWM1TDQqcTpl6LcH50c81pMs0OQVLfmmFac878q
F682o5sxjV6rZH0Jgc+v
=8d0h
-----END PGP SIGNATURE-----

--6Nae48J/T25AfBN4--
