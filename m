From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Removing duplicate drivers from chips?
Date: Sun, 6 Sep 2009 23:23:51 +0200
Message-ID: <20090906232351.55ff4fce@hyperion.delvare>
References: <20090906205526.GA8434@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090906205526.GA8434-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Sun, 6 Sep 2009 22:55:26 +0200, Wolfram Sang wrote:
> Hi Jean,
> 
> I am thinking about cleaning up the 'chips'-directory further by removing the
> duplicate pca/pcf-drivers. Those are marked as deprecated for more than a year
> now. Remembering the defconfig-discussion when we moved out the eeprom drivers,
> I think it is best to not touch the defconfigs but inform the arch-maintainers
> about the removal of these drivers, so they can handle whatever is necessary.
> Are you okay with this approach or do you think we should keep the drivers a
> little longer?

I am totally fine with removing these drivers from linux-next right
now. Then depending on the feedback, from upstream in either 2.6.32 or
2.6.33.

-- 
Jean Delvare
