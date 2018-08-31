From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [Question] When should a driver issue STOP condition?
Date: Fri, 31 Aug 2018 23:39:20 +0900
Message-ID: <CAK7LNAQyUa=uDD-vTe32XfHAueqdVtVZP_+imL2-Kh9BeFCG1A@mail.gmail.com>
References: <CAK7LNAQO2aYLrtzg82jgKdKcOw20rNWBEY3DrdLcwOhnF9aa3A@mail.gmail.com>
 <20180831095356.ow6nhbx2fhhpuhjj@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180831095356.ow6nhbx2fhhpuhjj@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,


2018-08-31 18:53 GMT+09:00 Wolfram Sang <wsa@the-dreams.de>:
>
>> The problem is, my driver is forcibly setting
>> STOP condition unless the next message is read.
>
> This likely is a problem.


Oh, my drivers were wrong from the beginning.

I've sent patches.


> In Linux I2C terminology, a transfer is everything between a START and a
> STOP. A transfer may consist of multiple messages, connected with
> REP_START [1].
>
> So, a STOP should be generated after the last message of a transfer or
> of I2C_M_STOP is set in a message.

I see.
I hope this is documented somewhere if it has not been yet.


> The latter should be super-rare
> because mostly you should be able to use multiple transfers with a
> regular STOP instead.
>
> [1] Slide 8 illustrates this:
> http://events17.linuxfoundation.org/sites/events/files/slides/ELCE17-WSang-I2C-Fault-Injector.pdf

Awesome!

I should follow "When to not use bus recovery" check-list.

Thanks.

-- 
Best Regards
Masahiro Yamada
