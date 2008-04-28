From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: Add Intel SCH I2C SMBus support
Date: Mon, 28 Apr 2008 10:57:38 +0200
Message-ID: <20080428105738.06429ed2@hyperion.delvare>
References: <20080424100510.09cc2d4b@dxy.sh.intel.com>
	<48124673.8020808@assembler.cz>
	<20080428144514.53aa54fd@dxy.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080428144514.53aa54fd-PCb9FJy6fea75v1z/vFq2g@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Alek Du <alek.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Alek,

On Mon, 28 Apr 2008 14:45:14 +0800, Alek Du wrote:
> Rudolf,
> 
> Here are my i2cdetect and i2cdump results (with the patch I posted, I did not
> change), please help to see if they are expected results -- for me, the
> i2cdump 0 0x50 c/b/w work fine, but i2cdump 0 0x50 s crashes.
> 
> (T: m1)root@ume:/home/ume# i2cdetect -l
> i2c-2   i2c             intel drm LVDSDDC_C                     I2C adapter
> i2c-1   i2c             intel drm LVDSBLC_B                     I2C adapter
> i2c-0   smbus           SMBus POULSBO adapt                     SMBus adapter
> 
> (T: m1)root@ume:/home/ume# i2cdetect 0
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0.
> I will probe address range 0x03-0x77.
> Continue? [Y/n] y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f 
> 10: 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 
> 20: 20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f 
> 30: 30 31 32 33 34 35 36 37 38 39 3a 3b 3c 3d 3e 3f 
> 40: 40 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f 
> 50: 50 51 52 53 54 55 56 57 58 59 5a 5b 5c 5d 5e 5f 
> 60: 60 61 62 63 64 65 66 67 68 69 6a 6b 6c 6d 6e 6f 
> 70: 70 71 72 73 74 75 76 77                         

This is not correct. The driver should report success only when a
device is found at a given address, if not it should return -ENODEV.
>From the output above it appears that your driver always report success.

> 
> (T: m1)root@ume:/home/ume# i2cdump 0 0x50 b
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0, address 0x50, mode byte
> Continue? [Y/n] y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 80 08 08 0d 0a 61 40 00 05 3d 50 00 82 10 00 00    ?????a@.?=P.??..
> 10: 0c 08 18 01 04 00 01 50 50 00 00 3c 28 3c 2d 80    ?????.?PP..<(<-?
> 20: 25 37 10 22 3c 1e 1e 00 06 3c 7f 80 1e 28 00 00    %7?"<??.?<???(..
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 12 2a    ..............?*
> 40: 2c 00 00 00 00 00 00 00 08 38 48 54 46 31 32 38    ,.......?8HTF128
> 50: 36 34 48 44 59 2d 35 33 45 45 31 01 00 07 38 df    64HDY-53EE1?.?8?
> 60: 11 b8 fd 00 00 00 00 00 00 00 00 00 00 00 00 00    ???.............
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
> (T: m1)root@ume:/home/ume# i2cdump 0 0x50 c
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0, address 0x50, mode byte consecutive read
> Continue? [Y/n] y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 80 08 08 0d 0a 61 40 00 05 3d 50 00 82 10 00 00    ?????a@.?=P.??..
> 10: 0c 08 18 01 04 00 01 50 50 00 00 3c 28 3c 2d 80    ?????.?PP..<(<-?
> 20: 25 37 10 22 3c 1e 1e 00 06 3c 7f 80 1e 28 00 00    %7?"<??.?<???(..
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 12 2a    ..............?*
> 40: 2c 00 00 00 00 00 00 00 08 38 48 54 46 31 32 38    ,.......?8HTF128
> 50: 36 34 48 44 59 2d 35 33 45 45 31 01 00 07 38 df    64HDY-53EE1?.?8?
> 60: 11 b8 fd 00 00 00 00 00 00 00 00 00 00 00 00 00    ???.............
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
> (T: m1)root@ume:/home/ume# i2cdump 0 0x50 w
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0, address 0x50, mode word
> Continue? [Y/n] y
>      0,8  1,9  2,a  3,b  4,c  5,d  6,e  7,f
> 00: 0880 0808 0d08 0a0d 610a 4061 0040 0500 
> 08: 3d05 503d 0050 8200 1082 0010 0000 0c00 
> 10: 080c 1808 0118 0401 0004 0100 5001 5050 
> 18: 0050 0000 3c00 283c 3c28 2d3c 802d 2580 
> 20: 3725 1037 2210 3c22 1e3c 1e1e 001e 0600 
> 28: 3c06 7f3c 807f 1e80 281e 0028 0000 0000 
> 30: 0000 0000 0000 0000 0000 0000 0000 0000 
> 38: 0000 0000 0000 0000 0000 1200 2a12 2c2a 
> 40: 002c 0000 0000 0000 0000 0000 0000 0800 
> 48: 3808 4838 5448 4654 3146 3231 3832 3638 
> 50: 3436 4834 4448 5944 2d59 352d 3335 4533 
> 58: 4545 3145 0131 0001 0700 3807 df38 11df 
> 60: b811 fdb8 00fd 0000 0000 0000 0000 0000 
> 68: 0000 0000 0000 0000 0000 0000 0000 0000 
> 70: 0000 0000 0000 0000 0000 0000 0000 0000 
> 78: 0000 0000 0000 0000 0000 0000 0000 ff00 
> 80: ffff ffff ffff ffff ffff ffff ffff ffff 
> 88: ffff ffff ffff ffff ffff ffff ffff ffff 
> 90: ffff ffff ffff ffff ffff ffff ffff ffff 
> 98: ffff ffff ffff ffff ffff ffff ffff ffff 
> a0: ffff ffff ffff ffff ffff ffff ffff ffff 
> a8: ffff ffff ffff ffff ffff ffff ffff ffff 
> b0: ffff ffff ffff ffff ffff ffff ffff ffff 
> b8: ffff ffff ffff ffff ffff ffff ffff ffff 
> c0: ffff ffff ffff ffff ffff ffff ffff ffff 
> c8: ffff ffff ffff ffff ffff ffff ffff ffff 
> d0: ffff ffff ffff ffff ffff ffff ffff ffff 
> d8: ffff ffff ffff ffff ffff ffff ffff ffff 
> e0: ffff ffff ffff ffff ffff ffff ffff ffff 
> e8: ffff ffff ffff ffff ffff ffff ffff ffff 
> f0: ffff ffff ffff ffff ffff ffff ffff ffff 
> f8: ffff ffff ffff ffff ffff ffff ffff 80ff 

These look OK.

> 
> (T: m1)root@ume:/home/ume# i2cdump 0 0x50 s
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0, address 0x50, mode smbus block
> Continue? [Y/n] y
> Segmentation fault
> 
> 
> "i2cdump 0 0x50 s" crashes!! 

I guess there's a stack trace in the kernel log?

Presumably your implementation of the SMBus block read transaction is
broken, you have to check it.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
