From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v3 4/5] powerpc: i2c-mpc: document new FSL I2C bindings
	and cleanup
Date: Tue, 7 Apr 2009 08:43:52 -0700
Message-ID: <fa686aa40904070843y10015d13t84b6e10b4978c091@mail.gmail.com>
References: <20090407082052.477328750@denx.de> <20090407082231.646648985@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090407082231.646648985-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, devicetree-discuss-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Apr 7, 2009 at 1:20 AM, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>=
 wrote:
> This patch documents the new bindings for the MPC I2C bus driver.
> Furthermore, it removes obsolete FSL device related definitions
> for I2C.
> It should go through the appropriate PowerPC maintainer(s) hands.
>
> Signed-off-by: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>

Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>

> ---
> =A0Documentation/powerpc/dts-bindings/fsl/i2c.txt | =A0 46 ++++++++++=
++++++---------
> =A0include/linux/fsl_devices.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A04 --
> =A02 files changed, 31 insertions(+), 19 deletions(-)
>
> Index: linux-2.6-galak/Documentation/powerpc/dts-bindings/fsl/i2c.txt
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6-galak.orig/Documentation/powerpc/dts-bindings/fsl/i2c.t=
xt 2009-04-07 10:09:08.185721241 +0200
> +++ linux-2.6-galak/Documentation/powerpc/dts-bindings/fsl/i2c.txt =A0=
 =A0 =A02009-04-07 10:09:15.413719535 +0200
> @@ -7,8 +7,10 @@
>
> =A0Recommended properties :
>
> - - compatible : Should be "fsl-i2c" for parts compatible with
> - =A0 Freescale I2C specifications.
> + - compatible : compatibility list with 2 entries, the first should
> + =A0 be "fsl,CHIP-i2c" where CHIP is the name of a compatible proces=
sor,
> + =A0 e.g. mpc8313, mpc8543, mpc8544, mpc5200 or mpc5200b. The second=
 one
> + =A0 should be "fsl-i2c".
> =A0- interrupts : <a b> where a is the interrupt number and b is a
> =A0 =A0field that represents an encoding of the sense and level
> =A0 =A0information for the interrupt. =A0This should be encoded based=
 on
> @@ -16,17 +18,31 @@
> =A0 =A0controller you have.
> =A0- interrupt-parent : the phandle for the interrupt controller that
> =A0 =A0services interrupts for this device.
> - - dfsrr : boolean; if defined, indicates that this I2C device has
> - =A0 a digital filter sampling rate register
> - - fsl5200-clocking : boolean; if defined, indicated that this devic=
e
> - =A0 uses the FSL 5200 clocking mechanism.
> -
> -Example :
> - =A0 =A0 =A0 i2c@3000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <40000>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <1b 3>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <3000 18>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "i2c";
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =A0=3D "fsl-i2c";
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dfsrr;
> + - fsl,preserve-clocking : boolean; if defined, the clock settings
> + =A0 from the bootloader are preserved (not touched).
> + - clock-frequency : desired I2C bus clock frequency in Hz.
> +
> +Examples :
> +
> + =A0 =A0 =A0 i2c@3d00 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5200b-i2c","fsl,=
mpc5200-i2c","fsl-i2c";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x3d00 0x40>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <2 15 0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&mpc5200_pic>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl,preserve-clocking;
> =A0 =A0 =A0 =A0};
> +
> + =A0 =A0 =A0 i2c@3100 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc8544-i2c", "fsl-=
i2c";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x3100 0x100>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <43 2>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&mpic>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock-frequency =3D <400000>;
> + =A0 =A0 =A0 };
> +
> Index: linux-2.6-galak/include/linux/fsl_devices.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6-galak.orig/include/linux/fsl_devices.h =A0 =A02009-04-0=
7 10:09:08.185721241 +0200
> +++ linux-2.6-galak/include/linux/fsl_devices.h 2009-04-07 10:09:15.4=
14719119 +0200
> @@ -43,10 +43,6 @@
> =A0*
> =A0*/
>
> -/* Flags related to I2C device features */
> -#define FSL_I2C_DEV_SEPARATE_DFSRR =A0 =A0 0x00000001
> -#define FSL_I2C_DEV_CLOCK_5200 =A0 =A0 =A0 =A0 0x00000002
> -
> =A0enum fsl_usb2_operating_modes {
> =A0 =A0 =A0 =A0FSL_USB2_MPH_HOST,
> =A0 =A0 =A0 =A0FSL_USB2_DR_HOST,
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
