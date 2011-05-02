From: Konstantin Porotchkin <kostap-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Fix I2C combined access on Marvell mv64xxxx
Date: Mon, 2 May 2011 17:53:22 +0300
Message-ID: <BANLkTinV9g9KypLm5d=qDB4a943GoMYU6A@mail.gmail.com>
References: <1301582411-2437-1-git-send-email-kostap@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1301582411-2437-1-git-send-email-kostap-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello, Ben,

Are you going to integrate Marvel's i2c patches dated March 31 to the
kernel tree?

Thank you for your help
Konstantin

On Thu, Mar 31, 2011 at 5:40 PM, Konstantin Porotchkin
<kostap-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org> wrote:
> Eliminate erroneus data send in combined access mode when INT
> is cleared in i2c controller. Instead disable INT delivery to CPU
> and re-enable it on the next START.
>
> Signed-off-by: Konstantin Porotchkin <kostap-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> ---
> =C2=A0drivers/i2c/busses/i2c-mv64xxx.c | =C2=A0 19 +++++++++++++++---=
-
> =C2=A01 files changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2=
c-mv64xxx.c
> index a9941c6..d013e25 100644
> --- a/drivers/i2c/busses/i2c-mv64xxx.c
> +++ b/drivers/i2c/busses/i2c-mv64xxx.c
> @@ -15,6 +15,7 @@
> =C2=A0#include <linux/spinlock.h>
> =C2=A0#include <linux/i2c.h>
> =C2=A0#include <linux/interrupt.h>
> +#include <linux/delay.h>
> =C2=A0#include <linux/mv643xx_i2c.h>
> =C2=A0#include <linux/platform_device.h>
> =C2=A0#include <linux/io.h>
> @@ -98,6 +99,7 @@ struct mv64xxx_i2c_data {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rc;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 freq_m;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 freq_n;
> + =C2=A0 =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 irq_disabled;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0wait_queue_head_t =C2=A0 =C2=A0 =C2=A0 wai=
tq;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0spinlock_t =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0lock;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct i2c_msg =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0*msg;
> @@ -239,10 +241,11 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *=
drv_data)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0switch(drv_data->action) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0case MV64XXX_I2C_ACTION_SEND_RESTART:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 drv_data->cntl_bit=
s |=3D MV64XXX_I2C_REG_CONTROL_START;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 drv_data->cntl_bit=
s &=3D ~MV64XXX_I2C_REG_CONTROL_INTEN;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 writel(drv_data->c=
ntl_bits,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 drv_data->reg_base + MV64XXX_I2C_REG_CONTROL);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* can't mask inte=
rrupts by clearing the INTEN as this
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* triggers t=
he controller to send the data.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 drv_data->irq_disa=
bled =3D 1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disable_irq_nosync=
(drv_data->irq);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0drv_data->bloc=
k =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wake_up_interr=
uptible(&drv_data->waitq);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
> @@ -255,6 +258,11 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *d=
rv_data)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0case MV64XXX_I2C_ACTION_SEND_START:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0writel(drv_dat=
a->cntl_bits | MV64XXX_I2C_REG_CONTROL_START,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0drv_data->reg_base + MV64XXX_I2C_REG_CONTROL);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (drv_data->irq_=
disabled) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 udelay(3);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 drv_data->irq_disabled =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 enable_irq(drv_data->irq);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0case MV64XXX_I2C_ACTION_SEND_ADDR_1:
> @@ -327,6 +335,8 @@ mv64xxx_i2c_intr(int irq, void *dev_id)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mv64xxx_i2c_fs=
m(drv_data, status);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mv64xxx_i2c_do=
_action(drv_data);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D IRQ_HAN=
DLED;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (drv_data->stat=
e =3D=3D MV64XXX_I2C_STATE_WAITING_FOR_RESTART)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 break;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&drv_data->lock, fl=
ags);
>
> @@ -553,6 +563,7 @@ mv64xxx_i2c_probe(struct platform_device *pd)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D -ENXIO;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto exit_unma=
p_regs;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 drv_data->irq_disabled =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0drv_data->adapter.dev.parent =3D &pd->dev;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0drv_data->adapter.algo =3D &mv64xxx_i2c_al=
go;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0drv_data->adapter.owner =3D THIS_MODULE;
> --
> 1.7.4.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" =
in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
