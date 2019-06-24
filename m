From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH 1/3] include: linux: i2c: more helpers for declaring i2c
 drivers
Date: Mon, 24 Jun 2019 10:59:17 +0200
Message-ID: <205d0ef7-d487-006b-d104-88958f40e197@metux.net>
References: <1560796779-17117-1-git-send-email-info@metux.net>
 <20190621211744.GC950@kunai> <c669a041-f025-693a-492a-80ce888db737@metux.net>
 <20190624084427.GA1014@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190624084427.GA1014@kunai>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "Enrico Weigelt, metux IT consult" <info@metux.net>, linux-kernel@vger.kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 24.06.19 10:44, Wolfram Sang wrote:

> The correct solution is to fix the boot dependency in the affected I2C
> client drivers. That definately needs HW and thorough testing.
> 
> It may also need something better than the current deferred probe. Big
> topic.

So, then the current approach of using subsys_initcall() can't be
changed easily, right now. But planned for the future (or at least
not introducing new caes).

But: how does that conflict w/ just moving the existing redundant
pieces into a helper macro ? The logic stays the same - just using
a shorter notation. (assuming my patch isn't buggy ;-)).

I can add a remark in the function documentation that this shall
only by used in rare cases, and maybe something like "that's just
legacy  - introducing  new caller is most certainly wrong" ;-)


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
