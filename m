From: Tim Nelson <tnelson-f4DZ+GDyDBaakBO8gow8eQ@public.gmane.org>
Subject: Re: Winbond W83L604G
Date: Wed, 6 Jul 2011 15:30:21 -0500 (CDT)
Message-ID: <13595453.330.1309984221608.JavaMail.root@zmail.rockbochs.com>
References: <29201825.112.1309965025512.JavaMail.root@zmail.rockbochs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <29201825.112.1309965025512.JavaMail.root-N94c1vXlnCs/q/FG96+aB0EOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

----- Original Message -----
> >
> > Correct, and we have support for this device. Driver is named
> > scx200_acb. Load it and then "i2cdetect -l" should list the SMBus.
> >
> 
> YES! The SMBus is now detected. I'll continue working with the i2c
> toolset further.
> 

I think I'm *closer* to working with this chip, but not quite there yet!

After loading i2c-dev and scx200_acb, I am now able to see the system SMBus controller:

root@aaa:~# i2cdetect -l
i2c-0   smbus           CS5536 ACB0                             SMBus adapter


Next, I probe for I2C devices on the SMBus:

root@aaa:~# i2cdetect -y 0
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- 19 -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- 4c -- -- --
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --


According to the W83L604G datasheet[1], I should be able to control the LED GPIO pins using register 08h. In an attempt to see the current values, I'm using i2cget, but getting no proper results:

root@aaa:~# i2cget -y 0 0x4c 0x8h
Error: Data address invalid!


Thinking I had the wrong i2c device, I tried the other detected device, same results:

root@aaa:~# i2cget -y 0 0x19 0x8h
Error: Data address invalid!

After exhausting my Google-fu, I've seen other examples of this register format, but it is not working here.

Any thoughts on how to proceed next? I feel like I'm --> <-- this close, but just missing something. Once I can read/write the registers properly, I should be able to control the GPIO pins, no?

Thank you!

--Tim

[1] http://www.nuvoton-usa.com/products/winbond_products/pdfs/PCIC/W83L603G604G_E0%201.pdf (Page 7 for specific GP10-GP13 control registers)
