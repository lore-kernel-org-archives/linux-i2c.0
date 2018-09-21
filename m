From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: Re: [PATCH] i2c: aspeed: fixed invalid clock parameters for very
 large divisors
Date: Fri, 21 Sep 2018 10:46:34 -0700
Message-ID: <07af0253-1efc-2ae1-93fb-ebcc1996d768@linux.intel.com>
References: <20180920232820.243734-1-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180920232820.243734-1-brendanhiggins@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>, benh@kernel.crashing.org, joel@jms.id.au, andrew@aj.id.au
Cc: linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Brendan,

nit:
Title in imperative mood. I'd put 'fix' instead of 'fixed'.

On 9/20/2018 4:28 PM, Brendan Higgins wrote:
> The function that computes clock parameters from divisors did not
> respect the maximum size of the bitfields that the parameters were
> written to. This fixes the bug.
> 
> This bug can be reproduced with (and this fix verified with) the test
> at: https://kunit-review.googlesource.com/c/linux/+/1035/
> 
> Discovered-by-KUnit: https://kunit-review.googlesource.com/c/linux/+/1035/
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>

[....]

> +	if (base_clk > ASPEED_I2CD_TIME_BASE_DIVISOR_MASK) {
> +		base_clk = ASPEED_I2CD_TIME_BASE_DIVISOR_MASK;
> +		clk_low = clk_high_low_mask;
> +		clk_high = clk_high_low_mask;

Yes, it fixes these parameters to the lowest bus speed setting with the
maximum base clock divisor value and the maximum SCL timing cycle value
when a low bus-frequency is requested which exceeds the range of this
H/W supports. This exceptional case handling is needed to prevent making
invalid settings on it. Nice fix!

One minor issue is, 'base_clk_divisor' instead of 'base_clk' could avoid
misreading on this code.

With that, it looks nice to me. Thanks!

Reviewed-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
