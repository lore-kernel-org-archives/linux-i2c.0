From: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH] i2c-qoriq: modified compatibility for correct prescaler
Date: Fri, 26 Dec 2014 20:43:40 -0600
Message-ID: <1419648220.5581.192.camel@freescale.com>
References: <1414537731.23458.120.camel@snotra.buserror.net>
	 <5450AC85.40302@keymile.com> <20141113003418.GE2062@katana>
	 <5465B285.7070005@keymile.com> <20141114082832.GA2180@katana>
	 <1416274083.15957.96.camel@freescale.com> <20141125181347.GC9716@katana>
	 <1416966097.15957.171.camel@freescale.com> <54899FB4.9010207@keymile.com>
	 <54996CB5.8030808@keymile.com> <20141223134940.GA1925@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141223134940.GA1925@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Valentin Longchamp <valentin.longchamp-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>, Linux PowerPC Kernel <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Linux device trees <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Brunck, Holger" <Holger.Brunck-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>, "Boschung, Rainer" <Rainer.Boschung-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>, danielle.costantino-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 2014-12-23 at 14:49 +0100, Wolfram Sang wrote:
> On Tue, Dec 23, 2014 at 02:23:01PM +0100, Valentin Longchamp wrote:
> > Wolfgang, Scott,
> 
> Wolfram, please.
> 
> > > What is then the agreement here ? Add a clock-div to the device trees ? Or do
> > > something similar to  mpc_i2c_get_sec_cfg_8xxx() ?
> > > 
> > > I think the clock-div property is better according to Freescale's AN 2919
> > > section 3.1 Source clock. All the source clocks are fixed (with a clock-div of 2
> > > in case of mpc8536/43/45/47/48/67/68/72, plus p2020) except for the mpc8533/44
> > > where it can be 2 or 3, and that's what mpc_i2c_get_sec_cfg_8xxx() determines.
> > > 
> > > So mpc_i2c_get_sec_cfg_8xxx() should remain the exception and the other
> > > prescaler values should be derived from an additional clock-div that must be
> > > added in the respective device trees (at least for the qoriq devices, because
> > > for instance mpc8543 already has the correct prescaler thanks to
> > > mpc_i2c_data_8543 from i2c-mpc.c).
> > > 
> > 
> > Do you have an opinion on the above ?
> 
> I don't mind. I'll leave it to PowerPC experts to judge if a new binding
> is apropriate or reading SVR is the way to go. If it is going to be a
> new binding, then please look around before if there is already
> something similar around...

I'd rather use SVR so things work with existing device trees.

-Scott
