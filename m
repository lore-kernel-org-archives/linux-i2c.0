From: vitor <Vitor.Soares@synopsys.com>
Subject: Re: [PATCH 1/3] i3c: master: Add driver for Synopsys DesignWare IP
Date: Wed, 8 Aug 2018 18:01:55 +0100
Message-ID: <ce858157-8353-2c8f-53f2-dbf2339355e9@synopsys.com>
References: <1532120272-17157-1-git-send-email-soares@synopsys.com>
 <1532120272-17157-2-git-send-email-soares@synopsys.com>
 <CAHp75VfYYmr7o6xkDbjaad3HxyzZgODzKfSNWdPXjM+YjTMANA@mail.gmail.com>
 <9fdfaf4e-5a20-af81-82ef-0d9e327f9133@synopsys.com>
 <CAHp75Vd6Ok6i3wQjT=jd3mtFAC2na1vwUs2cr-xhStQ_OjKjAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vd6Ok6i3wQjT=jd3mtFAC2na1vwUs2cr-xhStQ_OjKjAg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Vitor Soares <Vitor.Soares@synopsys.com>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Linux Documentation List <linux-doc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Andy,


On 25-07-2018 17:56, Andy Shevchenko wrote:
> On Wed, Jul 25, 2018 at 11:43 AM, Vitor Soares
> <Vitor.Soares@synopsys.com> wrote:
>> On Fri, Jul 20, 2018 at 11:57 PM, Vitor soares
>> <Vitor.Soares@synopsys.com> wrote:
>>
> Thanks for answers, my comments below.
>
>> This patch add driver for Synopsys DesignWare IP on top of
>> I3C subsystem patchset proposal V6
> ...
>
>> +#include <linux/reset.h>
>> Reset API.
>>
>> All of them required? Why?
> Thanks, got it.
>
>> There is some header files that are already included by others header files.
>> Should I add them too? it there any rule for that?
> No need.
> Usually we drop some "wired" headers (when we sure that one will
> always include the other one, like module.h vs. init.h)
>
>> +               writel(cmd->cmd_hi, master->regs + COMMAND_QUEUE_PORT);
>> +               writel(cmd->cmd_lo, master->regs + COMMAND_QUEUE_PORT);
>>
>> hmm... writesl()?
>> Is there any advantage here?
> Here maybe not. Just a material to think about. If you can refactor
> code to utilize them, good.
>
>> +       info->pid = (u64)readl(master->regs + SLV_PID_VALUE);
>>
>> Why explicit casting?
>> info->pid is u64 size.
> In C standard there is an integer promotion which allows you not to
> use explicit casting in such cases.
>
>> +       u32 r;
>> +
>> +
>> +       core_rate = clk_get_rate(master->core_clk);
>>
>> Too many blank lines in between.
>>
>>
>> For me in that way it's better to filter code parts. Do you think that is
>> not readable?
> The point is it's useless.
> On the other hand, you have a lot of inconsistency with that style.
>
>> +               p = (ret >> 6) ^ (ret >> 5) ^ (ret >> 4) ^ (ret >> 3) ^
>> +                   (ret >> 2) ^ (ret >> 1) ^ ret ^ 1;
>> +               p = p & 1;
>>
>> Is it parity calculus? Do we have something implemented in kernel already?
>>
>> Btw,
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__graphics.stanford.edu_-7Eseander_bithacks.html-23ParityNaive&d=DwIBaQ&c=DPL6_X_6JkXFx7AXWqB0tg&r=qVuU64u9x77Y0Kd0PhDK_lpxFgg6PK9PateHwjb_DY0&m=5FpGHBbT8tYA6PB4RT_9O6PJk3v-wYcy1MV59xoqK4I&s=FSJ3EcuoxPtRJWmsk9Yt4s_UH9kxFBam01Xvas2ZFdo&e=
>> offered this
>>
>> v ^= v >> 4;
>> v &= 0xf;
>> v = (0x6996 >> v) & 1;
>>
>>
>> I search into the kernel and I didn't find any function for that. In your
>> opinion what shoud I use?
> If license of the piece above is okay to use in kernel, then
> definitely it would be better (even we might create a helper out of
> it).
>
Thanks for your comments I will take them into account for the next version.

Best regards,
Vitor Soares
