From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH]i2c-dev: add ioctls PROBE and REMOVE
Date: Thu, 02 Apr 2009 14:36:27 +0200
Message-ID: <49D4B14B.50405@gmx.de>
References: <49CB43E0.2050503@gmx.de>	<49CCA82F.90106@gmx.de>	<20090327134034.754908b5@hyperion.delvare>	<49CCD0FC.9030500@gmx.de>	<20090327145726.13c99aed@hyperion.delvare> <20090327150716.094666d1@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090327150716.094666d1-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Jean Delvare said the following:
> BTW, if you don't want your problem to be overlooked, I strongly
> suggest that you create yourself a wiki account on
> http://i2c.wiki.kernel.org/, create a page describing the problem and
> its proposed solution, and link to it from the "Work in progress"
> section.
> 
Ok, done.
<http://i2c.wiki.kernel.org/index.php?title=SysFs_entries_add_device/delete_device>

I made a patch, that uses i2c_new_device. But this won't use the detect
method of the client, so its possible to instantiate almost any code on
the given address :-(
Shouldn't we use i2c_detect_address() or something similar?

-- 
Kind regards,
Michael
