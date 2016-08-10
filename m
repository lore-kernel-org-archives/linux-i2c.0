From: Abylay Ospan <aospan@netup.ru>
Subject: Re: [PATCH 1/4] media: pci: netup_unidvb: don't print error when
 adding adapter fails
Date: Wed, 10 Aug 2016 11:06:54 -0400
Message-ID: <CAK3bHNV8JQ6h09i9YFYJyHoi=XDF827iLZFROsc5mX28HW9ASw@mail.gmail.com>
References: <1470742517-12774-1-git-send-email-wsa-dev@sang-engineering.com>
 <1470742517-12774-2-git-send-email-wsa-dev@sang-engineering.com>
 <CAK3bHNWmxQsAtefcUocoOcEwtWnpptiVxzhXR-+jVU524RmnPw@mail.gmail.com>
 <20160809145856.GC1666@katana> <CAK3bHNUL3NjFFex4US09ZnxvKV-1oJAu=qVrZUSgeKy90CBiAA@mail.gmail.com>
 <20160810145656.GD1607@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160810145656.GD1607@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa-dev@sang-engineering.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Sergey Kozlov <serjk@netup.ru>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media <linux-media@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

make sense. thanks for explaining and for patch !

2016-08-10 10:56 GMT-04:00 Wolfram Sang <wsa@the-dreams.de>:
>
>> if we do not remove this it's also ok, right ? What the big deal to
>> remove this type of messages (i'm just interested) ?
>
> * Saving memory, especially at runtime.
> * Giving consistent and precise error messages
>
> This series is a first step of trying to move generic error messages
> from drivers to subsystem cores.
>



-- 
Abylay Ospan,
NetUP Inc.
http://www.netup.tv
