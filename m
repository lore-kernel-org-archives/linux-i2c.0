From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] i2c: Convert to using %pOFn instead of device_node.name
Date: Wed, 29 Aug 2018 13:42:50 -0500
Message-ID: <CAL_JsqJcDdntsi3D=neU=Dhx0Xku_XPFC_OCLRb8V==HTtviBQ@mail.gmail.com>
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-21-robh@kernel.org>
 <3fa33583-f748-1708-2274-0a6f4e81004b@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3fa33583-f748-1708-2274-0a6f4e81004b@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Linux I2C <linux-i2c@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Aug 29, 2018 at 1:03 PM Peter Rosin <peda@axentia.se> wrote:
>
> On 2018-08-28 03:52, Rob Herring wrote:
> > In preparation to remove the node name pointer from struct device_node,
> > convert printf users to use the %pOFn format specifier.
> >
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Peter Rosin <peda@axentia.se>
> > Cc: linux-i2c@vger.kernel.org
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/i2c/busses/i2c-powermac.c | 15 ++++++++-------
> >  drivers/i2c/muxes/i2c-mux-gpmux.c |  4 ++--
> >  2 files changed, 10 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-powermac.c
> > index f2a2067525ef..b706fd136ca5 100644
> > --- a/drivers/i2c/busses/i2c-powermac.c
> > +++ b/drivers/i2c/busses/i2c-powermac.c
> > @@ -390,7 +390,6 @@ static int i2c_powermac_probe(struct platform_device *dev)
> >       struct pmac_i2c_bus *bus = dev_get_platdata(&dev->dev);
> >       struct device_node *parent = NULL;
>
> Lose the initializer...

That's pretty much unrelated though. I'd have to write "Also, remove
the unnecessary parent pointer init" in the commit message and we all
know "Also" is a clue for belongs in a separate patch.

Rob
