From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Winbond W83L604G
Date: Thu, 7 Jul 2011 18:23:15 +0200
Message-ID: <20110707182315.6e28f62a@endymion.delvare>
References: <20110707101931.18379a23@endymion.delvare>
	<19430981.80.1310052758044.JavaMail.root@zmail.rockbochs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <19430981.80.1310052758044.JavaMail.root-N94c1vXlnCs/q/FG96+aB0EOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tim Nelson <tnelson-f4DZ+GDyDBaakBO8gow8eQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Tim,

On Thu, 7 Jul 2011 10:32:38 -0500 (CDT), Tim Nelson wrote:
> ----- Original Message -----
> > As pointed out by Michael already, 08h in the datasheet translates to
> > 0x08 in the Linux world.
> 
> I'm curious how this conversion translates. Is it as simple as dropping the suffix 'h', no actual math involved? Most other registers are noted with an 'h' suffix as well for this chip.

No math involved. The "h" suffix means hexadecimal. The "0x" prefix
means the same. Which one to use depends on the environment and
culture. Have fun reading:
http://en.wikipedia.org/wiki/Hexadecimal#Representing_hexadecimal

> > The correct slave address is certainly 0x19, as the datasheet says
> > that
> > the first 4 address bits are hard-set to 0011b, which means a 7-bit
> > slave address in the 0x18-0x1f range. The device at 0x4c could be a
> > thermal sensor (sensors-detect should tell.)
> 
> Yes, correct. We have an ITE super-IO sensor onboard for monitoring which is at 0x4c.

That would be relatively surprising, as ITE super-I/O chips are LPC
devices accessed with direct I/O. I think there used to be one old
model which could alternatively be accessed over the SMBus (the
monitoring block at least) but it would be at address 0x2d rather than
0x4c, and I doubt current chips still support that.

Just try sensors-detect and see what it finds.

> > Yes, with i2cget and i2cset you could do that. But I suspect that in
> > the end you will want to write a proper kernel GPIO driver, so that
> > you
> > can benefit from all the nice things gpiolib does for you (including,
> > but not limited to, clear and safe access from other kernel drivers.)
> > There are several examples of such drivers under drivers/gpio (pcf857x
> > and pca953x in particular.)
> 
> This specific implementation purely needs to exist in userland as the only use for the controller is LED status (on, off, blink).

Well, there is a framework in the kernel for this too.

> I'm now able to read from the proper register for the GP10-GP13 pins, but I'm not able to write. Example:
> 
> root@aaa:~# i2cget -y 0 0x19 0x08
> 0x00
> 
> According to the datasbeet, to set all LEDs from off to on, I'd need to set the 0x08 register to binary '10101010' which is 0xaa in hex. So:
> 
> root@aaa:~# i2cset -y 0 0x19 0x08 0xaa
> Error: Write failed
> 
> Is my binary->hex math incorrect (verified against a few online calcs...)? Am I blatantly missing something else?

Your binary->hex is correct, and the command as well, but the chip did
not like the write for some reason. You should look at the kernel logs
when it failed, there may be a hint. You could also just retry to check
if this was maybe a transient error.

To test the reliability of the SMBus you could dump the whole register
map:
# i2cdump -y -r 0x00-0x22 0 0x19
and look for XX's.

-- 
Jean Delvare
