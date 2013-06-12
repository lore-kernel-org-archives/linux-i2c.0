From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v2] i2c: core: make it possible to match a pure device tree driver
Date: Wed, 12 Jun 2013 14:22:02 +0100
Message-ID: <20130612132202.7E6AB3E0A56@localhost>
References: <1368476301-10495-1-git-send-email-linus.walleij@linaro.org> <20130607213241.GB3047@katana> <CACRpkdbBsXB+9wN0oshfZB8Xady9G_wu9d8UkgA-bYqQe=8Mpw@mail.gmail.com> <20130610134013.GA2987@katana>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130610134013.GA2987@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 10 Jun 2013 15:40:14 +0200, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> On Mon, Jun 10, 2013 at 02:18:17PM +0200, Linus Walleij wrote:
> > On Fri, Jun 7, 2013 at 11:32 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> > > ...
> > >> I2C devices probed from device tree should subsequently be
> > >> fixed to handle the case where of_match_table() is
> > >> used (I think none of them do that today), and platforms should
> > >> fix their device trees to use compatible strings for I2C devices
> > >> instead of setting the name to Linux device driver names as is
> > >> done in multiple cases today.
> > >
> > > I guess your solution is the least intrusive one. Still, it could happen
> > > that of_match_table is scanned three times (by driver core, i2c layer,
> > > and i2c driver) which is IMO an indication to look for a more elegant
> > > solution tp find out what really matched?
> > 
> > I think that is a generic problem with the device tree
> > being completely stateless, and rather a comment on the
> > of_match_device() intrinsics being inelegant than on this
> > patch?
> 
> Yes.
> 
> > Do you see it as a blocker for the patch?
> 
> No blocker. Yet, I was hoping for somebody perhaps having a good idea.
> Platform devices have 'id_entry', for example. Sadly, I don't have the
> resources to pick up a similar idea.
> 

I did at one time have a patch that kept the pointer around in the
struct device if an of_match_table succeeded, but it caused subtle race
conditions that weren't easy to solve. I reverted back to just calling
of_match_table() several times because it was easy.

g.
