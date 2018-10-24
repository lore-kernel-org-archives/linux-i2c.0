From: Federico Vaga <federico.vaga@cern.ch>
Subject: Re: [PATCH 1/3] i2c:ocores: stop transfer on timeout
Date: Wed, 24 Oct 2018 16:51:04 +0200
Message-ID: <1549360.saVjYH78Bt@pcbe13614>
References: <20180625161303.7991-1-federico.vaga@cern.ch> <20180625161303.7991-2-federico.vaga@cern.ch> <CACXmVia0vStmBwd4ndFk6UjE9wGsjp7Y75ej0AGq68H8-XkZqw@mail.gmail.com>
Reply-To: <federico.vaga@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACXmVia0vStmBwd4ndFk6UjE9wGsjp7Y75ej0AGq68H8-XkZqw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sunday, October 21, 2018 4:10:30 PM CEST Peter Korsgaard wrote:
> On Mon, Jun 25, 2018 at 6:14 PM Federico Vaga <federico.vaga@cern.ch> wrote:
> 
> Hi, and sorry for the slow response.
> 
> > Detecting a timeout is ok, but we also need to assert a STOP command on
> > the bus in order to prevent it from generating interrupts when there are
> > no on going transfers.
> > 
> > Example: very long transmission.
> > 
> > 1. ocores_xfer: START a transfer
> > 2. ocores_isr : handle byte by byte the transfer
> > 3. ocores_xfer: goes in timeout [[bugfix here]]
> > 4. ocores_xfer: return to I2C subsystem and to the I2C driver
> > 5. I2C driver : it may clean up the i2c_msg memory
> > 6. ocores_isr : receives another interrupt (pending bytes to be
> > 
> >                 transferred) but the i2c_msg memory is invalid now
> > 
> > So, since the transfer was too long, we have to detect the timeout and
> > STOP the transfer.
> > 
> > Another point is that we have a critical region here. When handling the
> > timeout condition we may have a running IRQ handler. For this reason I
> > introduce a spinlock. In the IRQ handler we can just use trylock because
> > if the lock is taken is because we are in timeout, so there is no need to
> > process the IRQ.
> > 
> > Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
> > ---
> > 
> >  drivers/i2c/busses/i2c-ocores.c | 28 ++++++++++++++++++++++++++--
> >  1 file changed, 26 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-ocores.c
> > b/drivers/i2c/busses/i2c-ocores.c index 88444ef74943..98c0ef74882b 100644
> > --- a/drivers/i2c/busses/i2c-ocores.c
> > +++ b/drivers/i2c/busses/i2c-ocores.c
> > @@ -25,6 +25,7 @@
> > 
> >  #include <linux/slab.h>
> >  #include <linux/io.h>
> >  #include <linux/log2.h>
> > 
> > +#include <linux/spinlock.h>
> > 
> >  struct ocores_i2c {
> >  
> >         void __iomem *base;
> > 
> > @@ -36,6 +37,7 @@ struct ocores_i2c {
> > 
> >         int pos;
> >         int nmsgs;
> >         int state; /* see STATE_ */
> > 
> > +       spinlock_t xfer_lock;
> > 
> >         struct clk *clk;
> >         int ip_clock_khz;
> >         int bus_clock_khz;
> > 
> > @@ -207,15 +209,30 @@ static void ocores_process(struct ocores_i2c *i2c)
> > 
> >  static irqreturn_t ocores_isr(int irq, void *dev_id)
> >  {
> >  
> >         struct ocores_i2c *i2c = dev_id;
> > 
> > +       unsigned long flags;
> > +       int ret;
> > +
> > +       /*
> > +        * We need to protect i2c against a timeout event (see
> > ocores_xfer()) +        * If we cannot take this lock, it means that we
> > are already in +        * timeout, so it's pointless to handle this
> > interrupt because we +        * are going to abort the current transfer.
> > +        */
> > +       ret = spin_trylock_irqsave(&i2c->xfer_lock, flags);
> 
> This is very old code, so I might be missing something - But I still
> don't quite understand this trylock logic. If we end up here with the
> lock taken, then that must mean that we are on SMP system. We still
> need to ack the interrupt, so just spinning until the other CPU
> releases the lock seems more sensible?

I think you are right.

When I wrote that, I had the idea the STOP command stops the ongoing I2C 
transfer and clear IACK automatically (I do not remember why I had this idea 
in mind, unfortunately I did not take notes about this). So in that case, 
having done STOP on time out, makes IACK useless: that's why "try".

I had another look at the HDL code and apparently my assumption was wrong, and 
STOP just do stop, and IACK is still necessary.

So, yes, without try is better because we save an extra, useless, IRQ call
