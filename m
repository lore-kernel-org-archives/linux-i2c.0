From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH 4/4] eeprom: at24: Add OF device ID table
Date: Thu, 16 Mar 2017 12:39:29 -0300
Message-ID: <21663b26-8581-b8d6-7bab-7e7b65798a6a@osg.samsung.com>
References: <20170314151638.23132-1-javier@osg.samsung.com>
 <20170314151638.23132-5-javier@osg.samsung.com>
 <CAHp75Vf5=E37Ccrc2zMo8xOWmA-A_FZL7d57q7Rxk07M-V5mhg@mail.gmail.com>
 <8e233f15-4f91-b495-5270-5a7f982b31be@osg.samsung.com>
 <20170315075835.GA1438@katana>
 <ed3caa80-2b73-752e-a13f-aa5d348abd18@osg.samsung.com>
 <20170316130714.n42zkjdei7pm7vgw@ninjato>
 <5da325d0-59d4-92e8-350f-43c25310dabb@osg.samsung.com>
 <20170316133645.3nlr75gjhx7io7mv@ninjato>
 <b4e993ce-4630-6d89-077b-e2f18fadef02@osg.samsung.com>
 <20170316150549.GA3988@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170316150549.GA3988@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Kieran Bingham <kieranbingham@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Hello Wolfram,

On 03/16/2017 12:05 PM, Wolfram Sang wrote:
> 
>>> Rob into the boat if he is OK with updating all DTS files having such an
>>> EEPROM.
>>>
>>
>> Agreed, are you going to take care of that?
> 
> Nope, sorry, no bandwidth. You might ask Lee, he was very interested in
> getting proper I2C OF support upstream.
>

Ok, understandable. Adding Lee and Kieran to cc who were also interested on this.
 
>> up on this task, it has been a big time sink and I had to explain over and over
>> to different people what the problem is with the I2C modalias uevent reporting.
> 
> Next time, maybe do a wiki page and point people to it? That being said,
> we should probably create a wiki page on the I2C wiki anyhow.
> Documenting the current state of affairs. That I would do when I finally
> get around to brush up I2C wiki.
> 

Agreed, I can help writing such a wiki page if you want. I've already requested for
an account at https://i2c.wiki.kernel.org.

>> But it seems that for many maintainers this is just an unnecessary churn and they
>> don't think there's an issue with the current behaviour. So it feels I'm causing
>> more harm than good by keep pushing this.
> 
> I understand somehow. They probably were reluctant to change something

Yes, I don't blame them. It's kind of corner case that most people don't hit it.

One problem though is that this implementation detail leaks into the DTS and DT
binding documents, as we saw people using compatible strings without a vendor
prefix just because they could.

> that is working, even if it is not pretty. I'm not saying it's not worth
> it, yet one needs energy and motivation to push it through.
> 

Yeah, I think I've the energy and motivation but unfortunately also not enough
time :) And likely to have even less time in the near future.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
