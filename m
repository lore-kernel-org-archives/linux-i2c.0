Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2612C41E6A7;
	Mon,  5 Oct 2026 10:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791196737; cv=none; b=s2aTf9xetFiJfaYBCoyCwXp425YrxfuSdSv5iDZtYV5W/aOupuKwU7JdNWkSae5qczv6wrAJaBL8uY6xW5Xnnq12XhSyLs0huCPAsU5AUdy5/xQ4yoDZW9tf3+Mf2DbnZZTVFOecDIrgsv4YKH63TwWExE8+gV+G0y514yMK0m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791196737; c=relaxed/simple;
	bh=tbv9odrKEQnPX5q4jaqxSMF3koopKNDBKG/bGjOm0hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lscU5mQvKXMdqXKZImG0RQDY4wb9azYaL0pJ+/GBjXJhJ5jnQEC3n82kYtgLk77RiT4k5H6PJw5/VlUwUmIUsD4a/9F9Rqi56l4+GZTcDN6CRz8umeyfCWE7cUY1tEGcrscJ8jvHwq+6/a1nfD+myL+cO2fcev1mrkUPMEaETAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJ9yBysz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJ9yBysz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92D81F000FF;
	Mon,  5 Oct 2026 10:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791196735;
	bh=MQvZ6OFFi+ayinWCV7C5p8JyTWsMDTCEkKNM3u1RSU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AJ9yByszeW/BniHM89tLys40+OGKQt8jnghEB69UC97msPFrSD5lFLmG5xi2Aqonh
	 Q/Q9L2xm4qvom/+RJkSUtTqxpg0eLuPLHGTjEPIgV0fUvTPf/Iz19WGyoO1aay51wF
	 X7gQI7LlPkbVSwjQTP/va7D59FB6mOuRCmG+N8+w0ZAG3DyIKnA74qGkaFD0ma+Eer
	 fQtOAnM8lGM7EzF6pdbogJJ7meBLOPDmyEW83qnNtMRTzOYuwurVBS0yluenDWPIo7
	 as21F8bG17pu/lRlJG2+YAe5XvZTB7e1cv+GeWQzcgYUS1hOM1srf2KwuoRZJUd4N+
	 4/H+w0CFS4kBA==
Date: Mon, 5 Oct 2026 11:38:51 +0100
From: Conor Dooley <conor@kernel.org>
To: Michael Zavertkin <misha.zavertkin@mail.ru>
Cc: linux-i2c@vger.kernel.org, Rustam Adilov <adilov@disroot.org>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: i2c: rtl9300: add pinctrl
Message-ID: <asN-O5ntmiXvZBvs@squawk>
References: <cover.1791127538.git.misha.zavertkin@mail.ru>
 <0cd1f9b98511c55a375ab82b121fe256916b87e2.1791127538.git.misha.zavertkin@mail.ru>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I9ve0r+sWLG0Auyh"
Content-Disposition: inline
In-Reply-To: <0cd1f9b98511c55a375ab82b121fe256916b87e2.1791127538.git.misha.zavertkin@mail.ru>

--I9ve0r+sWLG0Auyh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 04, 2026 at 10:32:35PM +0700, Michael Zavertkin wrote:
> For RTL9607C driver used to configure IO_MODE register. This register is
> global and is a scope of pinctrl driver (either pinctrl-single or WIP
> driver for SoC).
>=20
> Drop realtek,scl requirement for that SoC and require pinctrl instead.

This patch itself is probably fine, but the driver changes will cause
regressions because all existing devicetrees are going to have
realtek,scl and not the pinctrl properties. You need to retain the
driver code and make the register setting optional depending on if the
scl is there (or similar).
pw-bot: changes-requested

Thanks,
Conor.

>=20
> Signed-off-by: Michael Zavertkin <misha.zavertkin@mail.ru>
> ---
>  .../devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml       | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.ya=
ml b/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml
> index 5873cfdc5b3e..ad143509aa42 100644
> --- a/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml
> +++ b/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml
> @@ -57,6 +57,10 @@ properties:
>    clocks:
>      maxItems: 1
> =20
> +  pinctrl-0: true
> +
> +  pinctrl-names: true
> +
>  patternProperties:
>    '^i2c@[0-9ab]$':
>      $ref: /schemas/i2c/i2c-controller.yaml
> @@ -94,8 +98,9 @@ allOf:
>              const: realtek,rtl9607-i2c
>      then:
>        required:
> -        - realtek,scl
>          - clocks
> +        - pinctrl-0
> +        - pinctrl-names
> =20
>  required:
>    - compatible
> --=20
> 2.54.0
>=20

--I9ve0r+sWLG0Auyh
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCasN+OwAKCRB4tDGHoIJi
0u2tAP93g14rbfviheNx1r2ZvnSKeV1eCwQf2xkcJlXHb2gfjgEAz8PIEfkvOs6V
anIUY83seJV3TzgStgqyTbJr6mCu2w8=
=cKaA
-----END PGP SIGNATURE-----

--I9ve0r+sWLG0Auyh--
