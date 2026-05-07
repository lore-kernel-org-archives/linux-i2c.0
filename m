Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B57451069;
	Thu,  7 May 2026 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778174980; cv=none; b=AlQVZJHjo2TN64jCmaIlIbGiZV8gm4JeH/aizRvAhmzKgal6gdSN1bt1xn6mqFx6FRqdJ2e7LLUKlaRByy3Sd1iX5N3sQNV4gf/y47t0UjJRdRSQ41mUIvE0DrvQNpZgycjdzgXLCZ2WgXPSPXwUtWE7spIqz7bJ9v2JM3nv+Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778174980; c=relaxed/simple;
	bh=HwcUWd5Z347Rn8ztkGok7XGUDgbVHQKaR/odO55H61o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZTyE8NVMWgZLTkiGw9DjoDRfDIlSXOvV+1Cjn7+iclm2sQQWV+ra5HEXX2m6S1tn+uBSHFZEl0xVvJN4/AG/tZuq423wQ8ODPmvjbk9BU1TuKw22otYtKzBHM7THBTUt5SYftqgLX+d8LyqDzjDa8WwVoaGp1Pm2C4WPIRxBDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDVWgYcs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDVWgYcs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98489C2BCB2;
	Thu,  7 May 2026 17:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778174979;
	bh=HwcUWd5Z347Rn8ztkGok7XGUDgbVHQKaR/odO55H61o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MDVWgYcsBH0SS+oNaKZbb9Krk4sPdRcUCA8wrSLD4A/UHXrObYWGHj9bOMIs0XeDs
	 n78w1HNrABrWLYbXVGe+yrFh4IFKY+mc4iw+gU+Udsw6x47CG6Ybb0oVjRggBbtkBl
	 wyqONQKUx4xtD6ORHX+ZDmsnjDVeJD3HpsJHlaS8FwzSrC0BF8K4H+feUETcxyshJC
	 kVT2rDdS0CPQYJuMsePHtirp5p2JRbCS02yKaiv7OVBZ6of3H+o+JvX4013eDLDmQ0
	 00MUumEHKkuro/wlaQzOLsnCp222DPSKkEzlhE2SawInpELnSVrnlUFvkyz2gwz9+X
	 /JbXekgDsBDgQ==
Date: Thu, 7 May 2026 18:29:35 +0100
From: Conor Dooley <conor@kernel.org>
To: Hongliang Wang <wanghongliang@loongson.cn>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: Re: [PATCH v2] dt-bindings: i2c: ls2x-i2c: Add clocks and
 clock-frequency properties
Message-ID: <20260507-idealize-occultist-916fd07fc235@spud>
References: <20260507081010.12810-1-wanghongliang@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HSgsAmc7yUE2rqAQ"
Content-Disposition: inline
In-Reply-To: <20260507081010.12810-1-wanghongliang@loongson.cn>


--HSgsAmc7yUE2rqAQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2026 at 04:10:09PM +0800, Hongliang Wang wrote:
> From: wanghongliang <wanghongliang@loongson.cn>
>=20
> clocks property describes the i2c bus reference clock from APB clock.
> clock-frequency property describes i2c bus speed.
>=20
> Signed-off-by: wanghongliang <wanghongliang@loongson.cn>
> ---
>  Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml=
 b/Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml
> index ee09c6d9c5f0..4bf89bb97e7d 100644
> --- a/Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml
> +++ b/Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml
> @@ -38,10 +38,13 @@ unevaluatedProperties: false
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/clock/loongson,ls2k-clk.h>
> =20
>      i2c0: i2c@1fe21000 {
>          compatible =3D "loongson,ls2k-i2c";
>          reg =3D <0x1fe21000 0x8>;
> +        clock-frequency =3D <100000>;
> +        clocks =3D <&clk LOONGSON2_APB_CLK>;

/stuff/linux-dt/Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.exa=
mple.dtb: i2c@1fe21000 (loongson,ls2k-i2c): Unevaluated properties are not =
allowed ('clocks' was unexpected)
	from schema $id: http://devicetree.org/schemas/i2c/loongson,ls2x-i2c.yaml


Please test your patches before sending them.

Does this device actually have a clock or not?

Cheers,
Conor.

>          interrupt-parent =3D <&extioiic>;
>          interrupts =3D <22 IRQ_TYPE_LEVEL_LOW>;
>          #address-cells =3D <1>;
> --=20
> 2.47.2
>=20

--HSgsAmc7yUE2rqAQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCafzL/wAKCRB4tDGHoIJi
0qB6AP9db4UG3vb1kSPxyMgugIqmMYBQjY2RD9X7BU/0j17MVAEA0f5IO+ppIza/
FGsjkIhn+fgNB8jTqIZHdlxvNJ2AOwU=
=O/Kh
-----END PGP SIGNATURE-----

--HSgsAmc7yUE2rqAQ--
