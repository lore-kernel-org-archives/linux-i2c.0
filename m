From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: Fix unused variable warning in
 i2c_dw_init_recovery_info
Date: Tue, 6 Aug 2019 11:36:21 +0300
Message-ID: <2ddc2077-aefb-2330-3096-7473dc55f19c@linux.intel.com>
References: <20190806075054.GA15418@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190806075054.GA15418@embeddedor>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi

On 8/6/19 10:50 AM, Gustavo A. R. Silva wrote:
> Fix the following warning:
> 
> drivers/i2c/busses/i2c-designware-master.c: In function ‘i2c_dw_init_recovery_info’:
> drivers/i2c/busses/i2c-designware-master.c:658:6: warning: unused variable ‘r’ [-Wunused-variable]
>    int r;
>        ^
> 
> Fixes: 33eb09a02e8d ("i2c: designware: make use of devm_gpiod_get_optional")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
This was fixed yesterday, not applied yet though:

https://www.spinics.net/lists/linux-i2c/msg41651.html

-- 
Jarkko
