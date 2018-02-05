From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH] drm: don't link DP aux i2c adapter to the hardware
 device node
Date: Mon, 05 Feb 2018 17:29:09 +0100
Message-ID: <1517848149.3175.15.camel@pengutronix.de>
References: <20170113173630.22138-1-l.stach@pengutronix.de>
         <20170123163347.GC2043@ulmo.ba.sec>
         <CAL_JsqKKywq3NdJO60SPWoE7+mR6CPwN3Dx62z6pyQYuEv4kSA@mail.gmail.com>
         <1491382352.2904.9.camel@pengutronix.de>
         <20170405120431.GA9162@ulmo.ba.sec> <20180205161130.GA3493@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56395 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753072AbeBEQ3Q (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 5 Feb 2018 11:29:16 -0500
In-Reply-To: <20180205161130.GA3493@ulmo>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Wolfram Sang <wsa@the-dreams.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, dri-devel <dri-devel@lists.freedesktop.org>, linux-i2c@vger.kernel.org, patchwork-lst@pengutronix.de

Am Montag, den 05.02.2018, 17:11 +0100 schrieb Thierry Reding:
> On Wed, Apr 05, 2017 at 02:04:31PM +0200, Thierry Reding wrote:
> > On Wed, Apr 05, 2017 at 10:52:32AM +0200, Lucas Stach wrote:
> > > Hi Rob,
> > > 
> > > Am Mittwoch, den 29.03.2017, 08:56 -0500 schrieb Rob Herring:
> > > > On Mon, Jan 23, 2017 at 10:33 AM, Thierry Reding
> > > > > > > > <thierry.reding@gmail.com> wrote:
> > > > > On Fri, Jan 13, 2017 at 06:36:30PM +0100, Lucas Stach wrote:
> > > > > > The i2c adapter on DP AUX is purely a software construct. Linking
> > > > > > it to the device node of the parent device is wrong, as it leads to
> > > > > > 2 devices sharing the same device node, which is bad practice, as
> > > > > 
> > > > > Who says that two devices can't share the same device node? It's done
> > > > > all the time.
> > > > 
> > > > It's done *some of the time* and I would not consider it best practice.
> > > > 
> > > > > > well as the i2c trying to populate children of the i2c adapter by
> > > > > > looking at the child device nodes of the parent device.
> > > > > 
> > > > > A set of patches landed in v4.9 to work around this issue in a better
> > > > > way. See:
> > > > > 
> > > > >         98b00488459e dt-bindings: i2c: Add support for 'i2c-bus' subnode
> > > > >         7e4c224abfe8 i2c: core: Add support for 'i2c-bus' subnode
> > > > 
> > > > What does this buy us? I don't see why this needs to be in DT either.
> > > > Contrary to popular belief, DT is not the only way to instantiate
> > > > devices, C code can still do it.
> > > > 
> > > > Also, if this one line removal has no side effects, then how was it
> > > > even needed? We can always add it back if there's some argument for
> > > > why it is needed.
> > > 
> > > Okay, so I take this as you mostly agreeing with the rationale of this
> > > patch.
> > 
> > For some general background on this: I was originally using this for DP
> > support on Tegra (though that ended up never getting merged because of a
> > particularily frustrating episode of trying to get better link training
> > support into the core helpers) and use it as a means to obtain the I2C
> > controller used for DDC. On Tegra, and I suspect other devices as well,
> > the DP AUX controller is separate from the encoder, so the idea was to
> > link them together using a standard ddc-i2c-bus phandle.
> > 
> > I ended up not needing that because the encoder and DP AUX controller
> > are so tightly linked on Tegra that I need direct access to the DP AUX
> > anyway and can therefore directly get the I2C controller from that.
> > 
> > If there aren't any other users of this, I suppose we could simply
> > remove the line. Should someone turn up in the future and require the
> > I2C controller to be looked up from a phandle we could add it again,
> > at which point we'd have to investigate again how to get rid of the
> > errors.
> > 
> > Acked-by: Thierry Reding <treding@nvidia.com>
> 
> I'm going to have to retract that: I just noticed that this patch breaks
> eDP for Venice2 (and presumably all Tegra124 Nyan boards as well, though
> I don't have those to test with).
> 
> My description above isn't quite correct. For eDP device we do use the
> ddc-i2c-bus property in DT to denote which I2C bus to use for probing
> the EDID. So the reason why eDP now breaks is because the simple-panel
> driver will look for the I2C adapter, not find a matching one and defer
> probe (indefinitely).
> 
> A, perhaps nicer, alternative I found to make it work is the below
> patch. Would that be more reasonable? Looping in Wolfram.

Taking a step back from the immediate breakage: why do you need the
ddc-i2c-bus phandle on the eDP panel at all? I would consider this DT
buggy, as it tries to point to something which is purely a software
construct. It's not like you are likely to use any other i2c adapter to
get the eDP panel EDID than the eDP AUX adapter.

I know this is trading different levels of breakage, but without this
patch I'm forced to describe a (not actually existent) i2c-bus in DT on
eDP bridges, to shut down the warnings from the i2c core when it tries
to populate child devices of the bridge that aren't i2c devices.

Regards,
Lucas
