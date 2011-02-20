From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] i2c: tegra: Add i2c support
Date: Sun, 20 Feb 2011 23:38:29 +0000
Message-ID: <20110220233829.GM15795@trinity.fluff.org>
References: <1297169061-17689-1-git-send-email-broonie@opensource.wolfsonmicro.com> <4D5B10E3.5030208@fluff.org> <AANLkTinZffOGSfOoNY4=8UzRDEVHHDdGXE26V3mbHm93@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTinZffOGSfOoNY4=8UzRDEVHHDdGXE26V3mbHm93-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, Feb 20, 2011 at 11:49:56AM -0800, Colin Cross wrote:
> On Tue, Feb 15, 2011 at 3:48 PM, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> wrote:
> > On 08/02/11 12:44, Mark Brown wrote:
> >> From: Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
> >
> > Some sort of explanation here would have been nice.
> Will fix
>=20
> >> Signed-off-by: Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
> >> Signed-off-by: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
> >> ---
> >> =A0drivers/i2c/busses/Kconfig =A0 =A0 | =A0 =A07 +
> >> =A0drivers/i2c/busses/Makefile =A0 =A0| =A0 =A01 +
> >> =A0drivers/i2c/busses/i2c-tegra.c | =A0665 +++++++++++++++++++++++=
+++++++++++++++++
> >> =A0include/linux/i2c-tegra.h =A0 =A0 =A0| =A0 25 ++
> >> =A04 files changed, 698 insertions(+), 0 deletions(-)
> >> =A0create mode 100644 drivers/i2c/busses/i2c-tegra.c
> >> =A0create mode 100644 include/linux/i2c-tegra.h
> >>
> >> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconf=
ig
> >> index 30f8dbd..b76a2a4 100644
> >> --- a/drivers/i2c/busses/Kconfig
> >> +++ b/drivers/i2c/busses/Kconfig
> >
> > Fine.
> >
> >> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Make=
file
> >> index 3c630b7..f505253 100644
> >> --- a/drivers/i2c/busses/Makefile
> >> +++ b/drivers/i2c/busses/Makefile
> >
> > Fine.
> >
> >> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i=
2c-tegra.c
> >> new file mode 100644
> >> index 0000000..cfa0084
> >> --- /dev/null
> >> +++ b/drivers/i2c/busses/i2c-tegra.c
> >> @@ -0,0 +1,665 @@
> >> +/*
> >> + * drivers/i2c/busses/i2c-tegra.c
> >> + *
> >> + * Copyright (C) 2010 Google, Inc.
> >> + * Author: Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
> >> + *
> >> + * This software is licensed under the terms of the GNU General P=
ublic
> >> + * License version 2, as published by the Free Software Foundatio=
n, and
> >> + * may be copied, distributed, and modified under those terms.
> >> + *
> >> + * This program is distributed in the hope that it will be useful=
,
> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See th=
e
> >> + * GNU General Public License for more details.
> >> + *
> >> + */
> >> +
> >> +#include <linux/kernel.h>
> >> +#include <linux/init.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/clk.h>
> >> +#include <linux/i2c.h>
> >> +#include <linux/io.h>
> >> +#include <linux/interrupt.h>
> >> +#include <linux/delay.h>
> >> +#include <linux/slab.h>
> >> +#include <linux/i2c-tegra.h>
> >> +
> >> +#include <asm/unaligned.h>
> >> +
> >> +#include <mach/clk.h>
> >
> > I don't think you should be including
> mach/clk.h provides the definitions of tegra_assert_periph_reset.  Th=
e
> Tegra resets are part of the clock controller, and the I2C bus
> requires resets at various times, including after a NACK.  It does no=
t
> export any of the private clock implementation.
>=20
> >> +
> >> +struct tegra_i2c_dev {
> >> + =A0 =A0 struct device *dev;
> >> + =A0 =A0 struct i2c_adapter adapter;
> >> + =A0 =A0 struct clk *clk;
> >> + =A0 =A0 struct clk *i2c_clk;
> >> + =A0 =A0 struct resource *iomem;
> >> + =A0 =A0 void __iomem *base;
> >> + =A0 =A0 int cont_id;
> >> + =A0 =A0 int irq;
> >> + =A0 =A0 int is_dvc;
> >> + =A0 =A0 struct completion msg_complete;
> >> + =A0 =A0 int msg_err;
> >> + =A0 =A0 u8 *msg_buf;
> >> + =A0 =A0 size_t msg_buf_remaining;
> >> + =A0 =A0 int msg_read;
> >> + =A0 =A0 int msg_transfer_complete;
> >> + =A0 =A0 unsigned long bus_clk_rate;
> >> + =A0 =A0 bool is_suspended;
> >> +};
> >
> > would have been nice to have some kerneldoc for this.
> Will do
>=20
> >> +/*
> >> + * i2c_writel and i2c_readl will offset the register if necessary=
 to talk
> >> + * to the I2C block inside the DVC block
> >> + */
> >> +static void i2c_writel(struct tegra_i2c_dev *i2c_dev, u32 val, un=
signed long reg)
> >> +{
> >> + =A0 =A0 if (i2c_dev->is_dvc)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D (reg >=3D I2C_TX_FIFO) ? 0x10 :=
 0x40;
> >> + =A0 =A0 writel(val, i2c_dev->base + reg);
> >> +}
> >> +
> >> +static u32 i2c_readl(struct tegra_i2c_dev *i2c_dev, unsigned long=
 reg)
> >> +{
> >> + =A0 =A0 if (i2c_dev->is_dvc)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D (reg >=3D I2C_TX_FIFO) ? 0x10 :=
 0x40;
> >> + =A0 =A0 return readl(i2c_dev->base + reg);
> >> +}
> >
> > as a note, would have been better to wrap up the address changes in=
to
> > one place to ensure that they're consistent.
> Will fix
>=20
> > [snip]
> >
> >> +static void tegra_i2c_set_clk(struct tegra_i2c_dev *i2c_dev, unsi=
gned int freq)
> >> +{
> >> + =A0 =A0 clk_set_rate(i2c_dev->clk, freq * 8);
> >> +}
> >
> > hmm, really need a separate function?
> Will fix
>=20
> >> +static int tegra_i2c_flush_fifos(struct tegra_i2c_dev *i2c_dev)
> >> +{
> >> + =A0 =A0 unsigned long timeout =3D jiffies + HZ;
> >> + =A0 =A0 u32 val =3D i2c_readl(i2c_dev, I2C_FIFO_CONTROL);
> >> + =A0 =A0 val |=3D I2C_FIFO_CONTROL_TX_FLUSH | I2C_FIFO_CONTROL_RX=
_FLUSH;
> >> + =A0 =A0 i2c_writel(i2c_dev, val, I2C_FIFO_CONTROL);
> >> +
> >> + =A0 =A0 while (i2c_readl(i2c_dev, I2C_FIFO_CONTROL) &
> >> + =A0 =A0 =A0 =A0 =A0 =A0 (I2C_FIFO_CONTROL_TX_FLUSH | I2C_FIFO_CO=
NTROL_RX_FLUSH)) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (time_after(jiffies, timeout)) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(i2c_dev->dev, "=
timeout waiting for fifo flush\n");
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 }
> >> + =A0 =A0 =A0 =A0 =A0 =A0 msleep(1);
> >> + =A0 =A0 }
> >> + =A0 =A0 return 0;
> >> +}
> >> +
> >> +static int tegra_i2c_empty_rx_fifo(struct tegra_i2c_dev *i2c_dev)
> >> +{
> >> + =A0 =A0 u32 val;
> >> + =A0 =A0 int rx_fifo_avail;
> >> + =A0 =A0 int word;
> >> + =A0 =A0 u8 *buf =3D i2c_dev->msg_buf;
> >> + =A0 =A0 size_t buf_remaining =3D i2c_dev->msg_buf_remaining;
> >> + =A0 =A0 int words_to_transfer;
> >> +
> >> + =A0 =A0 val =3D i2c_readl(i2c_dev, I2C_FIFO_STATUS);
> >> + =A0 =A0 rx_fifo_avail =3D (val & I2C_FIFO_STATUS_RX_MASK) >>
> >> + =A0 =A0 =A0 =A0 =A0 =A0 I2C_FIFO_STATUS_RX_SHIFT;
> >> +
> >> + =A0 =A0 words_to_transfer =3D buf_remaining / BYTES_PER_FIFO_WOR=
D;
> >> + =A0 =A0 if (words_to_transfer > rx_fifo_avail)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 words_to_transfer =3D rx_fifo_avail;
> >> +
> >> + =A0 =A0 for (word =3D 0; word < words_to_transfer; word++) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 val =3D i2c_readl(i2c_dev, I2C_RX_FIFO);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 put_unaligned_le32(val, buf);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 buf +=3D BYTES_PER_FIFO_WORD;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 buf_remaining -=3D BYTES_PER_FIFO_WORD;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 rx_fifo_avail--;
> >> + =A0 =A0 }
> >
> > you know, there's a readsl() function that does this.
> I think readsl can't handle the possibly unaligned buf pointer.

it does. see arch/arm/lib/io-writesl.S for proof.

> > this whole function gives me the creeps, is there any reason why
> > we can't use the readsl or similar functions for this?
> Same here - readsl can't handle the alignment requirements, readsb
> can't  handle the required 32 bit register read, and the bytes in the
> same word but after the end buf may not be part of buf, so byte write=
s
> to buf are required.

You'll find it can, too. arch/arm/lib/io-readsl.S.

[snip]
=20
> >> +static int tegra_i2c_init(struct tegra_i2c_dev *i2c_dev)
> >> +{
> >> + =A0 =A0 u32 val;
> >> + =A0 =A0 int err =3D 0;
> >> +
> >> + =A0 =A0 clk_enable(i2c_dev->clk);
> >> +
> >> + =A0 =A0 tegra_periph_reset_assert(i2c_dev->clk);
> >> + =A0 =A0 udelay(2);
> >> + =A0 =A0 tegra_periph_reset_deassert(i2c_dev->clk);
> >> +
> >> + =A0 =A0 if (i2c_dev->is_dvc)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 tegra_dvc_init(i2c_dev);
> >> +
> >> + =A0 =A0 val =3D I2C_CNFG_NEW_MASTER_FSM | I2C_CNFG_PACKET_MODE_E=
N;
> >> + =A0 =A0 i2c_writel(i2c_dev, val, I2C_CNFG);
> >> + =A0 =A0 i2c_writel(i2c_dev, 0, I2C_INT_MASK);
> >> + =A0 =A0 tegra_i2c_set_clk(i2c_dev, i2c_dev->bus_clk_rate);
> >> +
> >> + =A0 =A0 val =3D 7 << I2C_FIFO_CONTROL_TX_TRIG_SHIFT |
> >> + =A0 =A0 =A0 =A0 =A0 =A0 0 << I2C_FIFO_CONTROL_RX_TRIG_SHIFT;
> >> + =A0 =A0 i2c_writel(i2c_dev, val, I2C_FIFO_CONTROL);
> >> +
> >> + =A0 =A0 if (tegra_i2c_flush_fifos(i2c_dev))
> >> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ETIMEDOUT;
> >> +
> >> + =A0 =A0 clk_disable(i2c_dev->clk);
> >> + =A0 =A0 return 0;
> >> +}
> >
> > err never gets returned. please remove or return.
> Should be returned, will fix.

good. unused return codes make maintainers cry.
=20
> >> +static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
> >> +{
> >> + =A0 =A0 u32 status;
> >> + =A0 =A0 const u32 status_err =3D I2C_INT_NO_ACK | I2C_INT_ARBITR=
ATION_LOST;
> >> + =A0 =A0 struct tegra_i2c_dev *i2c_dev =3D dev_id;
> >> +
> >> + =A0 =A0 status =3D i2c_readl(i2c_dev, I2C_INT_STATUS);
> >> +
> >> + =A0 =A0 if (status =3D=3D 0) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(i2c_dev->dev, "irq status 0 %08=
x\n",
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_readl(i2c_dev, I2C_P=
ACKET_TRANSFER_STATUS));
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
> >
> > maybe return IRQ_UNHANDED?
> Sure - there are some poorly understood cases where the I2C controlle=
r
> can assert its interrupt with no status bits, but the handling to
> detect it and reset the controller is not in this patch, so dev_warn
> and IRQ_UNHANDLED is better.

I'm not too concerned if you have `handled` it, but please note what
is happening.

> >> + =A0 =A0 if (WARN_ON(ret =3D=3D 0)) {
> >
> > suppose a WARN_ON() is OK here.
> >
> >
> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(i2c_dev->dev, "i2c transfer time=
d out\n");
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 tegra_i2c_init(i2c_dev);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 pr_debug("transfer complete: %d %d %d\n", ret, completio=
n_done(&i2c_dev->msg_complete), i2c_dev->msg_err);
> >
> > not dev_dbg()?
> Will fix
=20
> >> + =A0 =A0 if (likely(i2c_dev->msg_err =3D=3D I2C_ERR_NONE))
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> >> +
> >> + =A0 =A0 tegra_i2c_init(i2c_dev);
> >> + =A0 =A0 if (i2c_dev->msg_err =3D=3D I2C_ERR_NO_ACK) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (msg->flags & I2C_M_IGNORE_NAK)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return -EREMOTEIO;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 return -EIO;
> >> +}
> >
> > think that's fine.
> >
> > [snip]
> >
> >> +static int tegra_i2c_probe(struct platform_device *pdev)
> >> +{
> >> + =A0 =A0 struct tegra_i2c_dev *i2c_dev;
> >> + =A0 =A0 struct tegra_i2c_platform_data *pdata =3D pdev->dev.plat=
form_data;
> >> + =A0 =A0 struct resource *res;
> >> + =A0 =A0 struct resource *iomem;
> >> + =A0 =A0 struct clk *clk;
> >> + =A0 =A0 struct clk *i2c_clk;
> >> + =A0 =A0 void *base;
> >> + =A0 =A0 int irq;
> >> + =A0 =A0 int ret =3D 0;
> >> +
> >> + =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >> + =A0 =A0 if (!res) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no mem resource?\n"=
);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> >> + =A0 =A0 }
> >
> > -ENODEV gets ignored by the upper layer, maybe find something else =
to
> > return.
> I'll return -EINVAL

I really should get around to finish writing a good guide to this.
=20
> >> + =A0 =A0 iomem =3D request_mem_region(res->start, resource_size(r=
es), pdev->name);
> >> + =A0 =A0 if (!iomem) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "I2C region already =
claimed\n");
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 base =3D ioremap(iomem->start, resource_size(iomem));
> >> + =A0 =A0 if (!base) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Can't ioremap I2C r=
egion\n");
> >
> > would prefer Cannot
> Will fix
>=20
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> >> + =A0 =A0 if (!res) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no irq resource?\n"=
);
> >
> > No need for ? after this.
> Will fix
>=20
> >> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> >
> > and see again.
> Will fix
>=20
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_iounmap;
> >> + =A0 =A0 }
> >> + =A0 =A0 irq =3D res->start;
> >> +
> >> + =A0 =A0 clk =3D clk_get(&pdev->dev, NULL);
> >> + =A0 =A0 if (!clk) {
> >
> > you've departed from no dev_err() here.
> Will fix
>=20
> >> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_release_region;
> >> + =A0 =A0 }
> >> +
> >
> >
> >> + =A0 =A0 i2c_clk =3D clk_get(&pdev->dev, "i2c");
> >> + =A0 =A0 if (!i2c_clk) {
> >
> > see again.
> Will fix
>=20
> >> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_clk_put;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 i2c_dev =3D kzalloc(sizeof(struct tegra_i2c_dev), GFP_KE=
RNEL);
> >> + =A0 =A0 if (!i2c_dev) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_i2c_clk_put;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 i2c_dev->base =3D base;
> >> + =A0 =A0 i2c_dev->clk =3D clk;
> >> + =A0 =A0 i2c_dev->i2c_clk =3D i2c_clk;
> >> + =A0 =A0 i2c_dev->iomem =3D iomem;
> >> + =A0 =A0 i2c_dev->adapter.algo =3D &tegra_i2c_algo;
> >> + =A0 =A0 i2c_dev->irq =3D irq;
> >> + =A0 =A0 i2c_dev->cont_id =3D pdev->id;
> >> + =A0 =A0 i2c_dev->dev =3D &pdev->dev;
> >> + =A0 =A0 i2c_dev->bus_clk_rate =3D pdata ? pdata->bus_clk_rate : =
100000;
> >> +
> >> + =A0 =A0 if (pdev->id =3D=3D 3)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 i2c_dev->is_dvc =3D 1;
> >> + =A0 =A0 init_completion(&i2c_dev->msg_complete);
> >> +
> >> + =A0 =A0 platform_set_drvdata(pdev, i2c_dev);
> >> +
> >> + =A0 =A0 ret =3D tegra_i2c_init(i2c_dev);
> >> + =A0 =A0 if (ret)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_free;
> >
> > does tegra_i2c_init() print an appropriate error?
> Will fix
>=20
> >> +
> >> + =A0 =A0 ret =3D request_irq(i2c_dev->irq, tegra_i2c_isr, IRQF_DI=
SABLED,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 pdev->name, i2c_dev);
> >
> > hmm, do you really want to be running IRQF_DISABLED?
> No, I'll drop it.
>=20
> >> + =A0 =A0 if (ret) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Failed to request i=
rq %i\n", i2c_dev->irq);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_free;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 clk_enable(i2c_dev->i2c_clk);
> >> +
> >> + =A0 =A0 i2c_set_adapdata(&i2c_dev->adapter, i2c_dev);
> >> + =A0 =A0 i2c_dev->adapter.owner =3D THIS_MODULE;
> >> + =A0 =A0 i2c_dev->adapter.class =3D I2C_CLASS_HWMON;
> >> + =A0 =A0 strlcpy(i2c_dev->adapter.name, "Tegra I2C adapter",
> >> + =A0 =A0 =A0 =A0 =A0 =A0 sizeof(i2c_dev->adapter.name));
> >> + =A0 =A0 i2c_dev->adapter.algo =3D &tegra_i2c_algo;
> >> + =A0 =A0 i2c_dev->adapter.dev.parent =3D &pdev->dev;
> >> + =A0 =A0 i2c_dev->adapter.nr =3D pdev->id;
> >> +
> >> + =A0 =A0 ret =3D i2c_add_numbered_adapter(&i2c_dev->adapter);
> >> + =A0 =A0 if (ret) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Failed to add I2C a=
dapter\n");
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_irq;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 return 0;
> >> +err_free_irq:
> >> + =A0 =A0 free_irq(i2c_dev->irq, i2c_dev);
> >> +err_free:
> >> + =A0 =A0 kfree(i2c_dev);
> >> +err_i2c_clk_put:
> >> + =A0 =A0 clk_put(i2c_clk);
> >> +err_clk_put:
> >> + =A0 =A0 clk_put(clk);
> >> +err_release_region:
> >> + =A0 =A0 release_mem_region(iomem->start, resource_size(iomem));
> >> +err_iounmap:
> >> + =A0 =A0 iounmap(base);
> >> + =A0 =A0 return ret;
> >> +}
> >
> > [snip]
> >
> > how about MODULE_* decelerations at the end of this, with license, =
etc?
> Will fix
> >
> >> diff --git a/include/linux/i2c-tegra.h b/include/linux/i2c-tegra.h
> >> new file mode 100644
> >> index 0000000..9c85da4
> >> --- /dev/null
> >
> > looks ok.
> >
> > could do with a few tidies before inclusion.
> >
> > --
> > Ben
> >
> >

--=20
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disapp=
ear.
