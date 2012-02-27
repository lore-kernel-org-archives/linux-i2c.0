From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c/designware: Provide optional i2c bus recovery function
Date: Mon, 27 Feb 2012 12:51:48 +0530
Message-ID: <CAM=Q2cudYcSqAKk4qNg7MQxRBCkJ-XXXSL-Bg=sZ2+hvS_Qcxw@mail.gmail.com>
References: <0ca1d8990c23a45193a32d0e7e889620b995af59.1330082915.git.viresh.kumar@st.com>
	<351031347b845920a0ea78e7491d955137e3d7aa.1330082915.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <351031347b845920a0ea78e7491d955137e3d7aa.1330082915.git.viresh.kumar-qxv4g6HH51o@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, armando.visconti-qxv4g6HH51o@public.gmane.org, shiraz.hashim-qxv4g6HH51o@public.gmane.org, vipin.kumar-qxv4g6HH51o@public.gmane.org, rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org, deepak.sikri-qxv4g6HH51o@public.gmane.org, vipulkumar.samar-qxv4g6HH51o@public.gmane.org, amit.virdi-qxv4g6HH51o@public.gmane.org, pratyush.anand-qxv4g6HH51o@public.gmane.org, bhupesh.sharma-qxv4g6HH51o@public.gmane.org, viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bhavna.yadav-qxv4g6HH51o@public.gmane.org, vincenzo.frascino-qxv4g6HH51o@public.gmane.org, mirko.gardi-qxv4g6HH51o@public.gmane.org, salvatore.dedominicis-qxv4g6HH51o@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Feb 24, 2012 at 5:01 PM, Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org> wro=
te:
> From: Vincenzo Frascino <vincenzo.frascino-qxv4g6HH51o@public.gmane.org>
>
> Add optional i2c_recover_bus() function to the Synopsys DesignWare I2=
C adapter
> driver that performs i2c bus recovery after timeout. The scope of thi=
s routine
> is to define i2c bus recovery procedure as specified in the i2c proto=
col Rev. 03
> section 3.16 titled "Bus clear".
What do you do in the function ?

Could we have it in the driver file itself?

>
> Since the Designware I2C controller doesn't provide direct control ov=
er SDA and
> SCL lines hence the intent is to let platform try to recover the bus =
if they
> have the capability to take control of I2C pads and follow the recove=
ry
> protocol.

So the function is passed in the pdata.
>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino-qxv4g6HH51o@public.gmane.org>
> Signed-off-by: Shiraz Hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>
> Signed-off-by: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
> ---
> =A0drivers/i2c/busses/i2c-designware-core.c =A0 =A0| =A0 =A04 +++
> =A0drivers/i2c/busses/i2c-designware-core.h =A0 =A0| =A0 =A03 +-
> =A0drivers/i2c/busses/i2c-designware-platdrv.c | =A0 =A08 ++++++
> =A0include/linux/i2c/i2c-designware.h =A0 =A0 =A0 =A0 =A0| =A0 33 +++=
++++++++++++++++++++++++
> =A04 files changed, 47 insertions(+), 1 deletions(-)
> =A0create mode 100644 include/linux/i2c/i2c-designware.h
>
> diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/b=
usses/i2c-designware-core.c
> index df87992..91d9357 100644
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -525,6 +525,10 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c=
_msg msgs[], int num)
> =A0 =A0 =A0 =A0ret =3D wait_for_completion_interruptible_timeout(&dev=
->cmd_complete, HZ);
> =A0 =A0 =A0 =A0if (ret =3D=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev->dev, "controller timed ou=
t\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dev->i2c_recover_bus) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(dev->dev, "try=
 i2c bus recovery\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->i2c_recover_bus(de=
v->recovery_data);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i2c_dw_init(dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -ETIMEDOUT;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto done;
> diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/b=
usses/i2c-designware-core.h
> index 02d1a2d..e2f3119 100644
> --- a/drivers/i2c/busses/i2c-designware-core.h
> +++ b/drivers/i2c/busses/i2c-designware-core.h
> @@ -34,7 +34,6 @@
> =A0#define DW_IC_CON_RESTART_EN =A0 =A0 =A0 =A0 =A0 0x20
> =A0#define DW_IC_CON_SLAVE_DISABLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x4=
0
>
> -
> =A0/**
> =A0* struct dw_i2c_dev - private i2c-designware data
> =A0* @dev: driver model device node
> @@ -88,6 +87,8 @@ struct dw_i2c_dev {
> =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 master_cfg=
;
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0tx_fifo_depth;
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0rx_fifo_depth;
> + =A0 =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(*i2c_recov=
er_bus)(void *);
> + =A0 =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*recovery_d=
ata;
> =A0};
>
> =A0extern u32 dw_readl(struct dw_i2c_dev *dev, int offset);
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2=
c/busses/i2c-designware-platdrv.c
> index c5ac2dc..2237398 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -29,6 +29,7 @@
> =A0#include <linux/module.h>
> =A0#include <linux/delay.h>
> =A0#include <linux/i2c.h>
> +#include <linux/i2c/i2c-designware.h>
> =A0#include <linux/clk.h>
> =A0#include <linux/errno.h>
> =A0#include <linux/sched.h>
> @@ -55,6 +56,7 @@ static int __devinit dw_i2c_probe(struct platform_d=
evice *pdev)
> =A0 =A0 =A0 =A0struct dw_i2c_dev *dev;
> =A0 =A0 =A0 =A0struct i2c_adapter *adap;
> =A0 =A0 =A0 =A0struct resource *mem, *ioarea;
> + =A0 =A0 =A0 struct i2c_dw_pdata *pdata;
> =A0 =A0 =A0 =A0int irq, r;
>
> =A0 =A0 =A0 =A0/* NOTE: driver uses the static register mapping */
> @@ -98,6 +100,12 @@ static int __devinit dw_i2c_probe(struct platform=
_device *pdev)
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0clk_enable(dev->clk);
>
> + =A0 =A0 =A0 pdata =3D dev_get_platdata(&pdev->dev);
> + =A0 =A0 =A0 if (pdata && pdata->i2c_recover_bus) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->i2c_recover_bus =3D pdata->i2c_rec=
over_bus;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->recovery_data =3D &pdev;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0dev->functionality =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0I2C_FUNC_I2C |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0I2C_FUNC_10BIT_ADDR |
> diff --git a/include/linux/i2c/i2c-designware.h b/include/linux/i2c/i=
2c-designware.h
> new file mode 100644
> index 0000000..e40ad85
> --- /dev/null
> +++ b/include/linux/i2c/i2c-designware.h
> @@ -0,0 +1,33 @@
> +/*
> + * Synopsys DesignWare I2C adapter driver's platform data
> + *
> + * Copyright (C) 2012 ST Microelectronics.
> + * Author: Vincenzo Frascino <vincenzo.frascino-qxv4g6HH51o@public.gmane.org>
> + *
> + * This software is licensed under the terms of the GNU General Publ=
ic
> + * License version 2, as published by the Free Software Foundation, =
and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + */
> +#ifndef I2C_DESIGNWARE_H
> +#define I2C_DESIGNWARE_H
> +
> +#include <linux/platform_device.h>
> +
> +/* I2C Designware Platform Data */
> +struct i2c_dw_pdata {
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* The scope of this routine is to define i2c bus rec=
overy procedure
> + =A0 =A0 =A0 =A0* as specified in the i2c protocol Rev. 03 section 3=
=2E16 titled
> + =A0 =A0 =A0 =A0* "Bus clear".
> + =A0 =A0 =A0 =A0* Its implementation is platform dependant.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 void (*i2c_recover_bus)(void *);
> +};
> +
> +#endif /* I2C_DESIGNWARE_H */
> --
> 1.7.8.110.g4cb5d
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" =
in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
