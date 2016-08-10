From: Abylay Ospan <aospan@netup.ru>
Subject: Re: [PATCH 1/4] media: pci: netup_unidvb: don't print error when
 adding adapter fails
Date: Wed, 10 Aug 2016 10:41:05 -0400
Message-ID: <CAK3bHNUL3NjFFex4US09ZnxvKV-1oJAu=qVrZUSgeKy90CBiAA@mail.gmail.com>
References: <1470742517-12774-1-git-send-email-wsa-dev@sang-engineering.com>
 <1470742517-12774-2-git-send-email-wsa-dev@sang-engineering.com>
 <CAK3bHNWmxQsAtefcUocoOcEwtWnpptiVxzhXR-+jVU524RmnPw@mail.gmail.com> <20160809145856.GC1666@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160809145856.GC1666@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa-dev@sang-engineering.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Sergey Kozlov <serjk@netup.ru>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media <linux-media@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

yes, you right. If we remove this message there is no big problem. But
if we do not remove this it's also ok, right ? What the big deal to
remove this type of messages (i'm just interested) ?


For me it's ok to remove:
Acked-by: Abylay Ospan <aospan@netup.ru>


2016-08-09 10:58 GMT-04:00 Wolfram Sang <wsa@the-dreams.de>:
>
>> Sometimes it better to show more message - especially in error conditions :)
>
> Sure, if they contain additional information.
>
>> btw, do you make sanity check for "duplicate" log messages ?
>
> I checked all error messages if they contain additional information.
>
>>             ret = i2c_add_adapter(&i2c->adap);
>>     -       if (ret) {
>>     -               dev_err(&ndev->pci_dev->dev,
>>     -                       "%s(): failed to add I2C adapter\n", __func__);
>>     +       if (ret)
>>                     return ret;
>>     -       }
>
> IMHO, this one doesn't. __func__ is not helpful to users. And the error
> messages in the core will make sure that a developer knows where to
> start looking.
>



-- 
Abylay Ospan,
NetUP Inc.
http://www.netup.tv
