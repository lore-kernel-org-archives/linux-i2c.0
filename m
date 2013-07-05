From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: fix broken timing calculation
Date: Fri, 5 Jul 2013 18:53:45 +0200
Message-ID: <201307051853.45786.marex@denx.de>
References: <1373041680-26939-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1373041680-26939-1-git-send-email-LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lothar =?iso-8859-1?q?Wa=DFmann?= <LW-AvR2QvxeiV7DiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Lothar,

> The timing calculation is rather bogus and gives extremely wrong
> results for higher frequencies (on an i.MX28). E.g. instead of 400 kHz
> I measured 770 kHz.
> 
> Implement a calculation that adheres to the I2C spec and gives exact
> results for I2C frequencies from 12.56 kHz to 960 kHz.
> 
> Also the bus_free and leadin parameters are programmed according to
> the I2C spec for standard and fast mode.

I suspect the resulting speed is heavily dependent on hardware properties of the 
bus. Did you have a chance to check it with a scope? I will try to recheck on 
other boards next week.

Best regards,
Marek Vasut
