From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [RESEND PATCH v5 00/16] eeprom: at24: Add OF device ID table
Date: Wed, 30 Aug 2017 21:57:16 +0200
Message-ID: <CABxcv==JFm0H_kB8LRyRpZNbajcO3UkxYOepkk=YUAaT1UH1gg@mail.gmail.com>
References: <20170615185418.13980-1-javier@dowhile0.org> <20170731153009.xkjknygpmckv2pfp@ninjato>
 <CABxcv=mdbE0QGjoi3aLzxRqM3-MbkQ_Ai6fShcGVUGSNNqqrqw@mail.gmail.com>
 <20170828160121.gu4wf7jqu4ditksc@ninjato> <CABxcv=kSiqDN1=9fSfLkyW=uuXQZAoW4dhw=fco9RyOdDuPAdA@mail.gmail.com>
 <20170829084831.hsdok3ksi7anxzuc@ninjato> <CABxcv=nqbNsTs7D57VOt1-Tav_3i9U=XKn=BV=hPr1tG68eE2g@mail.gmail.com>
 <20170830174228.sx5jgtxxy56zq47t@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170830174228.sx5jgtxxy56zq47t@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>, Florian Larysch <fl@n621.de>, David Lechner <david@lechnology.com>, Rob Herring <robh+dt@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, Simon Horman <horms@verge.net.au>, Michal Simek <michal.simek@xilinx.com>, Dinh Nguyen <dinguyen@kernel.org>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, Scott Wood <oss@buserror.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joachim Eastwood <manabian@gmail.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-i2c@vger.kernel.org

>
> I think we should talk about the same case: Let me repeat what I did:
>
> 1) I added your patch "eeprom: at24: Add OF device ID table"
> 2) I added an EEPROM node to an I2C
>
> +       eeprom@50 {
> +               compatible = "renesas,24c01";
> +               reg = <0x50>;
> +       };
>
> -> no at24 binding to the device
>
> 3) I revert your patch
>
> -> at24 binding to the device
>

I've tested this and you are right, it fails...

The problem is that the patch also changes how the driver obtains the
EEPROM parameters (the magic value in the entry's data field).

So even when module autoload and device / driver matching works, the
driver probe function fails because if (client->dev.of_node) the
driver attempts to get the entry data using
of_device_get_match_data(), which is obviously wrong since the
compatible string in the dev node isn't present in the OF table.

The id->driver_data from the I2C table should be used instead since
that's the table that matches in this case.

One option is to fallback to id->driver_data if
of_device_get_match_data() fails, but that's just an (ugly)
workaround. So I agree with you that the best option is to wait for
the DTS patches to land first.

It worked for me on my previous tests because the tested drivers
didn't use a table entry data, I'm so sorry for missing this :(

Best regards,
Javier
