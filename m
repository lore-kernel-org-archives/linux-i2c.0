From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2cset question
Date: Fri, 17 Apr 2009 17:48:45 +0200
Message-ID: <20090417174845.471d4d9d@hyperion.delvare>
References: <49E89342.1010807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49E89342.1010807-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Cole <clecol-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Chris,

On Fri, 17 Apr 2009 10:33:38 -0400, Chris Cole wrote:
> Hey all, I found the i2c-tools and lm-sensors packages today...great 
> stuff! I had a question about using i2cset properly. I'm trying to set 
> the value of a digital potentiometer (maxim 5434L) over the i2cbus, and 
> I can tell by using i2cdump that it's setting the register value 
> properly...but I keep getting "Warning - readback failed" after i use 
> i2cset. Here's the output of what I'm trying to do:
> 
> ccole@test:~$ sudo modprobe scx200_acb
> ccole@test:~$ sudo modprobe i2c-dev
> ccole@test:~$ sudo su -
> root@test:~# i2cdetect -l
> i2c-0    smbus         CS5536 ACB0                         SMBus adapter
> 
> root@test:~# i2cdetect 0
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0.
> I will probe address range 0x03-0x77.
> Continue? [Y/n] y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 50: 50 -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 70: -- -- -- -- -- -- -- --
> root@test:~# i2cdump 0 0x50
> No size specified (using byte-data access)
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0, address 0x50, mode byte
> Continue? [Y/n] y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 80 08 07 0d 0b 01 40 00 04 60 70 00 82 08 00 01    ??????@.?`p.??.?
> 10: 0e 04 0c 01 02 20 c0 75 70 00 00 48 30 48 2a 80    ????? ?up..H0H*?
> 20: 80 80 45 45 00 00 00 00 00 3c 48 30 2d 55 00 01    ??EE.....<H0-U.?
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 10 68    ..............?h
> 40: 7f 7f 7f 7f 7f ba 00 00 00 56 4c 34 37 30 4c 36    ??????...VL470L6
> 50: 7f 32 33 2d 42 33 53 00 00 00 00 00 00 00 00 00    ?23-B3S.........
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................

This is the SPD EEPROM of your memory module (512 MB of PC2700 DDR
SDRAM according to decode-dimms.) This is not your digital
potentiometer.

> 
> root@test:~# i2cset 0 0x50 0x50 0x21
> No size specified (using byte-data access)
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> DANGEROUS! Writing to a serial EEPROM on a memory DIMM
> may render your memory USELESS and make your system UNBOOTABLE!

As the warning says, you REALLY shouldn't do this!

> I will write to device file /dev/i2c-0, chip address 0x50, data address
> 0x50, data 0x21, mode byte.
> Continue? [y/N] y
> Warning - readback failed
> 
> root@test:~# i2cdump 0 0x50
> No size specified (using byte-data access)
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0, address 0x50, mode byte
> Continue? [Y/n] y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 80 08 07 0d 0b 01 40 00 04 60 70 00 82 08 00 01    ??????@.?`p.??.?
> 10: 0e 04 0c 01 02 20 c0 75 70 00 00 48 30 48 2a 80    ????? ?up..H0H*?
> 20: 80 80 45 45 00 00 00 00 00 3c 48 30 2d 55 00 01    ??EE.....<H0-U.?
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 10 68    ..............?h
> 40: 7f 7f 7f 7f 7f ba 00 00 00 56 4c 34 37 30 4c 36    ??????...VL470L6
> 50: 21 32 33 2d 42 33 53 00 00 00 00 00 00 00 00 00    !23-B3S.........
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 
> root@test:~# i2cset 0 0x50 0x50 0x00
> No size specified (using byte-data access)
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> DANGEROUS! Writing to a serial EEPROM on a memory DIMM
> may render your memory USELESS and make your system UNBOOTABLE!
> I will write to device file /dev/i2c-0, chip address 0x50, data address
> 0x50, data 0x00, mode byte.
> Continue? [y/N] y
> Warning - readback failed
> 
> root@test:~# i2cdump 0 0x50
> No size specified (using byte-data access)
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0, address 0x50, mode byte
> Continue? [Y/n] y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 80 08 07 0d 0b 01 40 00 04 60 70 00 82 08 00 01    ??????@.?`p.??.?
> 10: 0e 04 0c 01 02 20 c0 75 70 00 00 48 30 48 2a 80    ????? ?up..H0H*?
> 20: 80 80 45 45 00 00 00 00 00 3c 48 30 2d 55 00 01    ??EE.....<H0-U.?
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 10 68    ..............?h
> 40: 7f 7f 7f 7f 7f ba 00 00 00 56 4c 34 37 30 4c 36    ??????...VL470L6
> 50: 00 32 33 2d 42 33 53 00 00 00 00 00 00 00 00 00    .23-B3S.........
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................

You are very lucky that you didn't write to a byte location < 0x40,
that would have broken the checksum and you would no longer be able to
boot your system.

I encourage you to restore the value of byte 0x50 to what it originally
was and never ever again touch this SPD EEPROM.

The "readback failed" warning is presumably because it takes some time
to the EEPROM to write the new data and in the meantime you can't read
from it.

The MAX5434L has I2C address 0x28 or 0x29. It doesn't show on
i2cdetect. Check whether it's properly soldered. If it is, try i2cget
instead of i2cdetect, maybe the Maxim chip doesn't like the probes
i2cdetect does.

-- 
Jean Delvare
