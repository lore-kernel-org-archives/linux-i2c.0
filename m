From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.28-rc5] i2c:  remove i2c_adapter.clist_lock
Date: Tue, 25 Nov 2008 02:24:01 -0800
Message-ID: <200811250224.01610.david-b@pacbell.net>
References: <200811201438.08788.david-b@pacbell.net> <20081125101203.58e3f032@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20081125101203.58e3f032-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux-I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tuesday 25 November 2008, Jean Delvare wrote:
> I'm not sure I want to take this change at this point. Call me chicken,
> but I seem to recall problems with legacy i2c clients last time we
> tried to clean up this area.

I did test this with the legacy "eeprom" and "i2c-stub" as you had
suggested.  Worked fine ... this is different from previous passes,
as it removes the lock instead of the list, and doesn't attempt to
change how the list is (mis/ab)used.

But if you prefer to wait until the list can go too, OK.

- Dave
