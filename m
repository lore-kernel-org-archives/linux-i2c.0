From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: i2c-mxs woes
Date: Fri, 19 Apr 2013 14:05:01 +0200
Message-ID: <517132ED.2010303@free-electrons.com>
References: <51712C8B.7070302@free-electrons.com> <201304191349.05971.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201304191349.05971.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 19/04/2013 13:49, Marek Vasut wrote:
> Looks like there's a fixes 7-second delay. Like a timeout maybe?

Yeah, probably, I'm reading 6 times 3 registers of the ADC

BTW, the code is there:
https://github.com/crystalfontz/cfa_10036_kernel/blob/cfa-3.9-12-10049-i2c-adc/drivers/iio/adc/nau7802.c

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
