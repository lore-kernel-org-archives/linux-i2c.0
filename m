From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2cset question
Date: Fri, 17 Apr 2009 18:33:40 +0200
Message-ID: <20090417183340.5fc05ebb@hyperion.delvare>
References: <49E89342.1010807@gmail.com>
	<20090417174845.471d4d9d@hyperion.delvare>
	<49E8AD1E.1070805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49E8AD1E.1070805-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Cole <clecol-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 17 Apr 2009 12:23:58 -0400, Chris Cole wrote:
> > You are very lucky that you didn't write to a byte location < 0x40,
> > that would have broken the checksum and you would no longer be able to
> > boot your system.
> > 
> > I encourage you to restore the value of byte 0x50 to what it originally
> > was and never ever again touch this SPD EEPROM.
> > 
> > The "readback failed" warning is presumably because it takes some time
> > to the EEPROM to write the new data and in the meantime you can't read
> > from it.
> > 
> > The MAX5434L has I2C address 0x28 or 0x29. It doesn't show on
> > i2cdetect. Check whether it's properly soldered. If it is, try i2cget
> > instead of i2cdetect, maybe the Maxim chip doesn't like the probes
> > i2cdetect does.
> > 
> 
> Ok, I think we were getting confused about the MAX45434L data sheet 
> addressing and thought the address of 0x50 corresponded to the chip. I 
> now see that the address should be 0x28, however I know it's soldered 
> properly and I still can't see it with i2cget...am I dead in the water 
> or is there possibly another way to approach this?

You clearly have to solve your hardware problem first, and for that
there's nothing I can do. Maybe try another chip sample, or try on
another system.

-- 
Jean Delvare
