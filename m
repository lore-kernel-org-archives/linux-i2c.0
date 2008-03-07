From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Monitor's EDID not recognised
Date: Fri, 7 Mar 2008 15:08:27 +0100
Message-ID: <20080307150827.0cfa9b5c@hyperion.delvare>
References: <200803071923.32035.jeremy.william.murphy@gmail.com>
	<200803072237.36693.jeremy.william.murphy@gmail.com>
	<20080307131120.4891f78e@hyperion.delvare>
	<200803080039.55332.jeremy.william.murphy@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200803080039.55332.jeremy.william.murphy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jeremy Murphy <jeremy.william.murphy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jeremy,

On Sat, 8 Mar 2008 00:39:55 +1100, Jeremy Murphy wrote:
> I've just learnt that a number of people could no longer access their EDID 
> after upgrading their nvidia driver to the 100.* series.  I downgraded to 
> 96.43.01 and now their is _something_ on the I2C nvidia bus 1, but it's not 
> pretty.
> 
> These following results are inconsistent, which I'm guessing is not a good 
> sign.  They vary somewhat between each call but they always have a similar 
> pattern (row+col).
> 
> 
> > i2cdetect 1
> 
> This is with eeprom loaded:
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f
> 10: 10 11 12 13 14 15 16 17 18 19 1a 1b 1c -- -- --
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 3f
> 40: 40 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f
> 50: 50 51 52 53 54 55 56 57 58 59 5a 5b 5c 5d 5e 5f
> 60: 60 61 62 63 64 65 66 67 68 69 6a 6b 6c 6d 6e 6f
> 70: 70 71 72 73 74 75 76 77
> 
> This is without:
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          -- -- -- -- -- -- -- -- 0b 0c 0d 0e 0f
> 10: 10 11 12 13 14 15 16 -- -- -- -- -- -- -- -- --
> 20: -- -- -- -- 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f
> 30: 30 31 32 33 34 35 36 37 38 39 3a 3b 3c 3d 3e 3f
> 40: 40 41 42 43 44 -- -- -- -- -- -- -- -- -- -- --
> 50: -- -- -- -- -- -- -- -- -- -- 5a 5b 5c 5d 5e 5f
> 60: 60 61 62 63 64 65 66 67 68 69 6a 6b 6c 6d 6e 6f
> 70: 70 71 72 73 74 75 76 77
> 
> At a guess, I'd say this is garbage?

I'd say the same, yes. The bus driver sees seemingly random acks and
nacks, but it is impossible that the above map is anything real. This
looks more like a hardware problem than a software issue though, so I'm
surprised that downgrading the nvidia driver changed anything.

BTW, note that you should NOT access the nvidia I2C buses created by
the binary nvidia X11 driver while not under X.

> > i2cdetect 2
> > i2cdetect 3
> 
> Both empty.
> 
> 
> > Either there is no EDID EEPROM connected at all (some monitors don't
> > have them, in particular older models) or it has a format different
> > from what the scripts expect.
> >
> > If anything shows up at 0x50 with i2cdetect, please provide a dump
> > using i2cdump (rmmod eeprom first.)
> 
> This is the output of i2cdump 1 0x50:
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 3f XX XX XX XX XX XX XX XX XX XX 00 00 00 00 00    ?XXXXXXXXXX.....
> 10: 00 00 00 00 XX XX XX XX XX XX XX XX XX XX 00 00    ....XXXXXXXXXX..
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 30: 00 00 00 00 00 XX XX XX XX XX XX XX XX XX 00 00    .....XXXXXXXXX..
> 40: 00 00 00 00 00 00 00 00 XX XX XX XX XX 00 00 00    ........XXXXX...
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 60: 00 00 00 00 00 00 00 00 00 00 00 XX XX XX XX XX    ...........XXXXX
> 70: XX XX XX XX XX XX 00 00 00 00 00 00 00 00 00 00    XXXXXX..........
> 80: 00 00 XX XX XX XX XX XX XX XX 00 00 00 00 00 00    ..XXXXXXXX......
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> a0: XX 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    X...............
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> c0: 00 00 00 00 XX XX XX XX XX XX XX XX XX XX XX 00    ....XXXXXXXXXXX.
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> f0: 00 00 00 00 00 00 XX XX XX XX XX XX XX XX XX XX    ......XXXXXXXXXX

Noise again...

> I presume the monitor has an EDID because the brochure says that it supports 
> DDC-2B and DDC-2Bi, and it's relatively recent as far as CRTs go.  Thanks for 
> your help, cheers.

OK. Two more things you can try:

* Get rid of the binary nvidia driver for a moment, and try the
nvidiafb driver. If it gets better, it suggests that the binary nvidia
driver is at fault. If you get the same noise, it has to be a hardware
issue.

* Did you try another video cable? The I2C bus signal is carried over 2
dedicated pins on the VGA connector (12 and 15), if your cable happens
to not have them wired properly for some reason, this could explain
your problem.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
