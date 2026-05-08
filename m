Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A161D3EF676;
	Fri,  8 May 2026 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778252193; cv=none; b=l/a8F51+h5LW+z3HiS3VbXT1NiqE0JHxRQDYc3PZ1HkIUzD6rYg8ui0Y1/LZmVTGNUJZ4/VeMnbwB0Go37uEj6ipdydrf+Dk/9mTfbH2Q8cS274ATuBcbvBmZmmoApj2/GJogHZs3iD9DF+NQenGDVkhE9IeVwcnb7uRW4Oqx6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778252193; c=relaxed/simple;
	bh=//8BZ5boQFYtKjkFGv9LjuNIPKDIvlt0TZcCGVZdXbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+zM27IUBYssULslm/3ktIjPfxUIkl1u07yGAZaS6Ls8bj1jXFR9jqsEQqtK5d9ZvbRzn30AroE6v7g05OWlM1d0q/Ka5l7BEQj6hSD7ov4hxo90IOLrqXJBjgZclWaBGPwMQGFynBKGkrq3OS/d3yt1mbDTpXfhhjF+KkdnaQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRi0GEwa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRi0GEwa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84287C2BCB0;
	Fri,  8 May 2026 14:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778252193;
	bh=//8BZ5boQFYtKjkFGv9LjuNIPKDIvlt0TZcCGVZdXbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XRi0GEwai+xu5rburthX0yTyLDz/SMz5zQkNcX1bYNRKy7lMrkckaKHzWZvEFg8kS
	 x2p6a6CJE0BkrKDIEngDxHAcAbW6ZCVRoqRTCkGMmkJy/h67/uMwV1WDW1XAhEoyC+
	 +gqRQX0PnB/bEbHUtP5PoIP0Ff3t5l6nWgU2gU0J/tEactjAmV2CcbWbkghYPcBVOf
	 jbLxNGGtYGxK9vzrrvjzuR7S7cMbnix//rkhZDWuM3ocvy8Dug5xkCJjpnw9ZQhWTk
	 eE7IQzBW0lnuKmy6njyh/JOmMzgTeWsIk1arUQniM0NbBA0lwGFcuHOZylopufU3nB
	 9rT8erLeHxq2A==
Date: Fri, 8 May 2026 15:56:29 +0100
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
Message-ID: <20260508-jury-eclipse-9190a84cfa7e@spud>
References: <20260507081010.12810-1-wanghongliang@loongson.cn>
 <20260507-idealize-occultist-916fd07fc235@spud>
 <84c37ac1-3a9c-b0d2-f86a-90712b45b806@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="feNwwGodlxSqhX4l"
Content-Disposition: inline
In-Reply-To: <84c37ac1-3a9c-b0d2-f86a-90712b45b806@loongson.cn>


--feNwwGodlxSqhX4l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 08, 2026 at 09:29:08AM +0800, Hongliang Wang wrote:
>=20
> On 2026/5/8 =E4=B8=8A=E5=8D=881:29, Conor Dooley wrote:
> > On Thu, May 07, 2026 at 04:10:09PM +0800, Hongliang Wang wrote:
> > > From: wanghongliang <wanghongliang@loongson.cn>
> > >=20
> > > clocks property describes the i2c bus reference clock from APB clock.
> > > clock-frequency property describes i2c bus speed.
> > >=20
> > > Signed-off-by: wanghongliang <wanghongliang@loongson.cn>
> > > ---
> > >   Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml | 3 +++
> > >   1 file changed, 3 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.=
yaml b/Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml
> > > index ee09c6d9c5f0..4bf89bb97e7d 100644
> > > --- a/Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml
> > > +++ b/Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml
> > > @@ -38,10 +38,13 @@ unevaluatedProperties: false
> > >   examples:
> > >     - |
> > >       #include <dt-bindings/interrupt-controller/irq.h>
> > > +    #include <dt-bindings/clock/loongson,ls2k-clk.h>
> > >       i2c0: i2c@1fe21000 {
> > >           compatible =3D "loongson,ls2k-i2c";
> > >           reg =3D <0x1fe21000 0x8>;
> > > +        clock-frequency =3D <100000>;
> > > +        clocks =3D <&clk LOONGSON2_APB_CLK>;
> > /stuff/linux-dt/Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c=
=2Eexample.dtb: i2c@1fe21000 (loongson,ls2k-i2c): Unevaluated properties ar=
e not allowed ('clocks' was unexpected)
> > 	from schema $id: http://devicetree.org/schemas/i2c/loongson,ls2x-i2c.y=
aml
> >=20
> >=20
> > Please test your patches before sending them.
> The error is becasue there is no clocks property in loongson,ls2x-i2c.yam=
l.
> The patch is based on the following repository and uses the i2c-host-next
> branch.
> I found the clocks property already exist in loongson,ls2x-i2c.yaml, so I
> didn't
> add it in my patch
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git

Ah, my bad then.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

> >=20
> > Does this device actually have a clock or not?
> Yes,=C2=A0 the clock actually exists.
> >=20
> > Cheers,
> > Conor.
> >=20
> > >           interrupt-parent =3D <&extioiic>;
> > >           interrupts =3D <22 IRQ_TYPE_LEVEL_LOW>;
> > >           #address-cells =3D <1>;
> > > --=20
> > > 2.47.2
> > >=20
> Best regards,
> Hongliang Wang
>=20
>=20

--feNwwGodlxSqhX4l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaf35nQAKCRB4tDGHoIJi
0uS5AP43yGqvSvjfJl6YqN05s8xRDa3RxCtZpmAZmzA1u7Go1gEAynbpsET17jku
atzNZVM6R7mYahw+YJXPSRAFrVSXRA0=
=fpqh
-----END PGP SIGNATURE-----

--feNwwGodlxSqhX4l--
