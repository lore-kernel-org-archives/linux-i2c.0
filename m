From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [i2c-tools][PATCH] honor CROSS_COMPILE
Date: Mon, 10 Jan 2011 15:44:35 +0100
Message-ID: <20110110154435.640c528b@endymion.delvare>
References: <1294426874-24973-1-git-send-email-nm@ti.com>
	<20110108192345.GB4045@pengutronix.de>
	<4D28C9D5.8050401@ti.com>
	<20110108210130.GC4045@pengutronix.de>
	<20110110152608.536de8e7@endymion.delvare>
	<4D2B1768.5030303@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4D2B1768.5030303-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 10 Jan 2011 08:27:52 -0600, Nishanth Menon wrote:
> Jean Delvare had written, on 01/10/2011 08:26 AM, the following:
> > I don't have a strong opinion on this either. But I don't get the point
> > of setting values for AS, LD, AR etc. when they don't seem to be used
> > anywhere. And STRIP is set too, but "strip" hard-coded in
> > tools/Module.mk, so I fail to see how that would work. What am I
> > missing?
> I think I should have done just CC alone. I missed the strip one. but 
> are we interested in having CROSS_COMPILE? if yes, I can cleanup the 
> patch and resubmit.

Well, you proposed it, so you should know if you are interested ;)

What's certain is that I won't apply the patch as is, so it indeed
needs to be cleaned up and resubmitted if you want me to apply it.

-- 
Jean Delvare
