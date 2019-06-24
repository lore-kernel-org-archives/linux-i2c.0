From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH 1/3] include: linux: i2c: more helpers for declaring i2c
 drivers
Date: Mon, 24 Jun 2019 07:44:01 +0200
Message-ID: <c669a041-f025-693a-492a-80ce888db737@metux.net>
References: <1560796779-17117-1-git-send-email-info@metux.net>
 <20190621211744.GC950@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190621211744.GC950@kunai>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: linux-kernel@vger.kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 21.06.19 23:17, Wolfram Sang wrote:
> On Mon, Jun 17, 2019 at 08:39:37PM +0200, Enrico Weigelt, metux IT consult wrote:
>> From: Enrico Weigelt <info@metux.net>
>>
>> Add more helper macros for trivial driver init cases, similar to the
>> already existing module_i2c_driver()+friends - now for those which
>> are initialized at other stages (eg. by subsys_initcall()).
>>
>> This helps to further reduce driver init boilerplate.
> 
> Uh, no! Using subsys_initcall is an old fashioned hack to work around
> boot time dependencies. Unless there are very strong arguments, I
> usually do not accept them anymore. So, any simplification of that sends
> out the wrong message.

Okay, what's the correct initialization method then ?
Just convert it to already existing module_i2c_driver() ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
