From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c-ocore: support 16 and 32-bit wide registers
Date: Tue, 8 May 2012 22:28:34 +0530
Message-ID: <CAM=Q2cuYCQu1McDD=otyyBFSG8Tw974Y146tAswZ3dD+USkiTw@mail.gmail.com>
References: <1336483529-19140-1-git-send-email-jayachandranc@netlogicmicro.com>
	<1336483529-19140-3-git-send-email-jayachandranc@netlogicmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1336483529-19140-3-git-send-email-jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Ganesan Ramalingam <ganesanr-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

On Tue, May 8, 2012 at 6:55 PM, Jayachandran C
<jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org> wrote:
> From: Ganesan Ramalingam <ganesanr-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>
> Some architectures supports only 16-bit or 32-bit read/write access
> to their iospace. Add a 'regwidth' platform and OF parameter which
> specifies the IO width to support these platforms.
>
> regwidth can be specified as 1, 2 or 4, and has a default value
> of 1 if it is unspecified.
>
> Signed-off-by: Ganesan Ramalingam <ganesanr-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Signed-off-by: Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
> ---
> =A0drivers/i2c/busses/i2c-ocores.c | =A0 32 +++++++++++++++++++++++++=
+++++--
> =A0include/linux/i2c-ocores.h =A0 =A0 =A0| =A0 =A01 +
> =A02 files changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c=
-ocores.c
> index ebd2700..1313145 100644
> --- a/drivers/i2c/busses/i2c-ocores.c
> +++ b/drivers/i2c/busses/i2c-ocores.c
> @@ -19,6 +19,9 @@
> =A0* - regstep =A0 =A0 =A0 =A0 : size of device registers in bytes
> =A0* - clock-frequency : frequency of bus clock in Hz
> =A0*
> + * Optional properties:
> + * - regwidth =A0 =A0 =A0 =A0: io register width in bytes (1, 2 or 4=
)
> +
> =A0* Example:
> =A0*
> =A0* =A0i2c0: ocores@a0000000 {
> @@ -27,6 +30,7 @@
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <10>;
> =A0*
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0regstep =3D <1>;
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0regwidth =3D <1>;
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0clock-frequency =3D <20000000>;
> =A0*
> =A0* -- Devices connected on this I2C bus get
> @@ -60,6 +64,7 @@
> =A0struct ocores_i2c {
> =A0 =A0 =A0 =A0void __iomem *base;
> =A0 =A0 =A0 =A0int regstep;
> + =A0 =A0 =A0 int regwidth;

Do we need it to be signed?

> =A0 =A0 =A0 =A0wait_queue_head_t wait;
> =A0 =A0 =A0 =A0struct i2c_adapter adap;
> =A0 =A0 =A0 =A0struct i2c_msg *msg;
> @@ -102,12 +107,22 @@ struct ocores_i2c {
>
> =A0static inline void oc_setreg(struct ocores_i2c *i2c, int reg, u8 v=
alue)
> =A0{
> - =A0 =A0 =A0 iowrite8(value, i2c->base + reg * i2c->regstep);
> + =A0 =A0 =A0 if (i2c->regwidth =3D=3D 4)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(value, i2c->base + reg * i2c-=
>regstep);
> + =A0 =A0 =A0 else if (i2c->regwidth =3D=3D 2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite16(value, i2c->base + reg * i2c-=
>regstep);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite8(value, i2c->base + reg * i2c->=
regstep);
> =A0}
>
> =A0static inline u8 oc_getreg(struct ocores_i2c *i2c, int reg)
Shouldnt the return type also change?

> =A0{
> - =A0 =A0 =A0 return ioread8(i2c->base + reg * i2c->regstep);
> + =A0 =A0 =A0 if (i2c->regwidth =3D=3D 4)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ioread32(i2c->base + reg * i2c->=
regstep);
> + =A0 =A0 =A0 else if (i2c->regwidth =3D=3D 2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ioread16(i2c->base + reg * i2c->=
regstep);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ioread8(i2c->base + reg * i2c->r=
egstep);
> =A0}
>
> =A0static void ocores_process(struct ocores_i2c *i2c)
> @@ -267,6 +282,10 @@ static int ocores_i2c_of_probe(struct platform_d=
evice* pdev,
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0i2c->clock_khz =3D be32_to_cpup(val) / 1000;
>
> + =A0 =A0 =A0 val =3D of_get_property(pdev->dev.of_node, "regwidth", =
NULL);
> + =A0 =A0 =A0 if (val)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c->regwidth =3D be32_to_cpup(val);
> +
> =A0 =A0 =A0 =A0return 0;
> =A0}
> =A0#else
> @@ -309,12 +328,21 @@ static int __devinit ocores_i2c_probe(struct pl=
atform_device *pdev)
> =A0 =A0 =A0 =A0pdata =3D pdev->dev.platform_data;
> =A0 =A0 =A0 =A0if (pdata) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i2c->regstep =3D pdata->regstep;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c->regwidth =3D pdata->regwidth;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i2c->clock_khz =3D pdata->clock_khz;
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D ocores_i2c_of_probe(pdev, i2c)=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
> =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 if (i2c->regwidth =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c->regwidth =3D 1; =A0 =A0 =A0/* not =
configured, use default */
> + =A0 =A0 =A0 else if (i2c->regwidth !=3D 1 && i2c->regwidth !=3D 2 &=
&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c->regwidth !=3D 4) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Invalid register w=
idth %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c->regwidth);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0ocores_init(i2c);
>
> diff --git a/include/linux/i2c-ocores.h b/include/linux/i2c-ocores.h
> index 4d5e57f..d1258ad 100644
> --- a/include/linux/i2c-ocores.h
> +++ b/include/linux/i2c-ocores.h
> @@ -13,6 +13,7 @@
>
> =A0struct ocores_i2c_platform_data {
> =A0 =A0 =A0 =A0u32 regstep; =A0 /* distance between registers */
> + =A0 =A0 =A0 u32 regwidth; =A0/* io read/write register witdth */
> =A0 =A0 =A0 =A0u32 clock_khz; /* input clock in kHz */
> =A0 =A0 =A0 =A0u8 num_devices; /* number of devices in the devices li=
st */
> =A0 =A0 =A0 =A0struct i2c_board_info const *devices; /* devices conne=
cted to the bus */
> --
> 1.7.9.5
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" =
in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
