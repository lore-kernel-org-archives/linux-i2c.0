From: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PULL REQUEST] i2c-embedded for 3.5
Date: Sat, 26 May 2012 17:23:16 +0200
Message-ID: <4FC0F564.6040609@antcom.de>
References: <20120526140650.GA7133@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120526140650.GA7133-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

On 26/05/12 16:06, Wolfram Sang wrote:
> Note that you will get a trivial merge-conflict because some
> lpc32xx-patches have already come in via arm-soc to reduce dependencies.
> I read that you want to see such conflicts so I didn't take any actions.
> I'll add Arnd and Roland to CC, because they know best about LPC32xx
> changes.

There are already some i2c commits in master that came via arm-soc.
Expect conflicts with some LPC32xx related commits from i2c-embedded.
They are basically the same patches, applied as different commits
though, sorry. But should be easy to resolve.

Roland
