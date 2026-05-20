Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142BB31E828;
	Wed, 20 May 2026 15:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779292179; cv=none; b=G1PBXvGo0qQhuZsTeZoRUvVF8WwGI58Js3+Nrdlx87yMP5/RTDvDLG8Ln5BDClWeH5mKi2cTiIqKAYnZd61jJaKROOT6nKlG0LslblbCd4qZfY2jJCF/kf0qQyznEycHVd4umKjUbnqqpLf/L/MQJyM+SO7SQVACMIMsVDl0o7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779292179; c=relaxed/simple;
	bh=uzq9ZNe4Ju2i9x4FQZIAPLQgVsHYvvOKpgIVfD7yzyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7CVfpbxU0dGq15XkKc3vHZI5NwkETN1YZVFk9I9MLrbivW5ThqjazoLpJvAOSLNe+f8hEy5Cu+Gfm+CVVJlEDlqgPm7H7fG7eRklzgwNCRF/pkndTsfK/D+nxOb5Rs4WaVHvLYXXHMBrJBOrYP9ulS68DUnZySQ69EowEBYqA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzAW5I8O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzAW5I8O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C891F000E9;
	Wed, 20 May 2026 15:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779292177;
	bh=msoNP98X9TIxX7NoNwzaqySzNM1G8U+6UESCKSkm6qA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TzAW5I8OdwnywObXjHsKrGC7033vSs7Zjf5/OeBCkFCeb5UACy2QbBKAYFxYXM/X7
	 Ix21ccOOrz5SOJIjOBUVSJpHqzqbJSqyEg1fGoVpE/MFGIiEk8fKuaHmvmuTZudrjl
	 VQlkkt6L7rgVC+z5x5gGighmOQcVk0FlURgm6nHbaNxml/KwwoyWowbL0LZaCA1LLC
	 tuGZ1dlgbPjFEA17n75ushCRISquVMVgMTMI7drMLtsyjbMFgXBo/p2Ekg43q1TFcX
	 u9QIgg+jJI8US6Oy0o2531uCdMwwKX38l/hs7Xyt3+dte6780LVPZfM0tpPVwige9h
	 l5yhWeU7C7ttA==
Date: Wed, 20 May 2026 16:49:33 +0100
From: Conor Dooley <conor@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Stefan Roese <sr@denx.de>, Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 3/5] dt-bindings: i2c: mt7621: Document an7581
 compatible
Message-ID: <20260520-ample-ultimatum-b947112dfc5c@spud>
References: <20260519223253.1093-1-ansuelsmth@gmail.com>
 <20260519223253.1093-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N8qZPmLSc3aPNqva"
Content-Disposition: inline
In-Reply-To: <20260519223253.1093-4-ansuelsmth@gmail.com>


--N8qZPmLSc3aPNqva
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 12:32:45AM +0200, Christian Marangi wrote:
> Airoha SoC implement the same Mediatek logic for I2C bus with the only
> difference of not having a dedicated reset line to reset it.
>=20
> Add a dedicated compatible for the Airoha AN7581 SoC and reject the
> unsupported property.
>=20
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/i2c/mediatek,mt7621-i2c.yaml          | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/mediatek,mt7621-i2c.ya=
ml b/Documentation/devicetree/bindings/i2c/mediatek,mt7621-i2c.yaml
> index 118ec00fc190..8223fbc74f14 100644
> --- a/Documentation/devicetree/bindings/i2c/mediatek,mt7621-i2c.yaml
> +++ b/Documentation/devicetree/bindings/i2c/mediatek,mt7621-i2c.yaml
> @@ -14,7 +14,9 @@ allOf:
> =20
>  properties:
>    compatible:
> -    const: mediatek,mt7621-i2c
> +    enum:
> +      - airoha,an7581-i2c
> +      - mediatek,mt7621-i2c
> =20
>    reg:
>      maxItems: 1
> @@ -38,6 +40,16 @@ required:
>    - "#address-cells"
>    - "#size-cells"
> =20
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: airoha,an7581-i2c
> +then:
> +  properties:
> +    resets: false
> +    reset-names: false

The sashiko report looks valid here.
pw-bot: changes-requested

> +
>  unevaluatedProperties: false
> =20
>  examples:
> --=20
> 2.53.0
>=20

--N8qZPmLSc3aPNqva
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCag3YDQAKCRB4tDGHoIJi
0nwoAQD5LVwdLYofHn+NnDry6+KleqvkZPQ+C/mqn6QwtJmgpAD/elTm5Vluv3Mc
pu12sSvva0dnNq60VV/jPiXwB7tT+AU=
=l22U
-----END PGP SIGNATURE-----

--N8qZPmLSc3aPNqva--
