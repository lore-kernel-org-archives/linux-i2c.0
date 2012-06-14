From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V3 2/3] i2c-nomadik: turn the platform driver to an amba driver
Date: Thu, 14 Jun 2012 19:25:48 +0200
Message-ID: <CACRpkdZfherHBEXcwaco1zeK-gW=3x-rGXTfNc4QwwWfLk_JRA@mail.gmail.com>
References: <201206140804.39083.arnd@arndb.de>
	<cover.1339447570.git.rubini@gnudd.com>
	<4a198618063924b68182279ffd56c335d621f542.1339447570.git.rubini@gnudd.com>
	<20120614081758.GA19648@mail.gnudd.com>
	<4FD9A328.9080000@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FD9A328.9080000-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: Alessandro Rubini <rubini-kaDoWcXyVrEAvxtiuMwx3w@public.gmane.org>, arnd-r2nGTMty4D4@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, giancarlo.asnaghi-qxv4g6HH51o@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Jun 14, 2012 at 10:39 AM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrot=
e:
> On 14/06/12 09:17, Alessandro Rubini wrote:
>>>
>>> You change only one half of ux500 here: the part where the device
>>> gets defined statically, but not not the definition in the
>>> device-tree.
>>
>> Yes, I'm aware. That's why I added Lee Jones as Cc:, on Linusw's
>> suggestion. =A0Lee told me to go ahead and he'll fix the DT stuff.
>
> I did?

Yes :-)

> I have already DT:ed this driver. There are 3 patches on the MLs curr=
ently.
>
>> [PATCH 1/3] i2c: Add Device Tree support to the Nomadik I2C driver
>> [PATCH 2/3] ARM: ux500: Add i2c configurations to the Device Tree fo=
r
>> DB8500 based devices
>> [PATCH 3/3] Documentation: Device Tree binding information for i2c-n=
omadik
>> driver
>
> I'm more than happy for you to base your patches on these and make th=
e
> necessary changes. Off hand, I think the only changes you'll need to =
make is
> the probing from DT itself.

Depends on whether this patch or yours go in first I guess. Which
is up to Wolfram. What I know is that Alessandros patches are
ready to merge IMO.

> So something like:
>
>    -                       compatible =3D "stericsson,db8500-i2c", "s=
t,nomadik-i2c";
>    +                       compatible =3D "st,nomadik-i2c", "arm,prim=
ecell";

Yep that should do it.

Which brings me to the fear of what happens the day we have
deployed device trees out there and just cannot change things
like this easily :-/

Yours,
Linus Walleij
