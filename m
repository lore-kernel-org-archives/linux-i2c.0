From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Can't read DIMM SPD info (DDR2)
Date: Sun, 11 Sep 2011 13:08:23 +0200
Message-ID: <20110911130823.2dff3fab@endymion.delvare>
References: <op.v1lxasq616tawo@esprimo>
	<20110911100945.73fffa6a@endymion.delvare>
	<op.v1m1lvea16tawo@esprimo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <op.v1m1lvea16tawo@esprimo>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Zatloukal <myxal.mxl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 11 Sep 2011 11:50:09 +0200, Michal Zatloukal wrote:
> On Sun, 11 Sep 2011 10:09:45 +0200, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> wrote:
> 
> > Hi Michal,
> > ...
> > Second preliminary note: as far as I know, memtest86 reads SPD
> > information using a BIOS call, while decode-dimms gets the information
> > over the SMBus, assuming that SPD EEPROMs are connected to the SMBus
> > and reachable at run time. This difference in access methods can
> > explain why memtest86 can see information and decode-dimms not on the
> > same system.
> 
> Is there a way to do the BIOS call method in Linux? If it's a sort-of
> standard way to access SPD info, would it be the one used by CPU-Z to read
> the SPD info on Windows? (which does work on this HW)

I am not so familiar with this. I seem to recall that BIOS calls are
not easy/safe to use in protected mode on x86, so it might be difficult
or even impossible to do that from user-space. From kernel space,
maybe, I don't know.

It is very possible that it's what CPU-Z is doing. However I don't know
if the author is willing to share his method. A quick web search did
not return anything, but I admit I did not spend too much time on it,
and I am also not so sure what I am looking for.

If anyone ever writes a kernel driver exposing SPD data to user-space,
I will be very happy to update decode-dimms to take benefit of that.

> > First thing to check is if the SMBus on your system is properly found
> > and supported:
> >
> > # modprobe i2c-dev
> > # i2cdetect -l
> >
> > On an Intel system you should see an entry like:
> >
> > i2c-8	smbus     	SMBus I801 adapter at 0400      	SMBus adapter
> 
> Nope. On 'buntu 10.10, I only got 5 entries (didn't write them down), none
> of which said smbus. On 11.10, I get:
> 
> # i2cdetect -l
> i2c-0   i2c             i915 gmbus disabled                     I2C adapter
> i2c-1   i2c             i915 gmbus ssc                          I2C adapter
> i2c-2   i2c             i915 GPIOB                              I2C adapter
> i2c-3   i2c             i915 gmbus vga                          I2C adapter
> i2c-4   i2c             i915 GPIOA                              I2C adapter
> i2c-5   i2c             i915 gmbus panel                        I2C adapter
> i2c-6   i2c             i915 GPIOC                              I2C adapter
> i2c-7   i2c             i915 gmbus dpc                          I2C adapter
> i2c-8   i2c             i915 GPIOD                              I2C adapter
> i2c-9   i2c             i915 gmbus dpb                          I2C adapter
> i2c-10  i2c             i915 GPIOE                              I2C adapter
> i2c-11  i2c             i915 gmbus reserved                     I2C adapter
> i2c-12  i2c             i915 gmbus dpd                          I2C adapter
> i2c-13  i2c             i915 GPIOF                              I2C adapter
> i2c-14  i2c             SDVO DDC proxy                          I2C adapter
> 
> And BTW, this is the same list I get on my "server/router/AP" (Intel
> D945GSEJT nettop board running 'buntu 11.04) which is also in the same
> situation (can't read SPD info).

No SMBus I801 adapter. Is the i2c-i801 driver loaded? Do you see any
complaints in the kernel log (e.g. ACPI resource conflict) when reloading
the i2c-i801 driver?

> > Then you can check if devices are seen on the bus:
> >
> > # i2cdetect 8
> >
> > If you see anything in address range 0x50 to 0x55, this is likely to be
> > SPD EEPROMs. Then you have to make sure that the eeprom module is
> > loaded:
> 
>    From the above list, buses 3-6 have a value 0x50 at 0x50 like so:
> # i2cdetect -y 5
>         0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> <snip>
> 50: 50 -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 
> Though that's probably irrelevant, as it's not the SMBus, if I understand
> correctly.

Most likely the EDID from your screen, you can decode it with:
# modprobe eeprom
$ decode-edid

But that's not what your are looking for.

-- 
Jean Delvare
