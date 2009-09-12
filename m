From: Kari Laine <klaine8-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Velleman K8000
Date: Sat, 12 Sep 2009 19:39:25 +0300
Message-ID: <61452b690909120939kcc61779vfb7e686a40276ef7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean

thank you very much for good information.

Hopefully you can answer these questions as well because I am totally l=
ost.

On Sat, Sep 12, 2009 at 12:12 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wro=
te:
> You didn't tell which kernel you are using, but kernel 2.6.17 and lat=
er
> wouldn't let you load i2c-parport without a type parameter.
The kernel is 2.6.27

> It doesn't matter. i2c-core gets loaded automatically when any other
> module needs it.
it indeed is.

> You should install i2c-tools and use the command "i2cdetect -l". This
> will tell you what each i2c bus on your system is.
>
> Then you can try "i2cdetect <n>" where <n> is a bus number, to scan t=
he
> bus in question. This is a good way to test whether the driver and
> device are working properly.
it gives this. So it seems to find all four chips on Velleman K8000 .

=A0 =A0 0 =A01 =A02 =A03 =A04 =A05 =A06 =A07 =A08 =A09 =A0a =A0b =A0c =A0=
d =A0e =A0f
00: =A0 =A0 =A0 =A0 =A0-- -- -- -- -- -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: 20 -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- 38 39 -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- 48 -- -- -- -- -- -- --
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --

>
>> If these devices probably refer to Velleman - then how I can refer
>> different i2c-devices on the board.
>
> Depends on the device. In the case of the Philips PCF8591, which
> apparently you are using, sysfs attributes will be created somewhere
> under /sys/bus/i2c/drivers/pcf8591. Each device has a name of the for=
m
> <bus number>-<device address>, for example "1-0048" for a PCF8591.
When I now do

modprobe pcf8591

In

linux-1fyv:/sys/bus/i2c/devices =A0directory

comes 1-0048

Now I have to figure out how to use this device. Any comments.

The Velleman K8000 card has three other chips which show up in
I2C-bus. Two PCF8574A which are I/O-chips and TDA8444-chip which is
DA-chip. I don't find any modules for them. Does it mean that they are
not supported as of yet or anymore?


>
> The sysfs attributes in question are described in
> Documentation/hwmon/pcf8591 (or Documentation/i2c/chips/pcf8591 on
> kernels older than 2.6.30.)
>


> Hope this helps,
It helped much!

All the best to you

Kari
