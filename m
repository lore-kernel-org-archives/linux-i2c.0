From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v6 5/6] i2c: Add Actions Semiconductor Owl family S900 I2C
 driver
Date: Mon, 23 Jul 2018 09:40:15 +0200
Message-ID: <690ed3da-c576-5a3b-e0fe-5bfaae3ba5f2@axentia.se>
References: <20180723034025.5763-1-manivannan.sadhasivam@linaro.org>
 <20180723034025.5763-6-manivannan.sadhasivam@linaro.org>
 <911dc259-7b30-9c6e-2c82-2f4c032b9d73@axentia.se>
 <CAHp75Vf+SLQERDhDGRE-J_hmWwniiHN0FALbaBQjBY4GRNV_Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAHp75Vf+SLQERDhDGRE-J_hmWwniiHN0FALbaBQjBY4GRNV_Fw@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: devicetree <devicetree@vger.kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>, Mani Sadhasivam <manivannanece23@gmail.com>, hzhang@ucrobotics.com, Wolfram Sang <wsa@the-dreams.de>, Thomas Liau <thomas.liau@actions-semi.com>, Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?B?5YiY54Kc?= <liuwei@actions-semi.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, amit.kucheria@linaro.org, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, jeff.chen@actions-semi.com, Rob Herring <robh+dt@kernel.org>, 96boards@ucrobotics.com, linux-i2c <linux-i2c@vger.kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, bdong@ucrobotics.com, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, mp-cs@actions-semi.com
List-Id: linux-i2c@vger.kernel.org

On 2018-07-23 09:24, Andy Shevchenko wrote:
> On Mon, Jul 23, 2018 at 9:12 AM, Peter Rosin <peda@axentia.se> wrote:
>> On 2018-07-23 05:40, Manivannan Sadhasivam wrote:
>>> +             /* Handle the remaining bytes which were not sent */
>>> +             while (!(readl(i2c_dev->base + OWL_I2C_REG_FIFOSTAT) &
>>> +                    OWL_I2C_FIFOSTAT_TFF) && i2c_dev->msg_ptr < msg->len) {
>>
>> You moved the OWL_ line to the left instead of right, so this is still
>> misaligned and thus not helping the reader.
> 
> Guys, wouldn't be better to
> 
> 
> while (i2c_dev->msg_ptr < msg->len) {
>  u32 fifostat = readl();
> 
>  if (!(fifostat & ...))
>  break;
> ...
> }
> 
> ?
> 
> Same for the other branch.
> 
> Yes, it's more LOCs, but less bikeshedding,

Says the guy arriving late to the table with an incredibly valuable
suggestion... Please explain why my suggestion is bikeshedding and
yours is not?

Aligning with the opening parenthesis is right. Aligning with the wrong
opening parenthesis is of course going to risk confusing the reader.

Cheers,
Peter
