From: Fuqian Huang <huangfq.daxian@gmail.com>
Subject: Re: [PATCH] i2c: avoid sleep in IRQ context
Date: Wed, 7 Aug 2019 15:04:19 +0800
Message-ID: <CABXRUiRscm=b0=bS-Dcxr_7bE45vcqv98SzJCBVsO67cgJOByg@mail.gmail.com>
References: <20190805123134.23199-1-huangfq.daxian@gmail.com> <20190807065111.GA17104@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190807065111.GA17104@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: "Adamski, Krzysztof (Nokia - PL/Wroclaw)" <krzysztof.adamski@nokia.com>, linux-i2c@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Adamski, Krzysztof (Nokia - PL/Wroclaw) <krzysztof.adamski@nokia.com>
=E6=96=BC 2019=E5=B9=B48=E6=9C=887=E6=97=A5=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=
=8D=882:51=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, Aug 05, 2019 at 08:31:34PM +0800, Fuqian Huang wrote:
> >i2c_pxa_handler -> i2c_pxa_irq_txempty ->
> >i2c_pxa_reset -> i2c_pxa_set_slave -> i2c_pxa_wait_slave
> >
> >As i2c_pxa_handler is an interrupt handler, it will finally
> >calls i2c_pxa_wait_slave which calls msleep.
> >
> >Add in_interrupt check before msleep to avoid sleep
> >in IRQ context.
> >
> >Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> >---
> > drivers/i2c/busses/i2c-pxa.c | 2 ++
> > 1 file changed, 2 insertions(+)
> >
> >diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> >index 2c3c3d6935c0..b35a0e8efcb2 100644
> >--- a/drivers/i2c/busses/i2c-pxa.c
> >+++ b/drivers/i2c/busses/i2c-pxa.c
> >@@ -443,6 +443,8 @@ static int i2c_pxa_wait_slave(struct pxa_i2c *i2c)
> >
> >       show_state(i2c);
> >
> >+      if (in_interrupt())
> >+              return 0;
>
> Sleeping in irq context is not good indeed but if you just return here,
> an error will be printed from i2c_pxa_set_slave() and cleanup of ICR
> will be skipped. Is that ok?
Sorry for this mistake.
Maybe it should be changed to mdelay.
And the new patch is like this:
if (in_interrupt()) {
   mdelay(1);
} else {
   msleep(1);
}
>
> >       while (time_before(jiffies, timeout)) {
> >               if (i2c_debug > 1)
> >                       dev_dbg(&i2c->adap.dev, "%s: %ld: ISR=3D%08x, ICR=
=3D%08x, IBMR=3D%02x\n",
>
