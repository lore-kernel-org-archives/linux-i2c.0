From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH 4/4] eeprom: at24: Add OF device ID table
Date: Thu, 16 Mar 2017 11:07:23 -0300
Message-ID: <b4e993ce-4630-6d89-077b-e2f18fadef02@osg.samsung.com>
References: <20170314151638.23132-1-javier@osg.samsung.com>
 <20170314151638.23132-5-javier@osg.samsung.com>
 <CAHp75Vf5=E37Ccrc2zMo8xOWmA-A_FZL7d57q7Rxk07M-V5mhg@mail.gmail.com>
 <8e233f15-4f91-b495-5270-5a7f982b31be@osg.samsung.com>
 <20170315075835.GA1438@katana>
 <ed3caa80-2b73-752e-a13f-aa5d348abd18@osg.samsung.com>
 <20170316130714.n42zkjdei7pm7vgw@ninjato>
 <5da325d0-59d4-92e8-350f-43c25310dabb@osg.samsung.com>
 <20170316133645.3nlr75gjhx7io7mv@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170316133645.3nlr75gjhx7io7mv@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hello Wolfram,

On 03/16/2017 10:36 AM, Wolfram Sang wrote:
> 
>> Sorry, for not explaining myself correctly. I meant to ask who can do what you
>> suggested before. I'm certainly not familiar with this driver to identify what
>> is the minimum set of compatible strings that can be used as generic fallback.
> 
> Well, I am the maintainer of this driver :) But we should definately get

Oh right, silly me :)

> Rob into the boat if he is OK with updating all DTS files having such an
> EEPROM.
>

Agreed, are you going to take care of that? To be honest I think I'll just give
up on this task, it has been a big time sink and I had to explain over and over
to different people what the problem is with the I2C modalias uevent reporting.

I've posted patches for all the drivers that could be affected when reporting a
proper OF modalias by the core and also the RFC patch to properly report it [0].

But it seems that for many maintainers this is just an unnecessary churn and they
don't think there's an issue with the current behaviour. So it feels I'm causing
more harm than good by keep pushing this.

[0]: https://lkml.org/lkml/2015/7/30/494

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
