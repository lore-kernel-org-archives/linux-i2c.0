From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Can't read DIMM SPD info (DDR2)
Date: Sun, 11 Sep 2011 14:40:15 +0200
Message-ID: <20110911144015.7379de9b@endymion.delvare>
References: <op.v1lxasq616tawo@esprimo>
	<20110911100945.73fffa6a@endymion.delvare>
	<op.v1m1lvea16tawo@esprimo>
	<20110911130823.2dff3fab@endymion.delvare>
	<op.v1m740q616tawo@esprimo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <op.v1m740q616tawo@esprimo>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Zatloukal <myxal.mxl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 11 Sep 2011 14:11:14 +0200, Michal Zatloukal wrote:
> On Sun, 11 Sep 2011 13:08:23 +0200, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> wrote:
> 
> 
> <snip>
> > No SMBus I801 adapter. Is the i2c-i801 driver loaded? Do you see any
> > complaints in the kernel log (e.g. ACPI resource conflict) when reloading
> > the i2c-i801 driver?
> 
> D'oh, that's the whole problem! After loading the i2c-i801 driver, it
> works perfectly. Laptop and server. :)
> There's no problem loading the driver that I can see, it's simply not
> loaded by default.

Ah! Now I remember. Ubuntu? I think they _blacklist_ i2c-i801 for every
machine in the world because it caused problems on one single machine
years ago. Try:
$ /sbin/modprobe -c | grep i801
and I'm sure you'll find a blacklist statement.

So, either delete the blacklist statement in /etc/modprobe.d/* (but it
may come back on system update) or manually load the driver at boot
time (no idea how this is done on Ubuntu, sorry).

And (if I am right) please report this as a BUG to Ubuntu maintainers.
Blacklisting a perfectly working driver needed by millions of users
simply makes no sense. Whatever the problem was, I bet it is solved by
now anyway.

> $ decode-dimms
> # decode-dimms version 5733 (2009-06-09 13:13:41 +0200)
> 
> Memory Serial Presence Detect Decoder
> By Philip Edelbrock, Christian Zuckschwerdt, Burkart Lingner,
> Jean Delvare, Trent Piepho and others
> 
> Decoding EEPROM: /sys/bus/i2c/drivers/eeprom/15-0050
> Guessing DIMM is in                             bank 1
> 
> <snip>
> Number of SDRAM DIMMs detected and decoded: 2

Great! Glad I could help :)

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html
