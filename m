From: Trent Piepho <tpiepho-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [patch 2.6.27-rc7] i2c: smbalert# support
Date: Sat, 22 Nov 2008 12:28:56 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0811221055470.18022@t2.domain.actdsltmp>
References: <200804161434.54335.laurentp@cse-semaphore.com>
 <200809231532.40083.david-b@pacbell.net> <20081118091546.421d6b78@hyperion.delvare>
 <200811181401.34809.david-b@pacbell.net> <Pine.LNX.4.64.0811190140510.11673@t2.domain.actdsltmp>
 <20081119161632.2d0bde9e@hyperion.delvare> <Pine.LNX.4.64.0811201354310.11673@t2.domain.actdsltmp>
 <20081121094218.34ecd82a@hyperion.delvare> <Pine.LNX.4.64.0811212122370.18022@t2.domain.actdsltmp>
 <20081122111340.0bfc2c05@hyperion.delvare>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20081122111340.0bfc2c05-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, 22 Nov 2008, Jean Delvare wrote:
> On Fri, 21 Nov 2008 22:04:26 -0800 (PST), Trent Piepho wrote:
>> On Fri, 21 Nov 2008, Jean Delvare wrote:
>>> You are unfair. We have been continuously cleaning up the i2c subsystem
>>> over the past few years, shrinking the main structures regularly,
>>> killing unused code, etc. And this clean-up process is going on.
>>
>> The size of i2c-core, struct i2c_client and struct i2c_adapter:
>> v2.6.28 9718 392 500	w/ smbalert patch
>> v2.6.28 8878 392 472
>> v2.6.27 8732 368 448
>> v2.6.26 7877 352 440
>> v2.6.25 7854 376 444
>> v2.6.24 9060 372 444
>> v2.6.23 9359 404 476
>> v2.6.22 9330 448 520
>> v2.6.21 7814 464 692
>> v2.6.20 7896 444 672
>> v2.6.19 7871 444 668
>> v2.6.18 6857 436 660
>
> Thanks for providing these numbers, these are really useful! I'm
> curious if you would be able to compute the same numbers down to, say,
> kernel 2.6.5 or even 2.6.0? I'm curious where we started from.
>
> I am also interested in the script / method you used to come up with
> these numbers, so that maybe I can get the numbers myself if you do not
> have the time.

It's not entirely automatic since you have to deal with configuring the
kernel.  It helps to start at the newest kernel and work backwards, since
kconfig options are added more often than removed.

I put this in my .bashrc to make getting object sizes easier:
function objsize { ${CROSS_COMPILE}objdump -h $1 | awk '/text|data|bss/{x=strtonum("0x"$3);printf "%-16s%d\t%d\n",$2,x,s+=x;}' ;}

Then to get structure sizes:
cat > lib/size.c
#include <linux/i2c.h>
#define S(t) cpu_to_be32(sizeof(struct t))
uint32_t a=S(i2c_adapter), b=S(i2c_client);  // reverse order in obj

On older kernels you have to replace cpu_to_be32() with ___constant_swab32()
on little-endian systems and remove it on big-endian.

Then do this for each version:

ver=v2.6.17
git checkout -f $ver
echo 'obj-y += size.o' >> lib/Makefile
mkdir $ver
cp last.config $ver/.config
make O=$ver
# answer make questions, try not to turn on anything that adds debug/trace
# code or extra fields to data structures.  Or turns off extra fields that
# used to be mandatory.  Or changes compiler flags, e.g. inlining or regparm. 
# Wait...
ssize=`objdump -s -j .data $ver/lib/size.o |
 	awk '/^ 0/{print strtonum("0x"$2),strtonum("0x"$3);}'`
csize=`objsize $ver/drivers/i2c/i2c-core.o | awk 'END{print $3}'`
echo `git describe` $csize $ssize >> i2csize
cp $ver/.config last.config

v2.6.17 6934 416 640
v2.6.16 7320 404 620
