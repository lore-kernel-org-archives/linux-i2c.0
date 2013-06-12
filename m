From: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] i2c: core: make it possible to match a pure device tree driver
Date: Wed, 12 Jun 2013 14:20:22 +0100
Message-ID: <20130612132022.39F0C3E0A56@localhost>
References: <1368476301-10495-1-git-send-email-linus.walleij@linaro.org> <20130607213241.GB3047@katana>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130607213241.GB3047@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 7 Jun 2013 23:32:42 +0200, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> ...
> > I2C devices probed from device tree should subsequently be
> > fixed to handle the case where of_match_table() is
> > used (I think none of them do that today), and platforms should
> > fix their device trees to use compatible strings for I2C devices
> > instead of setting the name to Linux device driver names as is
> > done in multiple cases today.
> 
> I guess your solution is the least intrusive one. Still, it could happen
> that of_match_table is scanned three times (by driver core, i2c layer,
> and i2c driver) which is IMO an indication to look for a more elegant
> solution tp find out what really matched?

It's what we do on platform_devices. It really isn't an expensive
operation so I haven't pushed anyone to go optimize it.

g.
