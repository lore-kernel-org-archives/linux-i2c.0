From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] eeprom: add non-cached sysfs read access to EEPROM data
Date: Tue, 1 Sep 2009 16:39:49 -0700
Message-ID: <20090901233948.GA3828@kroah.com>
References: <20090901231500.AA737254211@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090901231500.AA737254211@localhost>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Petri Gynther <pgynther-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Sep 01, 2009 at 04:15:00PM -0700, Petri Gynther wrote:
> Add "eeprom-nc" sysfs attribute to provide non-cached read access
> to EEPROM data. This is needed because some EEPROM-like devices
> contain constantly changing real-time diagnostic data that cannot
> be cached in kernel memory.

How are we going to know which attribute to use?

For all new sysfs attributes, you have to add a Documentation/ABI/ file
as well, care to do that here?

thanks,

greg k-h
