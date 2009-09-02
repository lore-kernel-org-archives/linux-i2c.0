From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] eeprom: add non-cached sysfs read access to EEPROM data
Date: Wed, 2 Sep 2009 10:30:34 +0200
Message-ID: <20090902103034.15f13e4d@hyperion.delvare>
References: <20090901231500.AA737254211@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090901231500.AA737254211@localhost>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Petri Gynther <pgynther-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Greg Kroah-Hartman <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Petri,

On Tue,  1 Sep 2009 16:15:00 -0700 (PDT), Petri Gynther wrote:
> Add "eeprom-nc" sysfs attribute to provide non-cached read access
> to EEPROM data. This is needed because some EEPROM-like devices
> contain constantly changing real-time diagnostic data that cannot
> be cached in kernel memory.
> 
> Signed-off-by: Petri Gynther <pgynther-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/misc/eeprom/eeprom.c |   30 +++++++++++++++++++++++++++---
>  1 files changed, 27 insertions(+), 3 deletions(-)

You are using the wrong driver for the task. The "eeprom" driver is a
legacy driver solely meant for SPD and EDID EEPROMs, and these do never
change, thus the caching mechanism. Please look at the new "at24"
driver for accessing any other EEPROM type.

-- 
Jean Delvare
