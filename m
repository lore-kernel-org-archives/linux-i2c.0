From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 08/12] mpc5121: Added I2C support.
Date: Wed, 6 May 2009 15:01:38 -0600
Message-ID: <fa686aa40905061401k319313c5q89fd3e245c30808f@mail.gmail.com>
References: <1241640919-4650-1-git-send-email-wd@denx.de> <1241640919-4650-9-git-send-email-wd@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1241640919-4650-9-git-send-email-wd-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Piotr Ziecik <kosmo-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, John Rigby <jcrigby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, May 6, 2009 at 2:15 PM, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org> wrote:
> From: Piotr Ziecik <kosmo-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
>
> - Enabled I2C interrupts on MPC5121.
> - Updated Kconfig for i2c-mpc driver.

I think this workaround belongs in the driver itself.

g.

>
> Signed-off-by: Piotr Ziecik <kosmo-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
> Signed-off-by: Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
> Cc: <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> Cc: John Rigby <jcrigby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> =A0arch/powerpc/platforms/512x/mpc5121_ads.c =A0 =A0| =A0 =A02 ++
> =A0arch/powerpc/platforms/512x/mpc512x.h =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0arch/powerpc/platforms/512x/mpc512x_shared.c | =A0 24 ++++++++++++=
++++++++++++
> =A0drivers/i2c/busses/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A09 +++++----
> =A04 files changed, 32 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/platforms/512x/mpc5121_ads.c b/arch/powerpc=
/platforms/512x/mpc5121_ads.c
> index 441abc4..a8976b4 100644
> --- a/arch/powerpc/platforms/512x/mpc5121_ads.c
> +++ b/arch/powerpc/platforms/512x/mpc5121_ads.c
> @@ -42,6 +42,8 @@ static void __init mpc5121_ads_setup_arch(void)
> =A0 =A0 =A0 =A0for_each_compatible_node(np, "pci", "fsl,mpc5121-pci")
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mpc83xx_add_bridge(np);
> =A0#endif
> +
> + =A0 =A0 =A0 mpc512x_init_i2c();
> =A0}
>
> =A0static void __init mpc5121_ads_init_IRQ(void)
> diff --git a/arch/powerpc/platforms/512x/mpc512x.h b/arch/powerpc/pla=
tforms/512x/mpc512x.h
> index 9c03693..f4db8a7 100644
> --- a/arch/powerpc/platforms/512x/mpc512x.h
> +++ b/arch/powerpc/platforms/512x/mpc512x.h
> @@ -13,5 +13,6 @@
> =A0#define __MPC512X_H__
> =A0extern unsigned long mpc512x_find_ips_freq(struct device_node *nod=
e);
> =A0extern void __init mpc512x_init_IRQ(void);
> +extern void __init mpc512x_init_i2c(void);
> =A0void __init mpc512x_declare_of_platform_devices(void);
> =A0#endif =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* __MPC512=
X_H__ */
> diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powe=
rpc/platforms/512x/mpc512x_shared.c
> index 7135d89..b776e45 100644
> --- a/arch/powerpc/platforms/512x/mpc512x_shared.c
> +++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
> @@ -65,6 +65,30 @@ void __init mpc512x_init_IRQ(void)
> =A0 =A0 =A0 =A0ipic_set_default_priority();
> =A0}
>
> +void __init mpc512x_init_i2c(void)
> +{
> + =A0 =A0 =A0 struct device_node *np;
> + =A0 =A0 =A0 void __iomem *i2cctl;
> +
> + =A0 =A0 =A0 /* Enable I2C interrupts */
> + =A0 =A0 =A0 np =3D of_find_compatible_node(NULL, NULL, "fsl,mpc5121=
-i2c-ctrl");
> + =A0 =A0 =A0 if (np) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2cctl =3D of_iomap(np, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i2cctl) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Set interrupt enab=
le bits:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* =A0- I2C-0: bit 24=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* =A0- I2C-1: bit 26=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* =A0- I2C-2: bit 28=
=2E
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(i2cctl, 0x1500=
0000);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(i2cctl);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(np);
> + =A0 =A0 =A0 }
> +}
> +
> =A0/*
> =A0* Nodes to do bus probe on, soc and localbus
> =A0*/
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index a48c8ae..57ed637 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -391,13 +391,14 @@ config I2C_IXP2000
> =A0 =A0 =A0 =A0 =A0instead.
>
> =A0config I2C_MPC
> - =A0 =A0 =A0 tristate "MPC107/824x/85xx/52xx/86xx"
> + =A0 =A0 =A0 tristate "MPC107/824x/85xx/512x/52xx/86xx"
> =A0 =A0 =A0 =A0depends on PPC32
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0If you say yes to this option, support will be inc=
luded for the
> - =A0 =A0 =A0 =A0 built-in I2C interface on the MPC107/Tsi107/MPC8240=
/MPC8245 and
> - =A0 =A0 =A0 =A0 MPC85xx/MPC8641 family processors. The driver may a=
lso work on 52xx
> - =A0 =A0 =A0 =A0 family processors, though interrupts are known not =
to work.
> + =A0 =A0 =A0 =A0 built-in I2C interface on the MPC107/Tsi107/MPC8240=
/MPC8245,
> + =A0 =A0 =A0 =A0 MPC85xx/MPC8641 and MPC512x family processors. The =
driver may
> + =A0 =A0 =A0 =A0 also work on 52xx family processors, though interru=
pts are known
> + =A0 =A0 =A0 =A0 not to work.
>
> =A0 =A0 =A0 =A0 =A0This driver can also be built as a module. =A0If s=
o, the module
> =A0 =A0 =A0 =A0 =A0will be called i2c-mpc.
> --
> 1.6.0.6
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
