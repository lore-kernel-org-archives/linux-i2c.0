From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v1 04/40] i2c: altera: Use generic definitions for bus
 frequencies
Date: Tue, 25 Feb 2020 09:30:12 +0200
Message-ID: <71a245ee-a3a4-a90f-4c2d-155b1dd1afde@linux.intel.com>
References: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
 <20200224151530.31713-4-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:54837 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgBYHaQ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 25 Feb 2020 02:30:16 -0500
In-Reply-To: <20200224151530.31713-4-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Thor Thayer <thor.thayer@linux.intel.com>

Hi

On 2/24/20 5:14 PM, Andy Shevchenko wrote:
> Since we have generic definitions for bus frequencies, let's use them.
> 
> Cc: Thor Thayer <thor.thayer@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/i2c/busses/i2c-altera.c | 8 ++++----
>   include/linux/i2c.h             | 1 +
>   2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-altera.c b/drivers/i2c/busses/i2c-altera.c
> index 5255d3755411..1f70bbd6e084 100644
> --- a/drivers/i2c/busses/i2c-altera.c
> +++ b/drivers/i2c/busses/i2c-altera.c
> @@ -142,12 +142,12 @@ static inline void altr_i2c_stop(struct altr_i2c_dev *idev)
>   static void altr_i2c_init(struct altr_i2c_dev *idev)
>   {
>   	u32 divisor = clk_get_rate(idev->i2c_clk) / idev->bus_clk_rate;
> -	u32 clk_mhz = clk_get_rate(idev->i2c_clk) / 1000000;
> +	u32 clk_mhz = clk_get_rate(idev->i2c_clk) / HZ_PER_MHZ;

IMHO these kind of defines don't improve readability in formulas. What 
is HZ_PER_MHZ? You have to go and grep it first in order to be sure. Of 
course it protects against typos like "100000" or "10000000" that are 
difficult to spot at quick look.

Better would be just "1MHz" or even better calc_something_MHz().

-- 
Jarkko
