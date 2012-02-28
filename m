From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 1/3] mfd: Add basic support for the Congatec CGEB BIOS
 interface
Date: Tue, 28 Feb 2012 14:32:17 +0000
Message-ID: <20120228143217.GB25472@sirena.org.uk>
References: <1328102793-4313-1-git-send-email-s.hauer@pengutronix.de>
 <1328102793-4313-2-git-send-email-s.hauer@pengutronix.de>
 <20120220163927.GY5387@sortiz-mobl>
 <20120220180752.GV3852@pengutronix.de>
 <20120227135827.GM27687@sortiz-mobl>
 <20120227172443.GD3852@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120227172443.GD3852-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Feb 27, 2012 at 06:24:43PM +0100, Sascha Hauer wrote:
> On Mon, Feb 27, 2012 at 02:58:27PM +0100, Samuel Ortiz wrote:

> > Yes, this seems to be the trend apparently. Could you try pushing that into
> > the x86/platform, please ? If they put you under fire, I guess I could take
> > this patchset. But they have several "BIOS interfaces" there already...

> Ok, I'll put on my asbestos suit and give it a try.

You might want to jump into the thread Linus Walleij started about
system controllers today.
