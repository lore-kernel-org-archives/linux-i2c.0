From: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH v2] i2c: imx: convert to use managed functions
Date: Mon, 4 Jun 2012 18:46:25 +0800
Message-ID: <20120604104624.GD2857@b20223-02.ap.freescale.net>
References: <1338776481-23710-1-git-send-email-richard.zhao@freescale.com>
 <CAM=Q2ctTNs0hq9tO5NW0QGsGaOVMNobRSBg_TmCjbaV+hNaoAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAM=Q2ctTNs0hq9tO5NW0QGsGaOVMNobRSBg_TmCjbaV+hNaoAw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Richard Zhao <richard.zhao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Shubhrajyoti,

On Mon, Jun 04, 2012 at 10:29:11AM +0530, Shubhrajyoti Datta wrote:
> Hi  Richard,
>=20
> On Mon, Jun 4, 2012 at 7:51 AM, Richard Zhao <richard.zhao@freescale.=
com> wrote:
> > From: Richard Zhao <richard.zhao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> nit: A small description would have helped.
The title has told what it did, but I'd like to add more description.
> Otherwise Looks good to me.
> Reviewed-by: Shubhrajyoti D <Shubhrajyoti-l0cyMroinI0@public.gmane.org>
Thanks.
> >
> > Signed-off-by: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > ---
> >
> > Changes since v1:
> > =A0- rebase to 3.5rc1
> > =A0- remove unused imx_i2c_struct.irq.
> >
> > =A0drivers/i2c/busses/i2c-imx.c | =A0 67 ++++++++++----------------=
---------------
> > =A01 files changed, 17 insertions(+), 50 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-=
imx.c
> > index 8d6b504..7f4da2d 100644
> > --- a/drivers/i2c/busses/i2c-imx.c
> > +++ b/drivers/i2c/busses/i2c-imx.c
> > @@ -118,10 +118,8 @@ static u16 __initdata i2c_clk_div[50][2] =3D {
> >
> > =A0struct imx_i2c_struct {
> > =A0 =A0 =A0 =A0struct i2c_adapter =A0 =A0 =A0adapter;
> > - =A0 =A0 =A0 struct resource =A0 =A0 =A0 =A0 *res;
> > =A0 =A0 =A0 =A0struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0*clk;
> > =A0 =A0 =A0 =A0void __iomem =A0 =A0 =A0 =A0 =A0 =A0*base;
> > - =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq;
> > =A0 =A0 =A0 =A0wait_queue_head_t =A0 =A0 =A0 queue;
> > =A0 =A0 =A0 =A0unsigned long =A0 =A0 =A0 =A0 =A0 i2csr;
> > =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0disable_delay;
> > @@ -473,7 +471,6 @@ static int __init i2c_imx_probe(struct platform=
_device *pdev)
> > =A0 =A0 =A0 =A0struct imxi2c_platform_data *pdata =3D pdev->dev.pla=
tform_data;
> > =A0 =A0 =A0 =A0struct pinctrl *pinctrl;
> > =A0 =A0 =A0 =A0void __iomem *base;
> > - =A0 =A0 =A0 resource_size_t res_size;
> > =A0 =A0 =A0 =A0int irq, bitrate;
> > =A0 =A0 =A0 =A0int ret;
> >
> > @@ -490,25 +487,16 @@ static int __init i2c_imx_probe(struct platfo=
rm_device *pdev)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOENT;
> > =A0 =A0 =A0 =A0}
> >
> > - =A0 =A0 =A0 res_size =3D resource_size(res);
> > -
> > - =A0 =A0 =A0 if (!request_mem_region(res->start, res_size, DRIVER_=
NAME)) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "request_mem_regi=
on failed\n");
> > + =A0 =A0 =A0 base =3D devm_request_and_ioremap(&pdev->dev, res);
> > + =A0 =A0 =A0 if (!base)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EBUSY;
> > - =A0 =A0 =A0 }
> > -
> > - =A0 =A0 =A0 base =3D ioremap(res->start, res_size);
> > - =A0 =A0 =A0 if (!base) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "ioremap failed\n=
");
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EIO;
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail1;
> > - =A0 =A0 =A0 }
> >
> > - =A0 =A0 =A0 i2c_imx =3D kzalloc(sizeof(struct imx_i2c_struct), GF=
P_KERNEL);
> > + =A0 =A0 =A0 i2c_imx =3D devm_kzalloc(&pdev->dev, sizeof(struct im=
x_i2c_struct),
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_K=
ERNEL);
> > =A0 =A0 =A0 =A0if (!i2c_imx) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&pdev->dev, "can't allocate =
interface\n");
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -ENOMEM;
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail2;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> nit : why not return ENOMEM directly, the copy to ret is redundant.
> feel free to ignore if you  feel so.
Nice catch. :)

Thanks
Richard
