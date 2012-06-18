From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: Fwd: [PATCH 1/3] i2c: Add Device Tree support to the Nomadik
 I2C driver
Date: Mon, 18 Jun 2012 08:18:05 +0100
Message-ID: <4FDED62D.6030008@linaro.org>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org> <1339428307-3850-10-git-send-email-lee.jones@linaro.org> <CACRpkdaMDbH4NkiHRLAfbJZ_j4QXbwg94bvaWsdYRPH+dSfc8Q@mail.gmail.com> <4FD8BAD2.50703@linaro.org> <CACRpkdZFi34nChnMEo6yik67zk9owZLk-6zcdP7mmOXyLz8uqQ@mail.gmail.com> <4FDAFA17.6050502@linaro.org> <CAE2-_9rRYxjU9QQgtBv9ReMY5x+oRiJG1cDQahYHanjDrwVUYA@mail.gmail.com> <20120615115042.GA27480@bnru02> <4FDB2E57.4030904@linaro.org> <20120615130544.GA28537@bnru02> <4FDB3642.5030804@linaro.org> <CACRpkdZ7ESKhokk8Z+6sC9Kq+jPztFNwzger0Db7nCD1fPnG1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkdZ7ESKhokk8Z+6sC9Kq+jPztFNwzger0Db7nCD1fPnG1A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Srinidhi Kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Cc: Linus WALLEIJ <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 17/06/12 18:43, Linus Walleij wrote:
> Gah, what a thread...
>
> On Fri, Jun 15, 2012 at 3:18 PM, Lee Jones<lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>  wro=
te:
>> On 15/06/12 14:05, Srinidhi Kasagar wrote:
>>> On Fri, Jun 15, 2012 at 14:45:11 +0200, Lee Jones wrote:
>>>> On 15/06/12 12:50, Srinidhi Kasagar wrote:
>
>>>>>> +static struct nmk_i2c_controller u8500_i2c =3D {
>>>>>> +       /*
>>>>>> +        * Slave data setup time; 250ns, 100ns, and 10ns, which
>>>>>> +        * is 14, 6 and 2 respectively for a 48Mhz i2c clock.
>>>>>> +        */
>>>>>> +       .slsu           =3D 0xe,
>>>>>> +       .tft            =3D 1,      /* Tx FIFO threshold */
>>>>>> +       .rft            =3D 8,      /* Rx FIFO threshold */
>>>>>> +       .clk_freq       =3D 100000, /* std. mode operation */
>>>>>> +       .timeout        =3D 200,    /* Slave response timeout(ms=
) */
>>>>>> +       .sm             =3D I2C_FREQ_MODE_FAST,
>>>>>
>>>>> How is this possible? you are setting clk_freq as 100kb/s and mod=
e
>>>>> as fast mode which is supposed to be 400kb/s.
>>>>
>>>> That's not how I read it:
>>>
>>> But it is not readable. It confuses people.
>>
>> I understood it. :)
>>
>> If you think it's unclear speak to the author, Linus. He's CC'ed.
>
> Author of what? The i2c driver was written by Srinidhi. (The
> MODULE_AUTHOR() clause should be a good hint...)

Actually, we appear to have our wires crossed. You wrote the board data=
=20
stuff below, which changes the mode from STANDARD to FAST, no doubt=20
using Srinidhi's struct explanation comments found in=20
arch/arm/plat-nomadik/include/plat/i2c.h.

 > I'll cook a separate patch for this or something.

Cool, thanks Linus.

But you're correct in what you say Linus. Srinidhi, the comments which=20
are you say are confusing are the bits you are the author of:=20
e208c447bd728920e4f3d438a706344ea31249b9?

> But it's true that board data for the ux500 kernel use
> 100000 Hz and I2C_FREQ_MODE_FAST, in the board-mop500.c
> file, like this:
>
> U8500_I2C_CONTROLLER(0, 0xe, 1, 8, 100000, 200, I2C_FREQ_MODE_FAST);
> U8500_I2C_CONTROLLER(1, 0xe, 1, 8, 100000, 200, I2C_FREQ_MODE_FAST);
> U8500_I2C_CONTROLLER(2, 0xe, 1, 8, 100000, 200, I2C_FREQ_MODE_FAST);
> U8500_I2C_CONTROLLER(3, 0xe, 1, 8, 100000, 200, I2C_FREQ_MODE_FAST);
 >
> This is indeed a bit odd. But obviously it works... But reading some
> fixes in another tree it seems it should look like this:
>
> /*
>   * The board uses 4 i2c controllers, initialize all of
>   * them with slave data setup time of 250 ns,
>   * Tx&  Rx FIFO threshold values as 1 and standard
>   * mode of operation
>   */
> U8500_I2C_CONTROLLER(0, 0xe, 1, 8, 400000, 200, I2C_FREQ_MODE_FAST);
> U8500_I2C_CONTROLLER(1, 0xe, 1, 8, 400000, 200, I2C_FREQ_MODE_FAST);
> U8500_I2C_CONTROLLER(2, 0xe, 1, 8, 400000, 200, I2C_FREQ_MODE_FAST);
> U8500_I2C_CONTROLLER(3, 0xe, 1, 8, 400000, 200, I2C_FREQ_MODE_FAST);
>
> Which makes *much* more sense.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
