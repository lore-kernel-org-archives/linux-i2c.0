From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] at24: use timeout also for read
Date: Mon, 16 Nov 2009 19:56:47 +0100
Message-ID: <20091116195647.313a1575@hyperion.delvare>
References: <20091106131524.76ae52b9@hyperion.delvare>
	<1257711297-19927-1-git-send-email-w.sang@pengutronix.de>
	<20091116185030.GB21491@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091116185030.GB21491-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ivanov.aleks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 16 Nov 2009 19:50:30 +0100, Wolfram Sang wrote:
> On Sun, Nov 08, 2009 at 09:14:57PM +0100, Wolfram Sang wrote:
> > Writes may take some time on EEPROMs, so for consecutive writes, we already
> > have a loop waiting for the EEPROM to become ready. Use such a loop for reads,
> > too, in case somebody wants to immediately read after a write. Detailed bug
> > report and test case can be found here:
> > 
> > http://article.gmane.org/gmane.linux.drivers.i2c/4660
> > 
> > Reported-by: Aleksandar Ivanov <ivanov.aleks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> > Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> 
> Jean, you are probably busy, just a short note will do: Is this scheduled for
> 2.6.33?

Yes it is, but I must find some time to review and test your change
first. Busy...

-- 
Jean Delvare
