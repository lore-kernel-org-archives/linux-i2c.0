Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BB430FC1E;
	Mon, 15 Jun 2026 18:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781548709; cv=none; b=Z4J6AlusGzBurl/xVkppaFzctGjumNhLL4PfTzHem2XNzqpnEu9yIQlPY0OvUE1EQ3otB1Kr/D3HuDdvAOnCJGCNkmRSd12b77GU9YahpF+jIM74FDN7k/ddLLirC4/3UqwHlf6RB36mRZtg2ZK46NVNbc7Xe5HIvlCyw5NwnZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781548709; c=relaxed/simple;
	bh=OyzbWOO5TbfjlH0v1zM6uLS9pUzdvGf/ddEuMujEFEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIn6/joY87/fnBgXbwzyKPz585feIjCtR1xdZRx0eLUF6ONHNn55rJL0gLxT8/hpAd4YkCouEGIsf3SK2+CLBoJMwlNoNneFsnDVLrXOMwhvS1RboxZdOq0MIY6B2aNwFtL5xrS+xR+uWKlLu0UhRo76J2/AIsKuwXYW4L6u1mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+utUQIU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+utUQIU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058691F000E9;
	Mon, 15 Jun 2026 18:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781548707;
	bh=VBghOhs59Hv7GVeG9wZkMM+I73/bgPvjyg413BNuOGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U+utUQIU4xOlalCDtjcO2JIYvVmmFWTWSEKTW2j87q0zniyPn5Dq5NSCkrRJjlaj5
	 AZvojyELN/DEY7txGKTcUMMZJ581u24zL7E70poVgcKBDTxQww+LdJOcyBKqgaosEe
	 ybrg7nayzlYhGQRQZJi5DGPHC6RNaP+3MbbO4XGH1dwJmIXCgTE6J7/eGBar0/J82Z
	 A+MPduhHRE+J4LWFlMLVcsqo57TVDso5VPimPrLYH3W15nbbpdTJOHFpDWSa6lqABC
	 W7Bn/2rDf0Kc3VCBaxj9D3JYGUIU6iSl+5FErftpl1oasf6l8ngFK4tEZWDocELGxa
	 NF25UtLrcfGHg==
Date: Mon, 15 Jun 2026 20:38:24 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Thierry Reding <treding@nvidia.com>, 
	Peter Rosin <peda@lysator.liu.se>, Andi Shyti <andi.shyti@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: i2c: i2c-mux-pinctrl: change maintainer
Message-ID: <ajBGibftf679T6P4@arch.a226c7d-lcedt>
References: <20260611122704.7559-2-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s2jlv5kbsum3rita"
Content-Disposition: inline
In-Reply-To: <20260611122704.7559-2-wsa+renesas@sang-engineering.com>


--s2jlv5kbsum3rita
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] dt-bindings: i2c: i2c-mux-pinctrl: change maintainer
MIME-Version: 1.0

On Thu, Jun 11, 2026 at 02:26:24PM +0200, Wolfram Sang wrote:
> The YAML conversion added me as maintainer but I can't recall being
> asked nor do I want to maintain it. Thierry has created the YAML file
> and works for the company which contributed the driver.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>=20
> @Thierry: are you okay with this change?
>=20
>  Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.yaml b=
/Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.yaml
> index 2e3d555eb96c..f7502da71909 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Pinctrl-based I2C Bus Mux
> =20
>  maintainers:
> -  - Wolfram Sang <wsa@kernel.org>
> +  - Thierry Reding <treding@nvidia.com>
> =20
>  description: |
>    This binding describes an I2C bus multiplexer that uses pin multiplexi=
ng to route the I2C

By default I used to list the subsystem maintainer as the bindings
maintainer if the binding wasn't Tegra-specific, or in this case the
original author wasn't active anymore.

I'm fine being listed as the maintainer for this if you don't want to,
but I prefer to use the thierry.reding@kernel.org email address for
communication.

With that:

Acked-by: Thierry Reding <treding@nvidia.com>

--s2jlv5kbsum3rita
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmowRqAACgkQ3SOs138+
s6H/0hAAiL5m3v8/0iDHbAr6zygitZtIb5m5ajtivUoOfBkqdSdQck37bSS+XpSu
e6nbVNKb5Lx9+roE6EYmsX6/77wu5aoqSouWCvus/s+5nciactIk0587oMxm6SjN
e6pVImNKlj5H7O/Pf2iSrUkfuy1ir6GKl3Y03+jcjzAU+b7T2ytiA5zEJHjuHlZg
DMz5PeVF5PyWd1i45WA4QImoIBBjyBelQVX2wB1wbAhNuiEdPsMQjl1V3Jncd8M+
qXJWducnMjUabbH2YBeC6q1pHNXzz6XYAcdkQO4kQeCScxywLkAjMj+RcwJYBup1
7QZ9RTQmWgCe93UAMeYhgGxuvi18NA4vklfep+sEZb+C6dCEVYmZX1eHnpQW+H03
CDQSIGYWxtdIH3IWx0y+HKXZuaMQ2Z47/wi9Wkxb4EjP6NeEKOBZbdT7kuyfoGxJ
2CN0mSJOed6IO8zMad0tSqkIwUrrYedjjI0cA3aH84Oyu25gBkwsyFc07EZV/sMX
Uw7ex/cpNuhUNWmYXgvlDnMe/MfPHC+4KmCsoGDLCUwF3QCy7JLR4ce4J5gYVqs1
dN4G6fuw9Q0WZb2waEbYuHxo8RZXzxisV044drPh01XkETIWsmBIiD/HttgxV0+u
vd4f3M8zu9wPD7MJHoMf3NkiU265XNqphbj6xsIOjj6qjyQ+VBo=
=T6jY
-----END PGP SIGNATURE-----

--s2jlv5kbsum3rita--
