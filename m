From: Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [PATCH 0/6] i2c: send STOP after recovery; use it for i2c-rcar
Date: Tue, 05 Dec 2017 10:21:56 +0100
Message-ID: <ae01d819-8f12-0f12-fc35-b46fd41c9477@samsung.com>
References: <CGME20171204123700epcas2p4273f3313a4c52e7685bbf04d776cbcef@epcas2p4.samsung.com>
        <20171204123640.3382-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-reply-to: <20171204123640.3382-1-wsa+renesas@sang-engineering.com>
Content-language: en-US
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Phil Reid <preid@electromag.com.au>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Claudio Foellmi <claudio.foellmi@ergon.ch>
List-Id: linux-i2c@vger.kernel.org

On 04.12.2017 13:36, Wolfram Sang wrote:
> When implementing bus recovery for the i2c-rcar driver, two problems were
> encountered: 1) When reading the SDA bit, not the SDA status was returned but
> the internal state of the "bus_is_busy" logic. 2) This logic needs a STOP to
> consider the bus free again. SCL/SDA high is not enough, and there is no other
> way known to reset the internal logic otherwise.
>
> The obvious solution to just send STOP after recovery makes sense for the
> generic case, too, IMO. If we made a device release SDA again, and are about
> start a new transfer using START, then we should terminate the previous state
> properly with STOP. This may help with some devices and shouldn't create any
> drawback AFAICS.
>
> For this, we need to introduce a 'set_sda' callback to the recovery
> infrastructure. Because of this and some other minor recovery core changes, I
> CCed a few people working on I2C bus recovery recently. The first five patches
> may be interesting for you, so your input is greatly appreciated. Also, testing
> the new features with GPIO based recovery would be awesome to have.
>
> This was tested on a Renesas Lager board (r8a7790/R-Car H2). My test procedure
> is documented here:
>
> https://elinux.org/Tests:I2C-bus-recovery
>
> A branch is available here:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/topic/rcar-i2c-recovery
>
> Please let me know what you think.

I do not feel myself experienced I2C developer, so please be merciful if
I write stupid things :)

>From what I see the whole recovery infrastructure partially duplicates
i2c_bit_algo/i2c_algo_bit_data algorithm, and GPIO recovery duplicates
i2c-gpio driver.
Wouldn't be better to somehow reuse existing code? For example by adding
recovery callback in i2c_algorithm, and call i2c-gpio::recovery or
i2c_bit_algo::recovery from rcar-i2c-recovery (in this particular case).

I am not sure how much work it requires, and if it is worth it. Please
consider it as suggestion.

Regards
Andrzej
