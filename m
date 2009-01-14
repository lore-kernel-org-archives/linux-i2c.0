From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Moving at24 out of i2c/chips?
Date: Wed, 14 Jan 2009 21:40:38 +0100
Message-ID: <20090114214038.3d7fbf57@hyperion.delvare>
References: <20090114193521.GB15315@pengutronix.de>
	<200901141211.20681.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200901141211.20681.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 14 Jan 2009 12:11:20 -0800, David Brownell wrote:
> On Wednesday 14 January 2009, Wolfram Sang wrote:
> > as drivers/i2c/chips/ is going to go away, I wondered if Jean would be
> > interested in a patch moving it to drivers/misc/ (best location I could
> > come up with)? David, are you okay with that?
> 
> That seems a reasonable place for it, if that directory is going
> away.  Might even be worth moving the at25 (SPI eeprom) driver
> there to keep it company, and adding an EEPROM section to Kconfig
> for that directory.  (There's some 93x6 support too.  Those are a
> flavor of SPI eeprom, but that driver doesn't use the SPI stack.)

Yes, makes sense to me. The old eeprom driver could go along as well.
Thanks for taking care of this!

-- 
Jean Delvare
