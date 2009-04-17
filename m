From: Chris Cole <clecol-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: i2cset question
Date: Fri, 17 Apr 2009 12:23:58 -0400
Message-ID: <49E8AD1E.1070805@gmail.com>
References: <49E89342.1010807@gmail.com> <20090417174845.471d4d9d@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090417174845.471d4d9d-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

> You are very lucky that you didn't write to a byte location < 0x40,
> that would have broken the checksum and you would no longer be able to
> boot your system.
> 
> I encourage you to restore the value of byte 0x50 to what it originally
> was and never ever again touch this SPD EEPROM.
> 
> The "readback failed" warning is presumably because it takes some time
> to the EEPROM to write the new data and in the meantime you can't read
> from it.
> 
> The MAX5434L has I2C address 0x28 or 0x29. It doesn't show on
> i2cdetect. Check whether it's properly soldered. If it is, try i2cget
> instead of i2cdetect, maybe the Maxim chip doesn't like the probes
> i2cdetect does.
> 

Ok, I think we were getting confused about the MAX45434L data sheet 
addressing and thought the address of 0x50 corresponded to the chip. I 
now see that the address should be 0x28, however I know it's soldered 
properly and I still can't see it with i2cget...am I dead in the water 
or is there possibly another way to approach this?

Thanks,
   Chris
