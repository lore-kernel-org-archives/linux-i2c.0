From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v6 5/6] i2c: Add Actions Semiconductor Owl family S900 I2C driver
Date: Mon, 23 Jul 2018 10:24:58 +0300
Message-ID: <CAHp75Vf+SLQERDhDGRE-J_hmWwniiHN0FALbaBQjBY4GRNV_Fw@mail.gmail.com>
References: <20180723034025.5763-1-manivannan.sadhasivam@linaro.org>
 <20180723034025.5763-6-manivannan.sadhasivam@linaro.org> <911dc259-7b30-9c6e-2c82-2f4c032b9d73@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <911dc259-7b30-9c6e-2c82-2f4c032b9d73@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Linus Walleij <linus.walleij@linaro.org>, linux-i2c <linux-i2c@vger.kernel.org>, =?UTF-8?B?5YiY54Kc?= <liuwei@actions-semi.com>, mp-cs@actions-semi.com, 96boards@ucrobotics.com, devicetree <devicetree@vger.kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>, amit.kucheria@linaro.org, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, hzhang@ucrobotics.com, bdong@ucrobotics.com, Mani Sadhasivam <manivannanece23@gmail.com>, Thomas Liau <thomas.liau@action>
List-Id: linux-i2c@vger.kernel.org

On Mon, Jul 23, 2018 at 9:12 AM, Peter Rosin <peda@axentia.se> wrote:
> On 2018-07-23 05:40, Manivannan Sadhasivam wrote:
>> +             /* Handle the remaining bytes which were not sent */
>> +             while (!(readl(i2c_dev->base + OWL_I2C_REG_FIFOSTAT) &
>> +                    OWL_I2C_FIFOSTAT_TFF) && i2c_dev->msg_ptr < msg->len) {
>
> You moved the OWL_ line to the left instead of right, so this is still
> misaligned and thus not helping the reader.

Guys, wouldn't be better to


while (i2c_dev->msg_ptr < msg->len) {
 u32 fifostat = readl();

 if (!(fifostat & ...))
 break;
...
}

?

Same for the other branch.

Yes, it's more LOCs, but less bikeshedding,

-- 
With Best Regards,
Andy Shevchenko
