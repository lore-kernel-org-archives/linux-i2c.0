From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 09/14] i2c: Add Device Tree support to the Nomadik I2C
 driver
Date: Wed, 13 Jun 2012 13:28:17 +0100
Message-ID: <4FD88761.9050703@linaro.org>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org> <1339428307-3850-10-git-send-email-lee.jones@linaro.org> <CACRpkdaMDbH4NkiHRLAfbJZ_j4QXbwg94bvaWsdYRPH+dSfc8Q@mail.gmail.com> <4FD6F0E8.5040606@linaro.org> <CACRpkdYxiT-0x4aetMxB2x8SkB+Mmy8rk8uSzgU_anemSayhMw@mail.gmail.com> <4FD83AAD.2010701@linaro.org> <CACRpkdZC8E6izDpdnWy6DMjOdA6KsqTaPoaq9pErWoNW0Ewytw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkdZC8E6izDpdnWy6DMjOdA6KsqTaPoaq9pErWoNW0Ewytw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 13/06/12 09:12, Linus Walleij wrote:
> On Wed, Jun 13, 2012 at 9:01 AM, Lee Jones<lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>  wro=
te:
>
>> Board specific is fine, as the data is protected by a board specific
>> property. Do you mean that the properties are *bus specific*? In whi=
ch case
>> I see your point and will apply the correct bindings.
>
> I cannot parse this, the board for me is a SoC, busses and a
> number of components connected via e.g. I2C.
>
> Can you define what you mean with a "board specific property"?
> It seems you are talking about what I would call an
> "SoC-specific property", i.e. something out of a .dtsi file for
> a certain SoC, whereas the .dts for an entire board is,
> well, for a board, a set of components on a PCB.
>
> The arrangement of accelerometers and battery monitors on a
> certain board is board-specific, and it is also by definition
> bus-specific.

Okay, let's put it another way. We can individualise any board, bus,=20
platform, machine or system by placing all of the information in a DT=20
node so long as we plonk it in the correct place within the Device Tree=
=2E=20
However, we have just as much control by keeping them in separate=20
structs in the C file and selecting the right one using the compatible=20
sting.

The real item for discussion is; if we have varying configurations for=20
each of the i2c buses residing on the same SoC, do we really want to us=
e=20
different compatible strings to identify each one. If the answer is no,=
=20
which I think it is, then I need to write the bindings and have=20
everything individually configurable from Device Tree.

While you're mulling this over, I'm just going to write the bindings an=
yway.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
