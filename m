From: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] DT: i2c: Add binding document for IMG I2C SCB
Date: Wed, 29 Oct 2014 23:55:15 +0000
Message-ID: <20141029235515.GB12801@jhogan-linux.le.imgtec.org>
References: <1414612641-4259-1-git-send-email-ezequiel.garcia@imgtec.com>
 <1414612641-4259-3-git-send-email-ezequiel.garcia@imgtec.com>
 <CAL1qeaEzg5Qh9B62zFkbnhRgC9Ewxs7xkvwNdOO5t6bZd-HV-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL1qeaEzg5Qh9B62zFkbnhRgC9Ewxs7xkvwNdOO5t6bZd-HV-A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, James Hartley <james.hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On Wed, Oct 29, 2014 at 04:32:59PM -0700, Andrew Bresticker wrote:
> > diff --git a/Documentation/devicetree/bindings/i2c/i2c-img-scb.txt b/Documentation/devicetree/bindings/i2c/i2c-img-scb.txt
> 
> > @@ -0,0 +1,14 @@
> > +IMG Serial Control Bus (SCB) I2C Controller
> > +
> > +Required Properties:
> > +- compatible: "img,scb-i2c"
> 
> Is there no difference between the controller present on TZ1090 and Pistachio?

It has a revision register which can be used to determine which revision
of the IP block is being driven. For example the fence quirk is only
enabled for the revision of the IP in TZ1090.

> > +- reg: Physical base address and length of controller registers
> > +- interrupts: Interrupt number used by the controller
> > +- clocks : Clock specifier to the SCB clock node
> 
> On Pistachio there are two clocks per controller, the I2C operating
> clock and I2C "system" clock (which I assume is the system interface
> gate clock).

TZ1090 also had a system clock like this, so I agree it makes sense to
add this, even if the driver does nothing with it yet.

Cheers
James
