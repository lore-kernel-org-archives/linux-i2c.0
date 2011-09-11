From: "Michal Zatloukal" <myxal.mxl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Can't read DIMM SPD info (DDR2)
Date: Sun, 11 Sep 2011 14:11:14 +0200
Message-ID: <op.v1m740q616tawo@esprimo>
References: <op.v1lxasq616tawo@esprimo>
 <20110911100945.73fffa6a@endymion.delvare> <op.v1m1lvea16tawo@esprimo>
 <20110911130823.2dff3fab@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110911130823.2dff3fab-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, 11 Sep 2011 13:08:23 +0200, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
wrote:


<snip>
> No SMBus I801 adapter. Is the i2c-i801 driver loaded? Do you see any
> complaints in the kernel log (e.g. ACPI resource conflict) when reloading
> the i2c-i801 driver?

D'oh, that's the whole problem! After loading the i2c-i801 driver, it
works perfectly. Laptop and server. :)
There's no problem loading the driver that I can see, it's simply not
loaded by default.

Sep 11 13:12:55 johny kernel: [391626.148255] i801_smbus 0000:00:1f.3: PCI
INT B -> GSI 19 (level, low) -> IRQ 19

Sep 11 13:10:23 esprimo kernel: [ 6993.108993] i801_smbus 0000:00:1f.3:
PCI INT C -> GSI 19 (level, low) -> IRQ 19

There are some complaints from drm from when I probed the other buses:
Sep 11 13:10:59 esprimo kernel: [ 7029.730036] [drm] GMBUS timed out,
falling back to bit banging on pin 0 [i915 gmbus disabled]
Sep 11 13:11:01 esprimo kernel: [ 7031.120065] [drm] GMBUS timed out,
falling back to bit banging on pin 6 [i915 gmbus reserved]


$ decode-dimms
# decode-dimms version 5733 (2009-06-09 13:13:41 +0200)

Memory Serial Presence Detect Decoder
By Philip Edelbrock, Christian Zuckschwerdt, Burkart Lingner,
Jean Delvare, Trent Piepho and others

Decoding EEPROM: /sys/bus/i2c/drivers/eeprom/15-0050
Guessing DIMM is in                             bank 1

<snip>
Number of SDRAM DIMMs detected and decoded: 2

Thanks for the help.


-- 
Using Opera's revolutionary email client: http://www.opera.com/mail/
