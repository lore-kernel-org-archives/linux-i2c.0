From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: Re: [PATCH RFC 3/3] ARM64: bcm2837-rpi: Fix pwm and i2c pin control
Date: Mon, 27 Feb 2017 22:13:05 +0100 (CET)
Message-ID: <1798682438.259359.1488229985933@email.1und1.de>
References: <1487280047-29608-1-git-send-email-stefan.wahren@i2se.com>
 <1487280047-29608-4-git-send-email-stefan.wahren@i2se.com>
 <87r32j8ial.fsf@eliezer.anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87r32j8ial.fsf-omZaPlIz5HhaEpDpdNBo/KxOck334EZe@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Robinson <pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


> Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org> hat am 27. Februar 2017 um 21:56 geschrieben:
> 
> 
> Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org> writes:
> 
> > According to the firmware DT blob [1] the RPi 3 uses different
> > pins for i2c0 and pwm.
> >
> > [1] - https://github.com/raspberrypi/firmware/blob/master/extra/dt-blob.dts
> >
> > Fixes: 9d56c22a7861 ("ARM: bcm2835: Add devicetree for the Raspberry Pi 3.")
> > Signed-off-by: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
> 
> Interesting.  The dt-blob does, I think, basically reflect the state
> that the pins will be in when the firmware hands off to us.  Note that
> the firmware also, at boot, sets ID_SDA/SCL to function 0 (i2c0), probes
> for a HAT ROM and saves it, then restores those pins to whatever mux
> they had before (presumably the dt-blob pin_config values).
> 
> Linux doesn't have any HAT probing code itself, so leaving pins 0/1 as
> GPIO input (most boards) or i2c0 (rev2) should be fine.  I think this
> patch should effectively be a no-op, unless you've enabled the pwm node.
> 
> My only suggestion for change is: These pin configurations are
> board-specific, so could we just move them into the specific board
> files, instead? 

Yes, that would be better. In case of pin configurations do you mean only those affected by this patch or all pin configurations?

> Basically leave bcm2835-rpi.dtsi as the "generic
> configuration of bcm283x for the rpi firmware" rather than "things
> common to bcm2835/6 with rpi firmware but not bcm2837 with rpi
> firmware".

If this our intension, shouldn't we rename it to bcm283x-rpi.dtsi?

Ah, now i feel the pain about having symlinks from arm64/dts to arm/dts.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
