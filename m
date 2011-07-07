From: Tim Nelson <tnelson-f4DZ+GDyDBaakBO8gow8eQ@public.gmane.org>
Subject: Re: Winbond W83L604G
Date: Thu, 7 Jul 2011 10:32:38 -0500 (CDT)
Message-ID: <19430981.80.1310052758044.JavaMail.root@zmail.rockbochs.com>
References: <20110707101931.18379a23@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110707101931.18379a23-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

----- Original Message -----
> As pointed out by Michael already, 08h in the datasheet translates to
> 0x08 in the Linux world.

I'm curious how this conversion translates. Is it as simple as dropping the suffix 'h', no actual math involved? Most other registers are noted with an 'h' suffix as well for this chip.

> 
> The correct slave address is certainly 0x19, as the datasheet says
> that
> the first 4 address bits are hard-set to 0011b, which means a 7-bit
> slave address in the 0x18-0x1f range. The device at 0x4c could be a
> thermal sensor (sensors-detect should tell.)

Yes, correct. We have an ITE super-IO sensor onboard for monitoring which is at 0x4c.

> Yes, with i2cget and i2cset you could do that. But I suspect that in
> the end you will want to write a proper kernel GPIO driver, so that
> you
> can benefit from all the nice things gpiolib does for you (including,
> but not limited to, clear and safe access from other kernel drivers.)
> There are several examples of such drivers under drivers/gpio (pcf857x
> and pca953x in particular.)

This specific implementation purely needs to exist in userland as the only use for the controller is LED status (on, off, blink).

I'm now able to read from the proper register for the GP10-GP13 pins, but I'm not able to write. Example:

root@aaa:~# i2cget -y 0 0x19 0x08
0x00

According to the datasbeet, to set all LEDs from off to on, I'd need to set the 0x08 register to binary '10101010' which is 0xaa in hex. So:

root@aaa:~# i2cset -y 0 0x19 0x08 0xaa
Error: Write failed

Is my binary->hex math incorrect (verified against a few online calcs...)? Am I blatantly missing something else?

--Tim
