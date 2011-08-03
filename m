From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] i2c-designware: add OF binding support
Date: Wed, 3 Aug 2011 23:16:15 +0100
Message-ID: <CACxGe6vuTjb=a=m9Tvr8hRV7r+xKU=DGqVhewcMz3Wt8AOx-YQ@mail.gmail.com>
References: <1312401863-25822-1-git-send-email-robherring2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1312401863-25822-1-git-send-email-robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Aug 3, 2011 at 9:04 PM, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wro=
te:
> From: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
>
> Add of_match_table and DT style i2c registration to designware i2c
> driver.
>
> Signed-off-by: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
> Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> ---
> =A0Documentation/devicetree/bindings/i2c/dw-i2c.txt | =A0 23 ++++++++=
++++++++++++++
> =A0drivers/i2c/busses/i2c-designware.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 13 ++++++++++++
> =A02 files changed, 36 insertions(+), 0 deletions(-)
> =A0create mode 100644 Documentation/devicetree/bindings/i2c/dw-i2c.tx=
t
>
> diff --git a/Documentation/devicetree/bindings/i2c/dw-i2c.txt b/Docum=
entation/devicetree/bindings/i2c/dw-i2c.txt
> new file mode 100644
> index 0000000..cbcb404
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/dw-i2c.txt
> @@ -0,0 +1,23 @@
> +* Synopsys DesignWare I2C
> +
> +Required properties :
> +
> + - compatible : should be "snps,designware-i2c"
> + - reg : Offset and length of the register set for the device
> + - interrupts : <IRQ> where IRQ is the interrupt number.
> +
> +Recommended properties :
> +
> + - clock-frequency : desired I2C bus clock frequency in Hz.
> +
> +Example :
> +
> + =A0 =A0 =A0 i2c@f0000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "snps,designware-i2c";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0xf0000 0x1000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <11>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock-frequency =3D <400000>;
> + =A0 =A0 =A0 };
> +
> diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses=
/i2c-designware.c
> index b7a51c4..2911a49 100644
> --- a/drivers/i2c/busses/i2c-designware.c
> +++ b/drivers/i2c/busses/i2c-designware.c
> @@ -37,6 +37,7 @@
> =A0#include <linux/platform_device.h>
> =A0#include <linux/io.h>
> =A0#include <linux/slab.h>
> +#include <linux/of_i2c.h>
>
> =A0/*
> =A0* Registers offset
> @@ -770,12 +771,17 @@ static int __devinit dw_i2c_probe(struct platfo=
rm_device *pdev)
> =A0 =A0 =A0 =A0adap->algo =3D &i2c_dw_algo;
> =A0 =A0 =A0 =A0adap->dev.parent =3D &pdev->dev;
>
> +#ifdef CONFIG_OF
> + =A0 =A0 =A0 r =3D i2c_add_adapter(adap);
> +#else
> =A0 =A0 =A0 =A0adap->nr =3D pdev->id;
> =A0 =A0 =A0 =A0r =3D i2c_add_numbered_adapter(adap);
> +#endif

Unnecessary.  i2c_add_numbered_adapter will dynamically assign a bus
number now if nr is -1.

Otherwise, the patch looks good.  You can add the following after
removing the above hunk.  Besides, the way this is changed with an
#ifdef will break non-dt users in the same kernel.  You know better
than to do that!  :-)

Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> (after fixing above =
problem)

g.
