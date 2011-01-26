From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Identifying i2c devices on Asus P8P67 sandybridge motherboard
Date: Wed, 26 Jan 2011 09:22:57 +0100
Message-ID: <20110126092257.7b1243dd@endymion.delvare>
References: <4D3EF4C0.1090008@cfl.rr.com>
	<20110125174246.5061f881@endymion.delvare>
	<4D3F622B.9060003@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4D3F622B.9060003-3tLf1voIkJTQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Phillip Susi <psusi-3tLf1voIkJTQT0dZR+AlfA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Philip,

On Tue, 25 Jan 2011 18:52:11 -0500, Phillip Susi wrote:
> On 01/25/2011 11:42 AM, Jean Delvare wrote:
> > Probably because you run a distribution where someone stupidly
> > blacklisted i2c-i801 because it caused trouble on one single machine
> > once. And you should report this as a bug.
> 
> Good call.
> 
> > All recent desktop boards from Asus implement an ACPI device named
> > ATK0110 for hardware monitoring, which is supported by the asus_atk0110
> > driver. So if all you are interested in is hardware monitoring, that's
> > the way to go.
> 
> That would show up in /sys/bus/acpi/ATK0110 right?  I don't seem to have 
> it, nor any mention of "ATK" in the DSDT.  It also looks like the DSDT 
> does not define the smbus interface.

It would show up as:

/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:03/ATK0110:00
/sys/bus/acpi/devices/ATK0110:00

or similar.

BTW, what kind of hardware monitoring and/or fan control features does
your BIOS offer?

> > If you really want a complete analysis of what may be on your SMBus,
> > please share the output of i2cdetect with us. You can get register
> > dumps from most devices using i2cdump, however I would NOT recommend
> > doing this on all addresses randomly, as some devices are known to
> > misbehave when accessed in a way they do not expect.
> 
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          -- -- -- -- -- 08 -- -- -- -- -- -- --
> 10: -- -- -- -- -- 15 -- -- -- -- -- -- -- -- -- --
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 40: -- -- -- -- 44 -- -- -- -- -- -- -- -- -- -- --
> 50: 50 -- 52 -- -- -- -- -- -- -- -- -- -- -- -- --
> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- 6e --
> 70: -- -- -- -- -- -- -- --
> 
> I am guessing that 50 and 52 are the SPD eeproms on my dimms,

Correct.

> but what could the others be?

08 and 44 are SMBus internal addresses, i.e. not real chips. This
leaves 15 and 6e, which do not correspond to anything I know.
Sensors-detect does not even scan them.

> Also sensors-detect did not identify them as SPD 
> eeproms.  I loaded the eeprom module and looked at the data it pulled 
> out of them and it does appear to contain an ascii string that is the 
> part number of the dimms, but decode-dimms does not seem to like it.

This is strange. Can you please send me a dump of these SPD EEPROMs?

# modprobe i2c-dev
# rmmod eeprom
# i2cdump <bus_nr> 0x50 b > /tmp/eeprom-0x50.dump
# i2cdump <bus_nr> 0x52 b > /tmp/eeprom-0x52.dump

where <bus_nr> is the I2C bus number of your Intel SMBus.

Back to your hardware monitoring issue, Asus tends to use the
integrated sensors in the Super-I/O on desktop boards. So odds are that
you have a very recent Super-I/O chip sensors-detect doesn't know. From
pictures found on the web, it seems to be a Nuvoton NCT6776F, for which
we indeed have no support yet.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html
