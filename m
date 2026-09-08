Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C92155D890;
	Tue,  8 Sep 2026 17:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788889627; cv=none; b=CJFA+F+lpwRDoWRrF6e/cFEozDG/bYpkV3YO+Yifez9BlVzFI5e1gv1XhHo9bGZy9H7DmyLjTSpBdaVgUuMbPRECoeRpUHVIBma50y4LliNzOJ2opC9GVVmPExfwfnIy00xcgGPXQ4FiywKykGyggoOoCrcM/n7dAmVhZh4Evpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788889627; c=relaxed/simple;
	bh=5TdbNlqE0oqjimbaG3Vs6YU19f2Vu3G/I8YG/IifR64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8UB7BK1EJfqAPKBFEPQPzhXJw0Td92T/P9kTHvH65LzflTPGnZ3hiuhDpKZHCwb7lXr4ABr1RYaMsSX19cILhZNOiVm0PTz1iCgSM2FsOIXLSJchkshR47aEEKWEqc5y31iyB1Ep4mJ78cQfvvfd/W/fQsXk5FTt/Xy2hU+94M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V94RevoJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V94RevoJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319721F00A3A;
	Tue,  8 Sep 2026 17:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788889625;
	bh=xNP4JgIC7dK4dS0QtG+AlWm4W0r0nKByA88aqX6E5EI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V94RevoJkTl2GPjYwYSO7WzFhQrwFx7jaC2Nqf/4CER3ikJ0YXgP4Z15G0FWzbxvx
	 g6FfJomtz8ioqWppvOMYWfebwtxgNiALt5za694Wh+yo3VtQ/k7WWCduioBirVwA8n
	 Hu6vWfpRUoPnh7NAs16vjnvkBH8uCfJzSyNmLfotsTSpgj2kmkDd6o5dCzTS0ePVOm
	 miW9vdjN4/n2WW+uOdPiA8fktKRnENTiVYxm37hrdZixzpJj3mt72QWJHRc0Z6Zb4Q
	 0ziOWNsTj9sporBR86TsWEFn8fcpsG8Hx2qtDfZ+uHIYqifVcFhpWD4QZYBw+1C15M
	 VBItbskqM1vwQ==
Date: Tue, 8 Sep 2026 18:47:01 +0100
From: Conor Dooley <conor@kernel.org>
To: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
Cc: andi.shyti@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, peda@lysator.liu.se, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	vikash.bansal@nxp.com, priyanka.jain@nxp.com
Subject: Re: [PATCH 1/2] dt-bindings: i2c: Add NXP PCA9641 I2C bus master
 arbiter
Message-ID: <20260908-skirt-makeshift-2050f3bcbb22@spud>
References: <20260908123146.1839854-1-shivprakash.gupta@nxp.com>
 <20260908123146.1839854-2-shivprakash.gupta@nxp.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZBrTyhOKpCMuTifA"
Content-Disposition: inline
In-Reply-To: <20260908123146.1839854-2-shivprakash.gupta@nxp.com>

--ZBrTyhOKpCMuTifA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 08, 2026 at 06:01:45PM +0530, Shiv Prakash Gupta wrote:
> Add device tree binding schema for the NXP PCA9641 2-to-1 I2C bus
> master arbiter.
>=20
> The PCA9641 arbitrates between two upstream I2C masters competing for a
> single downstream slave bus using a lock/grant ownership model. The
> binding supports an optional 'interrupts' property for interrupt-assisted
> arbitration.
>=20
> Signed-off-by: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
> ---
>  .../devicetree/bindings/i2c/nxp,pca9641.yaml  | 109 ++++++++++++++++++
>  1 file changed, 109 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/nxp,pca9641.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/nxp,pca9641.yaml b/Doc=
umentation/devicetree/bindings/i2c/nxp,pca9641.yaml
> new file mode 100644
> index 000000000000..649a3f6d1776
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/nxp,pca9641.yaml
> @@ -0,0 +1,109 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i2c/nxp,pca9641.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP PCA9641 2-to-1 I2C bus master arbiter
> +
> +maintainers:
> +  - Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
> +
> +description: |
> +  The PCA9641 is a 2-to-1 I2C bus master arbiter that manages two upstre=
am
> +  I2C masters competing for a single downstream slave bus. It uses a
> +  lock/grant ownership model: a master requests the downstream bus by se=
tting
> +  LOCK_REQ, waits for the arbiter to assert LOCK_GRANT, then explicitly
> +  connects to the bus via BUS_CONNECT before issuing transactions.
> +
> +  Key features compared to the PCA9541:
> +    - Lock/grant ownership model (LOCK_REQ + LOCK_GRANT bits in CONTR re=
gister)
> +    - BUS_CONNECT bit must be set explicitly after receiving LOCK_GRANT
> +    - Reserve Time register (RT): guarantees bus ownership for 1-255 ms
> +    - INT0 and INT1 interrupt outputs (one per upstream master) and INT_=
IN
> +      interrupt input that propagates downstream slave interrupts upstre=
am
> +    - 16-bit shared mailbox (MB_LO + MB_HI) for inter-master communicati=
on
> +    - ID register (read-only, value 0x38) to distinguish from PCA9541
> +    - Four address pins (AD0-AD3) allowing up to 112 unique I2C addresses
> +
> +properties:
> +  compatible:
> +    const: nxp,pca9641
> +
> +  reg:
> +    maxItems: 1
> +    description:
> +      7-bit I2C slave address of the PCA9641 on the upstream bus. The ad=
dress
> +      is set by hardware pins AD0-AD3 at power-on or hardware reset.
> +
> +  interrupts:
> +    maxItems: 1
> +    description:
> +      Optional interrupt from the INT0 or INT1 output pin. When provided=
 the
> +      driver uses interrupt-assisted arbitration (waits on LOCK_GRANT in=
terrupt)
> +      instead of polling the CONTR register. Either INT0 or INT1 can be
> +      connected depending on which upstream master port is used.
> +
> +  i2c-arb:
> +    type: object
> +    $ref: /schemas/i2c/i2c-controller.yaml
> +    unevaluatedProperties: false
> +    description:
> +      I2C bus node representing the downstream slave bus controlled by t=
he
> +      PCA9641. Downstream slave devices are declared as child nodes here.

Why does this node need to exist? Can't the i2c-arbiter node itself
contain the child devices?

Thanks,
Conor.

> +
> +required:
> +  - compatible
> +  - reg
> +  - i2c-arb
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    /* Minimal example: polling mode (no interrupt wiring) */
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        i2c-arbiter@74 {
> +            compatible =3D "nxp,pca9641";
> +            reg =3D <0x74>;
> +
> +            i2c-arb {
> +                #address-cells =3D <1>;
> +                #size-cells =3D <0>;
> +
> +                eeprom@50 {
> +                    compatible =3D "atmel,24c32";
> +                    reg =3D <0x50>;
> +                };
> +            };
> +        };
> +    };
> +
> +  - |
> +    /* Interrupt mode: INT0 wired to SoC GPIO */
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        i2c-arbiter@70 {
> +            compatible =3D "nxp,pca9641";
> +            reg =3D <0x70>;
> +            interrupt-parent =3D <&gpio1>;
> +            interrupts =3D <5 IRQ_TYPE_EDGE_FALLING>;
> +
> +            i2c-arb {
> +                #address-cells =3D <1>;
> +                #size-cells =3D <0>;
> +
> +                temperature-sensor@48 {
> +                    compatible =3D "national,lm75";
> +                    reg =3D <0x48>;
> +                };
> +            };
> +        };
> +    };
> --=20
> 2.34.1
>=20

--ZBrTyhOKpCMuTifA
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaqBKFAAKCRB4tDGHoIJi
0rdkAP0YwgfTV6HaNwYEcghoSr7x/dbGw12EhaETo9cmdESA4wD/RpWKfQp4Mtgw
pZdmvdQMTTjYnw3gxTYHWi2NvvBSTA0=
=ZwI6
-----END PGP SIGNATURE-----

--ZBrTyhOKpCMuTifA--
