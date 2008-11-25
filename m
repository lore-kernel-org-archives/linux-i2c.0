From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 2.6.28-rc5] i2c:  remove i2c_adapter.clist_lock
Date: Tue, 25 Nov 2008 12:01:00 +0100
Message-ID: <20081125120100.6581f394@hyperion.delvare>
References: <200811201438.08788.david-b@pacbell.net>
	<20081125101203.58e3f032@hyperion.delvare>
	<200811250224.01610.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200811250224.01610.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Linux-I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 25 Nov 2008 02:24:01 -0800, David Brownell wrote:
> On Tuesday 25 November 2008, Jean Delvare wrote:
> > I'm not sure I want to take this change at this point. Call me chicken,
> > but I seem to recall problems with legacy i2c clients last time we
> > tried to clean up this area.
> 
> I did test this with the legacy "eeprom" and "i2c-stub" as you had
> suggested.  Worked fine ... this is different from previous passes,
> as it removes the lock instead of the list, and doesn't attempt to
> change how the list is (mis/ab)used.

Which kernel version? Since 2.6.27, the eeprom driver is no longer a
legacy driver. Instead it's a new-style driver with the
optional .detect() callback.

This is why I am reluctant to change this now: there aren't too many
legacy drivers left, so testing their code paths isn't easy, and if
anything isn't correct we might not notice it until it hits the users.

> But if you prefer to wait until the list can go too, OK.

Yes, please.

-- 
Jean Delvare
