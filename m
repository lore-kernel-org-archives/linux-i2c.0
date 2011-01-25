From: Phillip Susi <psusi-3tLf1voIkJTQT0dZR+AlfA@public.gmane.org>
Subject: Re: Identifying i2c devices on Asus P8P67 sandybridge motherboard
Date: Tue, 25 Jan 2011 18:52:11 -0500
Message-ID: <4D3F622B.9060003@cfl.rr.com>
References: <4D3EF4C0.1090008@cfl.rr.com> <20110125174246.5061f881@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110125174246.5061f881-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 01/25/2011 11:42 AM, Jean Delvare wrote:
> Probably because you run a distribution where someone stupidly
> blacklisted i2c-i801 because it caused trouble on one single machine
> once. And you should report this as a bug.

Good call.

> All recent desktop boards from Asus implement an ACPI device named
> ATK0110 for hardware monitoring, which is supported by the asus_atk0110
> driver. So if all you are interested in is hardware monitoring, that's
> the way to go.

That would show up in /sys/bus/acpi/ATK0110 right?  I don't seem to have 
it, nor any mention of "ATK" in the DSDT.  It also looks like the DSDT 
does not define the smbus interface.

> If you really want a complete analysis of what may be on your SMBus,
> please share the output of i2cdetect with us. You can get register
> dumps from most devices using i2cdump, however I would NOT recommend
> doing this on all addresses randomly, as some devices are known to
> misbehave when accessed in a way they do not expect.

      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- 08 -- -- -- -- -- -- --
10: -- -- -- -- -- 15 -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- 44 -- -- -- -- -- -- -- -- -- -- --
50: 50 -- 52 -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- 6e --
70: -- -- -- -- -- -- -- --

I am guessing that 50 and 52 are the SPD eeproms on my dimms, but what 
could the others be?  Also sensors-detect did not identify them as SPD 
eeproms.  I loaded the eeprom module and looked at the data it pulled 
out of them and it does appear to contain an ascii string that is the 
part number of the dimms, but decode-dimms does not seem to like it.
