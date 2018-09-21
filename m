From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: Re: [PATCH v2] i2c: aspeed: fix invalid clock parameters for very
 large divisors
Date: Fri, 21 Sep 2018 15:26:13 -0700
Message-ID: <f5943177-6f1b-9344-3821-2aac001ff45d@linux.intel.com>
References: <20180921221025.75003-1-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180921221025.75003-1-brendanhiggins@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>, benh@kernel.crashing.org, joel@jms.id.au, andrew@aj.id.au
Cc: openbmc@lists.ozlabs.org, linux-i2c@vger.kernel.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 9/21/2018 3:10 PM, Brendan Higgins wrote:
> The function that computes clock parameters from divisors did not
> respect the maximum size of the bitfields that the parameters were
> written to. This fixes the bug.
> 
> This bug can be reproduced with (and this fix verified with) the test
> at: https://kunit-review.googlesource.com/c/linux/+/1035/
> 
> Discovered-by-KUnit: https://kunit-review.googlesource.com/c/linux/+/1035/
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
>   - v2 updates the title of the patch, renames a local variable, and
>     prints an error when the clock divider is clamped.
> ---

[....]

> +	if (base_clk_divisor > ASPEED_I2CD_TIME_BASE_DIVISOR_MASK) {
> +		base_clk_divisor = ASPEED_I2CD_TIME_BASE_DIVISOR_MASK;
> +		clk_low = clk_high_low_mask;
> +		clk_high = clk_high_low_mask;
> +		dev_err(dev,
> +			"clamping clock divider: divider requested, %u, is greater than largest possible divider, %u.",

Please put a newline character at the end of the string.

Thanks,
Jae

[....]
