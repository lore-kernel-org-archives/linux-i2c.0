From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH V2 2/3] i2c: mxs: Rework the PIO mode operation
Date: Wed, 7 Aug 2013 00:18:12 +0200
Message-ID: <201308070018.12773.marex@denx.de>
References: <1375219237-9594-1-git-send-email-marex@denx.de> <201308061535.50470.marex@denx.de> <20130806211348.GA3429@katana>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130806211348.GA3429@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Christoph Baumann <cb-/RsSufbtIHM@public.gmane.org>, Fabio Estevam <r49496-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Torsten Fleischer <to-fleischer-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Wolfram Sang,

> > I agree, but I still don't like squashing the two patches together. I
> > forgot to mention it last time, but please, look at the patches one more
> > time. Jurgens' does the DT change and mine fixes the PIO on MX23, I'd
> > like to keep these changes separate.
> 
> Ok, as said, I am not pushing hard on this.

Thanks!

> > > Then, add the comment to the check so ppl will notice there?
> > 
> > If I could add a big red flashing sign into the code stating "If you go
> > over 4 bytes here, a kitten will die", then by all means, I would add
> > it. Unfortunatelly, there is no such thing possible.
> 
> I'd say if somebody changes the code with that comment on top of it, it
> is really deserved...

You mean the kitten ... ? ;-)

> > Maybe WARN_ONCE and return with error might just work?
> 
> ... but if you insist, I can accept this.

Thinking about it harder, WARN might be more appropriate. Maybe I'll just remove 
it altogether, I'll think about it some more.

Best regards,
Marek Vasut
