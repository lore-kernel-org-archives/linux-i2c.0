From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] i2c: core: Dispose OF IRQ mapping at client removal
 time
Date: Thu, 30 Oct 2014 15:25:47 +0100
Message-ID: <20141030142543.GA20072@ulmo.nvidia.com>
References: <1414677578-27412-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1414677578-27412-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1414677578-27412-3-git-send-email-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2014 at 03:59:37PM +0200, Laurent Pinchart wrote:
> Clients instantiated from OF get an IRQ mapping created at device
> registration time. Dispose the mapping when the client is removed.
>=20
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnhk3lzF8UVTdg@public.gmane.org=
m>
> ---
>  drivers/i2c/i2c-core.c | 3 +++
>  1 file changed, 3 insertions(+)

If this is needed regardless of patch 3/3, then presumably it should be
Cc'ed to stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org since it fixes a bug that's been there
for quite some time?

Thierry

> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 2f90ac6a7f79..258765b29684 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -670,6 +670,9 @@ static int i2c_device_remove(struct device *dev)
>  		status =3D driver->remove(client);
>  	}
> =20
> +	if (dev->of_node)
> +		irq_dispose_mapping(client->irq);
> +
>  	dev_pm_domain_detach(&client->dev, true);
>  	return status;
>  }
> --=20
> 2.0.4
>=20

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUUkpnAAoJEN0jrNd/PrOhHFEP/j0gVhg1NzMsGaOQ4Fn6wteW
02QIeCKIHeYDp7xS456XHpSGc43XT2MuDatAvIobnmTNfpryfZSGikA3m9NwxYF1
qBqRQYEnsF0NFkYmCCTnQDfZf6IoBtYd3OdrPUMIQELCyRGVTsSlYWFf2yicJSju
oh+ONYYRf59/kMTRFT8OoeKnPp0fwFZdiUefa0ZqjaBflFEMQO2xoVR3+TDzodwD
6bvdpBOWDHcwwG/o1w6bMWZGgFFW9y+dGvNMLQkRa2URgvAQgzqapNoR62eZlEPK
RlPlM1FoNsVa3sWbEHivIYymyGWd6N8VZBoOM1yvYvonHutwfJjxpqYb1+k8Te3t
wfqR15cNy8kkWPpXI9jBOiA+dup1gEnxnN1KQayTGaqcRyS1R6oJO/Pagc1EM2iK
ka6BF97c+2cpesxMf6G9ZAA/P+jmIjAv4heaY4x4xo1r1HxUCXT0jXCikIypPGmt
DkPh6L3+wvGiVVbFMEmhqHUw7Np5flhiKvWDYcfBRTqDNwXgnsCSO0JbRDzoY5Ur
Vcmahz/9bJv9PQXzPBuaRSEi4eIH0P/7njOQS6PZmRtuMMKVUBFyoJZCXfn70Ale
rUq6jf5pRYvdmjiLm9XgsJHFUmZfWNtkMGtQ1SI00bofe9xeUq6Wxv9utH36F59D
OIIVXASW9Rp4EOr1FK9f
=Rzsr
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
