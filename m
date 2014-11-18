From: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH] i2c-qoriq: modified compatibility for correct prescaler
Date: Mon, 17 Nov 2014 19:28:03 -0600
Message-ID: <1416274083.15957.96.camel@freescale.com>
References: <1413538026-15739-1-git-send-email-valentin.longchamp@keymile.com>
	 <1414537731.23458.120.camel@snotra.buserror.net>
	 <5450AC85.40302@keymile.com> <20141113003418.GE2062@katana>
	 <5465B285.7070005@keymile.com> <20141114082832.GA2180@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141114082832.GA2180@katana>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Valentin Longchamp <valentin.longchamp-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>, Linux PowerPC Kernel <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Linux device trees <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Brunck, Holger" <Holger.Brunck-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>, "Boschung, Rainer" <Rainer.Boschung-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 2014-11-14 at 09:28 +0100, Wolfram Sang wrote:
> > > 
> > > If we're going to change the device tree I'd rather just add a property
> > > to say what the prescaler is.
> > 
> >  We would however, leave the boards' device trees that use things like
> > "fsl,mpc8543-i2c" as is and introduce the prescaler for the others requiring it.
> > 
> > 
> > Now the drawback is that the driver would require a change, to parse this
> > prescaler new prescaler property. Would this be OK from your point of view
> > Wolfram ? If yes, I will send the patches for it.
> 
> I don't think it is OK.

Why?

>  I'd think it can be deduced from the compatible property.

For almost all existing device trees it cannot be.

If you want something that will work without changing device trees,
you'll need to use SVR to identify the SoC.

-Scott


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
