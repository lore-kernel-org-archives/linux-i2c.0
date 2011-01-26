From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Identifying i2c devices on Asus P8P67 sandybridge motherboard
Date: Wed, 26 Jan 2011 22:37:46 +0100
Message-ID: <20110126223746.2d2141a1@endymion.delvare>
References: <4D3EF4C0.1090008@cfl.rr.com>
	<20110125174246.5061f881@endymion.delvare>
	<4D3F622B.9060003@cfl.rr.com>
	<20110126092257.7b1243dd@endymion.delvare>
	<4D4032CC.5010008@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4D4032CC.5010008-3tLf1voIkJTQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Phillip Susi <psusi-3tLf1voIkJTQT0dZR+AlfA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 26 Jan 2011 09:42:20 -0500, Phillip Susi wrote:
> On 1/26/2011 3:22 AM, Jean Delvare wrote:
> > Back to your hardware monitoring issue, Asus tends to use the
> > integrated sensors in the Super-I/O on desktop boards. So odds are that
> > you have a very recent Super-I/O chip sensors-detect doesn't know. From
> > pictures found on the web, it seems to be a Nuvoton NCT6776F, for which
> > we indeed have no support yet.
> 
> I began to suspect as much.  Do you know if anyone is working on a
> driver for it, or if the data sheet is available so I could take a crack
> at it?

No, the device isn't even listed on lm-sensors.org's wiki, I am not
aware of anyone working on it.

The datasheet isn't available for download from Nuvoton, but can
probably be requested from them.

> Then again, I wonder if it might be better to come up with an SSDT I can
> dynamically load to define the ACPI FAN and TZ objects and let the
> regular acpi driver manage it.

What an horrid idea. The ACPI FAN and TZ interfaces are very limited.
If the ACPI BIOS doesn't block access to the NCT6776F's I/O ports,
you'll be much better with a native driver.

OTOH I admit I am surprised to see Asus move away from the ATK0110.

-- 
Jean Delvare
