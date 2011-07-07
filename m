From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Winbond W83L604G
Date: Thu, 7 Jul 2011 10:19:31 +0200
Message-ID: <20110707101931.18379a23@endymion.delvare>
References: <29201825.112.1309965025512.JavaMail.root@zmail.rockbochs.com>
	<13595453.330.1309984221608.JavaMail.root@zmail.rockbochs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <13595453.330.1309984221608.JavaMail.root-N94c1vXlnCs/q/FG96+aB0EOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tim Nelson <tnelson-f4DZ+GDyDBaakBO8gow8eQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Tim,

On Wed, 6 Jul 2011 15:30:21 -0500 (CDT), Tim Nelson wrote:
> Next, I probe for I2C devices on the SMBus:
> 
> root@aaa:~# i2cdetect -y 0
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
> 10: -- -- -- -- -- -- -- -- -- 19 -- -- -- -- -- --
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 40: -- -- -- -- -- -- -- -- -- -- -- -- 4c -- -- --
> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 70: -- -- -- -- -- -- -- --
> 
> 
> According to the W83L604G datasheet[1], I should be able to control the LED GPIO pins using register 08h. In an attempt to see the current values, I'm using i2cget, but getting no proper results:
> 
> root@aaa:~# i2cget -y 0 0x4c 0x8h
> Error: Data address invalid!
> 
> 
> Thinking I had the wrong i2c device, I tried the other detected device, same results:
> 
> root@aaa:~# i2cget -y 0 0x19 0x8h
> Error: Data address invalid!

As pointed out by Michael already, 08h in the datasheet translates to
0x08 in the Linux world.

The correct slave address is certainly 0x19, as the datasheet says that
the first 4 address bits are hard-set to 0011b, which means a 7-bit
slave address in the 0x18-0x1f range. The device at 0x4c could be a
thermal sensor (sensors-detect should tell.)

> (...)
> Once I can read/write the registers properly, I should be able to control the GPIO pins, no?

Yes, with i2cget and i2cset you could do that. But I suspect that in
the end you will want to write a proper kernel GPIO driver, so that you
can benefit from all the nice things gpiolib does for you (including,
but not limited to, clear and safe access from other kernel drivers.)
There are several examples of such drivers under drivers/gpio (pcf857x
and pca953x in particular.)

-- 
Jean Delvare
