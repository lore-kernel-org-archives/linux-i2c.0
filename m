From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH 1/4 v2] i2c/gpio: add DT support
Date: Mon, 20 Feb 2012 10:08:43 +0000
Message-ID: <20120220100843.GE22562@n2100.arm.linux.org.uk>
References: <1328754308-7365-1-git-send-email-plagnioj@jcrosoft.com> <4F3945B1.9070900@samsung.com> <20120220095813.GB11307@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120220095813.GB11307-RQcB7r2h9QmfDR2tN2SG5Ni2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Cc: Karol Lewandowski <k.lewandowsk-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Feb 20, 2012 at 10:58:13AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 18:17 Mon 13 Feb     , Karol Lewandowski wrote:
> > > +	- udelay: delay between GPIO operations (may depend on each platform)
> > > +	- timeout: timeout to get data (ms)
> > 
> > 
> > If these are really needed then I would prefer to have these fully
> > qualified (with unit type "-ms/-millisecs" appended).
> > 
> > Regulator framework, with its "-microvolt/-microamp", serve here as
> > prime example of being quite descriptive (one doesn't neet to look up
> > the docs). Please see:
> > 
> >   http://permalink.gmane.org/gmane.linux.ports.arm.omap/67637
> timeout are usualy in ms I don't really see the need of -ms or so

Which is obviously total crap for udelay, which would be in _micro_seconds.
