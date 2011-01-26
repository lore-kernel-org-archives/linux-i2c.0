From: Phillip Susi <psusi-3tLf1voIkJTQT0dZR+AlfA@public.gmane.org>
Subject: Re: Identifying i2c devices on Asus P8P67 sandybridge motherboard
Date: Wed, 26 Jan 2011 15:39:11 -0500
Message-ID: <4D40866F.4080102@cfl.rr.com>
References: <4D3EF4C0.1090008@cfl.rr.com>	<20110125174246.5061f881@endymion.delvare>	<4D3F622B.9060003@cfl.rr.com> <20110126092257.7b1243dd@endymion.delvare> <4D4032CC.5010008@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4D4032CC.5010008-3tLf1voIkJTQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 1/26/2011 9:42 AM, Phillip Susi wrote:
>> Back to your hardware monitoring issue, Asus tends to use the
>> integrated sensors in the Super-I/O on desktop boards. So odds are that
>> you have a very recent Super-I/O chip sensors-detect doesn't know. From
>> pictures found on the web, it seems to be a Nuvoton NCT6776F, for which
>> we indeed have no support yet.
> 
> I began to suspect as much.  Do you know if anyone is working on a
> driver for it, or if the data sheet is available so I could take a crack
> at it?

I have gotten ahold of the data sheet for the chip so hopefully will be
able to write a driver for it, but maybe we should move this
conversation to the lm-sensors mailing list?

Before we do though, I sill have one more question about the i2c bus.
My understanding is that simple i2c devices use fixed addresses, like
the SPD EEPROMs, but SMBus devices initially respond to a broadcast
address where they can be detected and dynamically assigned an address.
 Is there a tool that can perform such a reset and enumeration that
could give better identification of those two unknown devices, should
they be smbus compatible and not just i2c?  When I tried reading them
with i2c-dump I just got a bunch of XXs.
