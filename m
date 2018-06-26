From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 1/5] i2c: smbus: add unlocked __i2c_smbus_xfer variant
Date: Tue, 26 Jun 2018 13:54:01 +0200
Message-ID: <79E4A06C-26EF-4FF4-AFEA-7E7769FDF995@axentia.se>
References: <20180620085157.30121-1-peda@axentia.se> <20180620085157.30121-2-peda@axentia.se> <20180626023757.l54suaryim2fieq3@ninjato>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180626023757.l54suaryim2fieq3@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, Vadim Pasternak <vadimp@mellanox.com>, Michael Shych <michaelsh@mellanox.com>, Guenter Roeck <linux@roeck-us.net>, Akinobu Mita <akinobu.mita@gmail.com>, Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On June 26, 2018 4:37:58 AM GMT+02:00, Wolfram Sang <wsa@the-dreams=2Ede> w=
rote:
>
>> This is not perfectly equivalent, since i2c_smbus_xfer was callable
>from
>> atomic/irq context if you happened to end up emulating SMBus with an
>I2C
>> transfer, and that is no longer the case with this patch=2E It is
>unknown
>> (to me) if anything depends on that quirk, but it seems fragile
>enough to
>> simply break those cases and require them to call i2c_transfer
>directly
>> instead=2E
>
>Couldn't we just add the same trylock-code path here as well? I always
>wondered why I2C and SMBus were not in sync when it came to that=2E Yet,
>I
>didn't want to change the code for no reason, but it seems we now have
>one?
>
>Rest of the series looks good to me, very nice diffstat!

I don't think it's that easy as I just thought about another problem with =
lifting the locking from the emulation function=2E It calls kzalloc(=2E=2E=
=2E, GFP_KERNEL), at least in some cases, and that's not a very good idea f=
rom atomic/irq context=2E=2E=2E

Cheers,
Peter
