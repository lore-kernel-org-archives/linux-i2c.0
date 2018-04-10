From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] MAINTAINERS: remove me as maintainer for I2C host drivers
Date: Tue, 10 Apr 2018 18:42:08 +0200
Message-ID: <29ab4b56-f857-a2d6-0b28-833896e9f47c@axentia.se>
References: <20180410141125.4477-1-wsa@the-dreams.de>
 <68529743-2df6-f07f-b3db-720e09b765c3@axentia.se>
 <20180410155250.rjrfd6v5unqlf25m@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180410155250.rjrfd6v5unqlf25m@ninjato>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
List-Id: linux-i2c@vger.kernel.org

On 2018-04-10 17:52, Wolfram Sang wrote:
> Hi Peter,
> 
>> Hmm, I think you are ducking out from the i2c-mux-pinctrl driver as well.
>> Was that the intent?
> 
> Oops, nope! Sorry, I just forgot about the demux (I think you mean that
> one) driver and will create a seperate entry for it.

Right, I meant the demux...

>>
>>> +I2C SUBSYSTEM DRIVERS
>>> +L:	linux-i2c@vger.kernel.org
>>> +W:	https://i2c.wiki.kernel.org/
>>> +Q:	https://patchwork.ozlabs.org/project/linux-i2c/list/
>>> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git
>>> +S:	Odd Fixes
>>> +F:	Documentation/devicetree/bindings/i2c/
>>> +F:	drivers/i2c/*/
>>> +
>>
>> And this includes all the other muxes, i.e. those that are "mine". Maybe
>> not a problem, but what do I know?
> 
> Sorry again, I really didn't want to dump something on you or leave you
> all alone with the muxes. I was just so focussed on the host drivers
> that muxes simply slipped through my mind :( I can add myself to the
> muxes section again, no problem. I'll let you decidei what you prefer,
> both is fine for me. You are doing a great job there!

No no, you don't need to add yourself there. I understand the mux drivers,
and it's pretty quiet, so no need for that. What I was worrying about was
this "Odd Fixes" fallback entry needlessly covering the muxes when they
are covered elsewhere.

Cheers,
Peter
