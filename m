From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v4 3/3] powerpc: doc/dts-bindings: update doc of FSL I2C
	bindings
Date: Tue, 9 Feb 2010 10:50:56 -0700
Message-ID: <fa686aa41002090950w2c3cd008k47784089dd3417d7@mail.gmail.com>
References: <1264685141-26391-1-git-send-email-wg@grandegger.com>
	<1264685141-26391-2-git-send-email-wg@grandegger.com> <1264685141-26391-3-git-send-email-wg@grandegger.com>
	<1264685141-26391-4-git-send-email-wg@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1264685141-26391-4-git-send-email-wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Cc: Linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Jan 28, 2010 at 6:25 AM, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org=
> wrote:
> From: Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>
>
> This patch adds the MPC5121 to the list of supported devices,
> enhances the doc of the "clock-frequency" property and removes
> the obsolete "cell-index" property from the example nodes.
> Furthermore and example for the MPC5121 has been added.
>
> Signed-off-by: Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>

Thanks Wolfgang.  Comments below.

> ---
> =A0Documentation/powerpc/dts-bindings/fsl/i2c.txt | =A0 30 ++++++++++=
+++++++++----
> =A01 files changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/powerpc/dts-bindings/fsl/i2c.txt b/Documen=
tation/powerpc/dts-bindings/fsl/i2c.txt
> index b6d2e21..2f62dae 100644
> --- a/Documentation/powerpc/dts-bindings/fsl/i2c.txt
> +++ b/Documentation/powerpc/dts-bindings/fsl/i2c.txt
> @@ -9,8 +9,9 @@ Recommended properties :
>
> =A0- compatible : compatibility list with 2 entries, the first should
> =A0 =A0be "fsl,CHIP-i2c" where CHIP is the name of a compatible proce=
ssor,
> - =A0 e.g. mpc8313, mpc8543, mpc8544, mpc5200 or mpc5200b. The second=
 one
> - =A0 should be "fsl-i2c".
> + =A0 e.g. mpc8313, mpc8543, mpc8544, mpc5121, mpc5200 or mpc5200b. T=
he
> + =A0 second one should be "fsl-i2c". For the mpc5121, an additional =
node
> + =A0 "fsl,mpc5121-i2c-ctrl" is required as shown in the example belo=
w.

While you're editing this line; drop the requirement for the second
value to be 'fsl-i2c'.  We don't use it anymore, and only preserve it
for backwards compatibility with old trees.

> =A0- interrupts : <a b> where a is the interrupt number and b is a
> =A0 =A0field that represents an encoding of the sense and level
> =A0 =A0information for the interrupt. =A0This should be encoded based=
 on
> @@ -20,29 +21,46 @@ Recommended properties :
> =A0 =A0services interrupts for this device.
> =A0- fsl,preserve-clocking : boolean; if defined, the clock settings
> =A0 =A0from the bootloader are preserved (not touched).
> - - clock-frequency : desired I2C bus clock frequency in Hz.
> + - clock-frequency : desired I2C bus clock frequency in Hz. =A0If th=
is
> + =A0 property and "fsl,preserve-clocking" is not defined, a safe fix=
ed
> + =A0 clock divider value is used (resulting in a small clock frequen=
cy).

Nah, leave this as is.  Don't make it sound like omitting both
properties is a valid option.  The driver may (and should!) handle the
situation gracefully, but that fact does not need to be documented.

>
> =A0Examples :
>
> + =A0 =A0 =A0 /* MPC5121 based board */
> + =A0 =A0 =A0 i2c@1740 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121-i2c", "fsl-=
i2c";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x1740 0x20>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <11 0x8>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&ipic>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock-frequency =3D <100000>;
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 i2ccontrol@1760 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121-i2c-ctrl";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x1760 0x8>;
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 /* MPC5200B based board */
> =A0 =A0 =A0 =A0i2c@3d00 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#address-cells =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#size-cells =3D <0>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc5200b-i2c","fsl=
,mpc5200-i2c","fsl-i2c";
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <0>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x3d00 0x40>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <2 15 0>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D <&mpc5200_pic>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fsl,preserve-clocking;
> =A0 =A0 =A0 =A0};
>
> + =A0 =A0 =A0 /* MPC8544 base board */
> =A0 =A0 =A0 =A0i2c@3100 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#address-cells =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#size-cells =3D <0>;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc8544-i2c", "fsl=
-i2c";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x3100 0x100>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <43 2>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D <&mpic>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clock-frequency =3D <400000>;
> =A0 =A0 =A0 =A0};
> -
> --
> 1.6.2.5
>
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
