From: Joakim Tjernlund <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Subject: Re: [PATCH] i2c-mpc: Wait for STOP to hit the bus
Date: Tue, 11 Sep 2012 12:13:22 +0200
Message-ID: <OFA8525D38.481DAB6F-ONC1257A76.003806D7-C1257A76.00382807@transmode.se>
References: <1346323204-19210-1-git-send-email-Joakim.Tjernlund@transmode.se> <6AE080B68D46FC4BA2D2769E68D765B708019E97@039-SN2MPN1-022.039d.mgd.msft.net> <OF0ACFB3FB.F2667AE9-ONC1257A6D.004E0ADE-C1257A6D.004EEB75@LocalDomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <OF0ACFB3FB.F2667AE9-ONC1257A6D.004E0ADE-C1257A6D.004EEB75@LocalDomain>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tabi Timur-B04825 <B04825-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Joakim Tjernlund/Transmode wrote on 2012/09/02 16:22:00:
>
> Tabi Timur-B04825 <B04825-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote on 2012/09/02 04:48:01:
> > On Thu, Aug 30, 2012 at 5:40 AM, Joakim Tjernlund
> > <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org> wrote:
> >
> > > -       mpc_i2c_stop(i2c);
> > > +       mpc_i2c_stop(i2c); /* Initiate STOP */
> > > +       orig_jiffies = jiffies;
> > > +       /* Wait until STOP is seen, allow up to 1 s */
> > > +       while (readb(i2c->base + MPC_I2C_SR) & CSR_MBB) {
> > > +               if (time_after(jiffies, orig_jiffies + HZ)) {
> > > +                       u8 status = readb(i2c->base + MPC_I2C_SR);
> > > +
> > > +                       dev_dbg(i2c->dev, "timeout\n");
> > > +                       if ((status & (CSR_MCF | CSR_MBB | CSR_RXAK)) != 0) {
> > > +                               writeb(status & ~CSR_MAL,
> > > +                                      i2c->base + MPC_I2C_SR);
> > > +                               mpc_i2c_fixup(i2c);
> > > +                       }
> > > +                       return -EIO;
> > > +               }
> > > +               cond_resched();
> > > +       }
> >
> > Shouldn't the while-loop be inside mpc_i2c_stop() itself?
>
> Possibly but I choosed to do it this way as there is a similar loop in the beginning of mpc_xfer().
> I figured it has better visibility if it is in the same function.
>
>  Jocke

Ping? Anything holding this patch back?

 Jocke
