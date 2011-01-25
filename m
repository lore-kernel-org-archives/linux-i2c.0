From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2ctools: Need capability to write SMBus block command
Date: Tue, 25 Jan 2011 17:49:22 +0100
Message-ID: <20110125174922.4c802f49@endymion.delvare>
References: <20110125162106.GA8024@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110125162106.GA8024-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Guenter,

On Tue, 25 Jan 2011 08:21:06 -0800, Guenter Roeck wrote:
> I need the capability to write a SMBus block command with i2ctools.
> 
> Not an issue writing it myself. Question is if to expand i2cset to include
> that capability, or to write a new command (i2csetblock ?) to do it.
> 
> Thoughts ?

This would probably be best discussed on the linux-i2c list than
lm-sensors. Redirecting there...

I would add it to i2cset. The only problem is that the command line
convention of i2cset is a little tricky and thus hard to extend. But I
see no reason why allowing multiple VALUEs followed by MODE s (for
SMBus block) or i (for I2C block) wouldn't work. I suggest i and s
because this is what i2cdump is using.

-- 
Jean Delvare
