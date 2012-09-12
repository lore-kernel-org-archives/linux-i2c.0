From: "Voss, Nikolaus" <N.Voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>
Subject: RE: [PATCH v3 0/8] i2c: at91: cleanup and dt support
Date: Wed, 12 Sep 2012 12:39:10 +0200
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D090ED36C51@wm021.weinmann.com>
References: <1347432137-25058-1-git-send-email-ludovic.desroches@atmel.com>
 <505041EF.5060204@atmel.com> <20120912101607.GA2624@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120912101607.GA2624-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: de-DE
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, 'Nicolas Ferre' <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: "'linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "'ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org'" <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, "'linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org'" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "'devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org'" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "'plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org'" <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

 Wolfram Sang wrote on Wednesday, September 12, 2012 12:16 PM:
> One thing I'd like to make, though. I'd like to squash the following
> patches into one:
> 
> 	drivers/i2c/busses/i2c-at91.c: add new driver
> 	i2c: at91: use managed resources
> 	i2c: at91: add warning about transmission issues for some devices
> 	i2c: at91: use an id table for SoC dependent parameters
> 
> It is especially the last patch I am mostly interested in. The id_table
> approach is what I like, while the original id_entry mechanism looks
> fishy. I'd was good for reviewing to have the patches split like this;
> yet for hitting mainline, I'd prefer to have the driver proper on first
> occasion. I already did the squashing in a test-branch and the result
> looks good to me.
> 
> Nikolaus, Ludovic: Are you fine with this?

Absolutely.

Niko
