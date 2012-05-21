From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: identify i2c
Date: Mon, 21 May 2012 07:57:19 +0200
Message-ID: <20120521075719.321fa1b3@endymion.delvare>
References: <4FB952EB.1050505@lockie.ca>
	<20120520230047.45aaa1c0@endymion.delvare>
	<4FB95F5A.30003@lockie.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FB95F5A.30003-ozXLQgHQwDP3fQ9qLvQP4Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: James <bjlockie-ozXLQgHQwDP3fQ9qLvQP4Q@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 20 May 2012 17:17:14 -0400, James wrote:
> On 05/20/12 17:00, Jean Delvare wrote:
> > On Sun, 20 May 2012 16:24:11 -0400, James wrote:
> >>> # decode-dimms
> >>> # decode-dimms version 5929 (2011-02-16 14:58:38 +0100)
> >>>
> >>> Memory Serial Presence Detect Decoder
> >>> By Philip Edelbrock, Christian Zuckschwerdt, Burkart Lingner,
> >>> Jean Delvare, Trent Piepho and others
> >>> No EEPROM found, are you sure the eeprom module is loaded?
> >>
> >> How do I find out what to configure in a 3.4 kernel?
> > 
> > CONFIG_I2C=y
> > CONFIG_EEPROM_LEGACY=m
> > 
> > Plus CONFIG_I2C_<your I2C bus driver>=m. "lspci | grep SMBus" etc. might
> > tell you which it is.
> > 
> 
> How do I find CONFIG_EEPROM_LEGACY in menuconfig?

You run "make menuconfig" then type /EEPROM_LEGACY<Enter>, it will tell
you where it is.

> I manually changed it in .config :-)

-- 
Jean Delvare
