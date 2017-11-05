From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4] i2c: aspeed: Deassert reset in probe
Date: Sun, 5 Nov 2017 13:49:49 +0100
Message-ID: <20171105124949.ct4ity6htxqgvvfp@ninjato>
References: <20171101002330.24981-1-joel@jms.id.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="llbi7icubzs7ilug"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:47157 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751615AbdKEMtv (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 5 Nov 2017 07:49:51 -0500
Content-Disposition: inline
In-Reply-To: <20171101002330.24981-1-joel@jms.id.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Joel Stanley <joel@jms.id.au>
Cc: Brendan Higgins <brendanhiggins@google.com>, Philipp Zabel <philipp.zabel@gmail.com>, Rob Herring <robh+dt@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--llbi7icubzs7ilug
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 01, 2017 at 10:53:30AM +1030, Joel Stanley wrote:
> In order to use i2c from a cold boot, the i2c peripheral must be taken
> out of reset. We request a shared reset controller each time a bus
> driver is loaded, as the reset is shared between the 14 i2c buses.
>=20
> On remove the reset is asserted, which only touches the hardware once
> the last i2c bus is removed.
>=20
> The reset is required as the I2C buses will not work without releasing
> the reset. Previously the driver only worked with out of tree hacks
> that released this reset before the driver was loaded. Update the
> device tree bindings to reflect this.
>=20
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v4:
>   - Make reset required and update device tree bindings

For that change, I'd like to have an ack from Rob first. Won't that
cause problems when you update only the kernel and keep the "old"
devicetree?

>   - Remove unnecessary delay.h
>   - Exit when reset controller probing fails
>   - Fix ordering when removing the driver so that it is the opposite of p=
robing
> v3: Check for bad reset controller probe (caused by eg. bad device tree)
>     and set ->rst to NULL so assert/desassert does not cause a warning to
>     be printed
> v2: Sort the headers
>=20
>  Documentation/devicetree/bindings/i2c/i2c-aspeed.txt |  7 +++++--
>  drivers/i2c/busses/i2c-aspeed.c                      | 12 ++++++++++++
>  2 files changed, 17 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt b/Docum=
entation/devicetree/bindings/i2c/i2c-aspeed.txt
> index bd6480b19535..e7106bfc1f13 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
> @@ -7,7 +7,9 @@ Required Properties:
>  - compatible		: should be "aspeed,ast2400-i2c-bus"
>  			  or "aspeed,ast2500-i2c-bus"
>  - clocks		: root clock of bus, should reference the APB
> -			  clock
> +			  clock in the second cell
> +- resets		: phandle to reset controller with the reset number in
> +			  the second cell
>  - interrupts		: interrupt number
>  - interrupt-parent	: interrupt controller for bus, should reference a
>  			  aspeed,ast2400-i2c-ic or aspeed,ast2500-i2c-ic
> @@ -40,7 +42,8 @@ i2c {
>  		#interrupt-cells =3D <1>;
>  		reg =3D <0x40 0x40>;
>  		compatible =3D "aspeed,ast2400-i2c-bus";
> -		clocks =3D <&clk_apb>;
> +		clocks =3D <&syscon ASPEED_CLK_APB>;
> +		resets =3D <&syscon ASPEED_RESET_I2C>;
>  		bus-frequency =3D <100000>;
>  		interrupts =3D <0>;
>  		interrupt-parent =3D <&i2c_ic>;
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-asp=
eed.c
> index 284f8670dbeb..7d4aeb4465b3 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -27,6 +27,7 @@
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <linux/reset.h>
>  #include <linux/slab.h>
> =20
>  /* I2C Register */
> @@ -132,6 +133,7 @@ struct aspeed_i2c_bus {
>  	struct i2c_adapter		adap;
>  	struct device			*dev;
>  	void __iomem			*base;
> +	struct reset_control		*rst;
>  	/* Synchronizes I/O mem access to base. */
>  	spinlock_t			lock;
>  	struct completion		cmd_complete;
> @@ -847,6 +849,14 @@ static int aspeed_i2c_probe_bus(struct platform_devi=
ce *pdev)
>  	/* We just need the clock rate, we don't actually use the clk object. */
>  	devm_clk_put(&pdev->dev, parent_clk);
> =20
> +	bus->rst =3D devm_reset_control_get_shared(&pdev->dev, NULL);
> +	if (IS_ERR(bus->rst)) {
> +		dev_err(&pdev->dev,
> +			"missing or invalid reset controller device tree entry");
> +		return PTR_ERR(bus->rst);
> +	}
> +	reset_control_deassert(bus->rst);
> +
>  	ret =3D of_property_read_u32(pdev->dev.of_node,
>  				   "bus-frequency", &bus->bus_frequency);
>  	if (ret < 0) {
> @@ -917,6 +927,8 @@ static int aspeed_i2c_remove_bus(struct platform_devi=
ce *pdev)
> =20
>  	spin_unlock_irqrestore(&bus->lock, flags);
> =20
> +	reset_control_assert(bus->rst);
> +
>  	i2c_del_adapter(&bus->adap);
> =20
>  	return 0;
> --=20
> 2.14.1
>=20

--llbi7icubzs7ilug
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAln/CO0ACgkQFA3kzBSg
Kba56RAAsWIF2P8ntXi/AL26lw/jE2SyC1f20SKAVK7dhej6oohRn2m21kFQR90S
k8xap3mv30maiiQqFg7kgq/AUoxTn9ye27ylNRgcdKnrupAqwSMHgh043OKIs9lC
CP20Lb+90xNx3ABizwZG6h27uenfFzmgcxPOSaKMS3c+dfuCW9x5eAOx42lH+hT9
p/gPRaFuNcWYE8hrX1bTDUha47JGmRU5EGc+Q81tqLCHMxIkoZl3p9MkJ2tBn0zO
BH6Wm/JCVWTuj2tESXZjLNs0p63VJsvgD+JIPbu4t59KS8sg9ISDktyXBSmkmTMJ
yEzsNVYe4W2Teo8O0gzspDhrYKnunJv9hFpr29tHLUYdVzgjw+Iluyhc3TPhUxJk
ifIX58aHaFBlBykKpSuSUQ9K0SsB70CYnwB08DjoklbpTe7GDBa+4xBt4quLOUFd
B1MWuc0Sgv345SSTRSmMVueBGrPelhTvdyZ3trbrTb+ySZdQ6XyTvivNnGTsuF2k
BGBAQGfFn0zkuV4kYOL9Ib8q8LBYxxGhCMAfYXu9tvUiD4vGe3RkL68V1VbGbjpu
hiQJQ3JVHqxvkGjU557GPLLdV3+bAfmI0eM3CNm0wK8PT6BMjJO0rP5oXnUlBg7E
dZFEioQgjU9s+pN0PevIGW4lneYNg5vqm3Nh4xFQM3Ue1s6wsac=
=QE6e
-----END PGP SIGNATURE-----

--llbi7icubzs7ilug--
