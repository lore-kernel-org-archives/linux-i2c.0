From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 4/8] pinctrl: qcom: sdm845: Provide ACPI support
Date: Wed, 12 Jun 2019 09:18:23 +0200
Message-ID: <CACRpkdZLO0tOuaribTWK5eMYD6_drdGJk9x7tG7YDxJKVJqOVg@mail.gmail.com>
References: <20190610084213.1052-1-lee.jones@linaro.org> <20190610084213.1052-4-lee.jones@linaro.org>
 <CAKv+Gu_s7i8JC4cv-dJMvm1_0cGzzhzf+Dxu0rxcF7iugF=vHg@mail.gmail.com>
 <20190610085542.GL4797@dell> <CAKv+Gu8rhxciy1cOG3B3pda9+p4R_COGrrqa7S_Rj9y2HeBxYw@mail.gmail.com>
 <20190610092245.GN4797@dell> <20190611183945.GP4814@minitux>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190611183945.GP4814@minitux>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, alokc@codeaurora.org, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jeffrey Hugo <jlhugo@gmail.com>, linux-i2c <linux-i2c@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-usb <linux-usb@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jun 11, 2019 at 8:39 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:

> Last time we discussed this the _only_ offender was the loop issuing a
> get_direction() on all descs towards the end of
> gpiochip_add_data_with_key()

I think that is still the only offender.

We were a bit back and forth: adding that code, removing it
and then adding it back again.

In a way it is good that we detect it so users do not crash their
kernels by asking for these GPIOs at runtime from userspace
instead.

It makes a lot of sense for us to ask for the initial direction for
all pins, as they get registered as GPIOs, which by definition
makes them available as such and we should be able to inspect
them.

"GPIOs" reserved by ACPI arguably are not GPIOs anymore
since ACPI have dedicated them to a special purpose
(no more "general purpose").

Yours,
Linus Walleij
