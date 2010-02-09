From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v4 1/3] i2c-mpc: use __devinit[data] for initialization
	functions and data
Date: Tue, 9 Feb 2010 10:41:39 -0700
Message-ID: <fa686aa41002090941je3e4fdqbecf2616a8b90e42@mail.gmail.com>
References: <1264685141-26391-1-git-send-email-wg@grandegger.com>
	<1264685141-26391-2-git-send-email-wg@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1264685141-26391-2-git-send-email-wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Cc: Linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Jan 28, 2010 at 6:25 AM, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org=
> wrote:
> From: Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>
>
> "__devinit[data]" has not yet been used for all initialization functi=
ons
> and data. To avoid truncating lines, the struct "mpc_i2c_match_data" =
has
> been renamed to "mpc_i2c_data", which is even the better name.
>
> Signed-off-by: Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>

Several comments below.

> ---
> =A0drivers/i2c/busses/i2c-mpc.c | =A0103 +++++++++++++++++++---------=
-------------
> =A01 files changed, 48 insertions(+), 55 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mp=
c.c
> index f627001..275ebe6 100644
> --- a/drivers/i2c/busses/i2c-mpc.c
> +++ b/drivers/i2c/busses/i2c-mpc.c
> @@ -66,7 +66,7 @@ struct mpc_i2c_divider {
> =A0 =A0 =A0 =A0u16 fdr; =A0 =A0 =A0 =A0/* including dfsrr */
> =A0};
>
> -struct mpc_i2c_match_data {
> +struct mpc_i2c_data {
> =A0 =A0 =A0 =A0void (*setclock)(struct device_node *node,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct mpc_i2c *i2c,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 clock, u32 presca=
ler);
> @@ -165,7 +165,7 @@ static int i2c_wait(struct mpc_i2c *i2c, unsigned=
 timeout, int writing)
> =A0}
>
> =A0#ifdef CONFIG_PPC_MPC52xx
> -static const struct mpc_i2c_divider mpc_i2c_dividers_52xx[] =3D {
> +static const struct __devinitdata mpc_i2c_divider mpc_i2c_dividers_5=
2xx[] =3D {

__devinitdata goes at the end, immediately before the '=3D'.  Ditto
throughout the file.

> =A0 =A0 =A0 =A0{20, 0x20}, {22, 0x21}, {24, 0x22}, {26, 0x23},
> =A0 =A0 =A0 =A0{28, 0x24}, {30, 0x01}, {32, 0x25}, {34, 0x02},
> =A0 =A0 =A0 =A0{36, 0x26}, {40, 0x27}, {44, 0x04}, {48, 0x28},
> @@ -582,44 +584,35 @@ static int __devexit fsl_i2c_remove(struct of_d=
evice *op)
> =A0 =A0 =A0 =A0return 0;
> =A0};
>
> +static struct mpc_i2c_data __devinitdata mpc_i2c_data_52xx =3D {
> + =A0 =A0 =A0 .setclock =3D mpc_i2c_setclock_52xx,
> +};
> +
> +static struct mpc_i2c_data __devinitdata mpc_i2c_data_8313 =3D {
> + =A0 =A0 =A0 .setclock =3D mpc_i2c_setclock_8xxx,
> +};
> +
> +static struct mpc_i2c_data __devinitdata mpc_i2c_data_8543 =3D {
> + =A0 =A0 =A0 .setclock =3D mpc_i2c_setclock_8xxx,
> + =A0 =A0 =A0 .prescaler =3D 2,
> +};
> +
> +static struct mpc_i2c_data __devinitdata mpc_i2c_data_8544 =3D {
> + =A0 =A0 =A0 .setclock =3D mpc_i2c_setclock_8xxx,
> + =A0 =A0 =A0 .prescaler =3D 3,
> +};
> +
> =A0static const struct of_device_id mpc_i2c_of_match[] =3D {

You can make this __devinitdata too.

> - =A0 =A0 =A0 {.compatible =3D "mpc5200-i2c",
> - =A0 =A0 =A0 =A0.data =3D &(struct mpc_i2c_match_data) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .setclock =3D mpc_i2c_s=
etclock_52xx,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> - =A0 =A0 =A0 },
> - =A0 =A0 =A0 {.compatible =3D "fsl,mpc5200b-i2c",
> - =A0 =A0 =A0 =A0.data =3D &(struct mpc_i2c_match_data) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .setclock =3D mpc_i2c_s=
etclock_52xx,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> - =A0 =A0 =A0 },
> - =A0 =A0 =A0 {.compatible =3D "fsl,mpc5200-i2c",
> - =A0 =A0 =A0 =A0.data =3D &(struct mpc_i2c_match_data) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .setclock =3D mpc_i2c_s=
etclock_52xx,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> - =A0 =A0 =A0 },
> - =A0 =A0 =A0 {.compatible =3D "fsl,mpc8313-i2c",
> - =A0 =A0 =A0 =A0.data =3D &(struct mpc_i2c_match_data) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .setclock =3D mpc_i2c_s=
etclock_8xxx,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> - =A0 =A0 =A0 },
> - =A0 =A0 =A0 {.compatible =3D "fsl,mpc8543-i2c",
> - =A0 =A0 =A0 =A0.data =3D &(struct mpc_i2c_match_data) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .setclock =3D mpc_i2c_s=
etclock_8xxx,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .prescaler =3D 2,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> - =A0 =A0 =A0 },
> - =A0 =A0 =A0 {.compatible =3D "fsl,mpc8544-i2c",
> - =A0 =A0 =A0 =A0.data =3D &(struct mpc_i2c_match_data) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .setclock =3D mpc_i2c_s=
etclock_8xxx,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .prescaler =3D 3,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 {.compatible =3D "mpc5200-i2c", .data =3D &mpc_i2c_data=
_52xx, },
> + =A0 =A0 =A0 {.compatible =3D "fsl,mpc5200b-i2c", .data =3D &mpc_i2c=
_data_52xx, },
> + =A0 =A0 =A0 {.compatible =3D "fsl,mpc5200-i2c", .data =3D &mpc_i2c_=
data_52xx, },
> + =A0 =A0 =A0 {.compatible =3D "fsl,mpc8313-i2c", .data =3D &mpc_i2c_=
data_8313, },
> + =A0 =A0 =A0 {.compatible =3D "fsl,mpc8543-i2c", .data =3D &mpc_i2c_=
data_8543, },
> + =A0 =A0 =A0 {.compatible =3D "fsl,mpc8544-i2c", .data =3D &mpc_i2c_=
data_8544, },
> =A0 =A0 =A0 =A0/* Backward compatibility */
> - =A0 =A0 =A0 },
> =A0 =A0 =A0 =A0{.compatible =3D "fsl-i2c", },
> =A0 =A0 =A0 =A0{},
> =A0};
> -
> =A0MODULE_DEVICE_TABLE(of, mpc_i2c_of_match);
>
>
> @@ -634,7 +627,7 @@ static struct of_platform_driver mpc_i2c_driver =3D=
 {
> =A0 =A0 =A0 =A0},
> =A0};
>
> -static int __init fsl_i2c_init(void)
> +static int __devinit fsl_i2c_init(void)

No, __init was correct.  This is called as a module_init() not as a .pr=
obe hook.

> =A0{
> =A0 =A0 =A0 =A0int rv;
>
> @@ -645,7 +638,7 @@ static int __init fsl_i2c_init(void)
> =A0 =A0 =A0 =A0return rv;
> =A0}
>
> -static void __exit fsl_i2c_exit(void)
> +static void __devexit fsl_i2c_exit(void)

Same here for __exit.

> =A0{
> =A0 =A0 =A0 =A0of_unregister_platform_driver(&mpc_i2c_driver);
> =A0}
> --
> 1.6.2.5
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
