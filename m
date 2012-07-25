From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c-mux-gpio platform device ID issue
Date: Wed, 25 Jul 2012 23:37:27 +0200
Message-ID: <20120725233727.55693faf@endymion.delvare>
References: <20120725144409.1e47bd95@endymion.delvare>
	<20120725163913.60fffd1a@endymion.delvare>
	<20120725193243.GA9792@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120725193243.GA9792-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Mark,

On Wed, 25 Jul 2012 20:32:43 +0100, Mark Brown wrote:
> On Wed, Jul 25, 2012 at 04:39:13PM +0200, Jean Delvare wrote:
> 
> > I am using magic ID value -4 for this (I left -2 and -3 free in case
> > we ever need a couple of other magic values.) The automatically
> 
> We could always add the new magic values starting at -3 instead...

No, because my approach consumes _all_ negative values below the magic
value. First mux will get -4, second will get -5 etc.

-- 
Jean Delvare
