From: Phillip Susi <psusi-3tLf1voIkJTQT0dZR+AlfA@public.gmane.org>
Subject: Re: Identifying i2c devices on Asus P8P67 sandybridge motherboard
Date: Wed, 26 Jan 2011 09:42:20 -0500
Message-ID: <4D4032CC.5010008@cfl.rr.com>
References: <4D3EF4C0.1090008@cfl.rr.com>	<20110125174246.5061f881@endymion.delvare>	<4D3F622B.9060003@cfl.rr.com> <20110126092257.7b1243dd@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110126092257.7b1243dd-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 1/26/2011 3:22 AM, Jean Delvare wrote:
> It would show up as:
> 
> /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:03/ATK0110:00
> /sys/bus/acpi/devices/ATK0110:00

That's what I thought.  Don't have it.

> BTW, what kind of hardware monitoring and/or fan control features does
> your BIOS offer?

Asus calls it Q-fan.  It does seem to automatically throttle the fan
speed in response to temperature.  It has two 4 pin PWM headers and two
3 pin headers on the board, and the bios config has options to enable
fan speed control on either of the 4 pin headers.

> This is strange. Can you please send me a dump of these SPD EEPROMs?

Will get it to you when I get back home tonight.

> Back to your hardware monitoring issue, Asus tends to use the
> integrated sensors in the Super-I/O on desktop boards. So odds are that
> you have a very recent Super-I/O chip sensors-detect doesn't know. From
> pictures found on the web, it seems to be a Nuvoton NCT6776F, for which
> we indeed have no support yet.

I began to suspect as much.  Do you know if anyone is working on a
driver for it, or if the data sheet is available so I could take a crack
at it?

Then again, I wonder if it might be better to come up with an SSDT I can
dynamically load to define the ACPI FAN and TZ objects and let the
regular acpi driver manage it.
