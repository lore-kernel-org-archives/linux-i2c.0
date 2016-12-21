From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] i2c: uniphier[-f]: fix bool logic calculation
Date: Thu, 22 Dec 2016 00:39:21 +0900
Message-ID: <CAK7LNAS7DaG-Ath1-qzA3C6WLNV=YiSCjgDnsOH4-eS0yt04Hg@mail.gmail.com>
References: <1476851911-21729-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNATrR9dSuuUZR98f=uOZqSGqUBnUNZmrUqUZgubHHE+X4A@mail.gmail.com> <1482256538.1984.23.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1482256538.1984.23.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: linux-i2c@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

Hi Joe,


2016-12-21 2:55 GMT+09:00 Joe Perches <joe@perches.com>:
> On Wed, 2016-12-21 at 01:20 +0900, Masahiro Yamada wrote:
>> Hi.
>>
>> I have not got any comment, but does this seem
>> a right thing to do?
>
>> This code is working, but it should not depend on how "bool" is
>> typedef'ed, or the bit position of I2C_M_RD.
>
> <shrug>
>
> I think bool can be guaranteed to be _Bool.
>
> So a change not necessary as the original code
> has a c90 guarantee of the same result.
>
> 6.3.1.2 Boolean type
> 1
> When any scalar value is converted to _Bool, the result is 0 if the value compares equal
> to 0; otherwise, the result is 1.
>

Thanks for your comments!

_Bool works very nicely.

I have seen some (not very nice) projects
that define like "typedef char bool;"

So, I was wondering if I should write code
that works regardless how bool is defined.
Just my two cents.

-- 
Best Regards
Masahiro Yamada
