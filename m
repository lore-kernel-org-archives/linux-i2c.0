From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Moving at24 out of i2c/chips?
Date: Wed, 14 Jan 2009 12:11:20 -0800
Message-ID: <200901141211.20681.david-b@pacbell.net>
References: <20090114193521.GB15315@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090114193521.GB15315-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wednesday 14 January 2009, Wolfram Sang wrote:
> as drivers/i2c/chips/ is going to go away, I wondered if Jean would be
> interested in a patch moving it to drivers/misc/ (best location I could
> come up with)? David, are you okay with that?

That seems a reasonable place for it, if that directory is going
away.  Might even be worth moving the at25 (SPI eeprom) driver
there to keep it company, and adding an EEPROM section to Kconfig
for that directory.  (There's some 93x6 support too.  Those are a
flavor of SPI eeprom, but that driver doesn't use the SPI stack.)

- Dave
