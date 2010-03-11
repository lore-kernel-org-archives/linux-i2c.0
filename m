From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] misc/eeprom/at24: init dynamic bin_attribute structures
Date: Thu, 11 Mar 2010 15:57:53 +0100
Message-ID: <20100311155753.25fc9a5c@hyperion.delvare>
References: <1268268932-23447-1-git-send-email-w.sang@pengutronix.de>
	<20100311085835.34c6cd51@hyperion.delvare>
	<20100311080347.GB16219@pengutronix.de>
	<20100311115426.6440837c@hyperion.delvare>
	<20100311112321.GA28805@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100311112321.GA28805-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Albrecht =?UTF-8?B?RHJlw58=?= <albrecht.dress-KvP5wT2u2U0@public.gmane.org>, "Eric W. Biederman" <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 11 Mar 2010 12:23:21 +0100, Wolfram Sang wrote:
> 
> > > > I presume the at25 driver needs the same fix?
> > > 
> > > Yes, sent it to the SPI-list sperately. I wasn't sure if a patch series would
> > > ease or complicate things.
> > 
> > Fine with me, as long as it get fixed.
> 
> I am currently using my newly acquired coccinelle-fu to find further drivers in
> need of such a fix :)

A quick grep suggests that only 3 drivers need care:
arch/mips/txx9/generic/setup.c
drivers/misc/eeprom/at24.c
drivers/misc/eeprom/at25.c

I'm curious if coccinelle will find more...

-- 
Jean Delvare
