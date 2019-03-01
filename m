From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v5 2/2] i2c: designware: Add support for an interface
 clock
Date: Fri, 1 Mar 2019 16:53:07 +0200
Message-ID: <080b8edd-168e-d71a-b4c2-985460a51e53@linux.intel.com>
References: <1551361930-24434-1-git-send-email-gareth.williams.jx@renesas.com>
 <1551361930-24434-3-git-send-email-gareth.williams.jx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551361930-24434-3-git-send-email-gareth.williams.jx@renesas.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Gareth Williams <gareth.williams.jx@renesas.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org
Cc: Phil Edworthy <phil.edworthy@renesas.com>, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 2/28/19 3:52 PM, Gareth Williams wrote:
> From: Phil Edworthy <phil.edworthy@renesas.com>
> 
> The Synopsys I2C Controller has an interface clock, but most SoCs hide
> this away. However, on some SoCs you need to explicitly enable the
> interface clock in order to access the registers. Therefore, add
> support for an optional interface clock.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
> Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> v5:
>   - Updated comments to reference "interface clock" instead of
>     "peripheral clock".
>   - Corrected spelling in commit message, changing "explicity" to
>     "explicitly".
> v4:
>   - Updated comments to reference "peripheral clock"
>     instead of "bus clock".
>   - Added Wolfram's Acked-by
> v3:
>   - busclk renamed to pclk.
>   - Added comment with dw_i2c_dev struct definition describing pclk.
>   - Added enable rollback of first clock if second fails to enable.
> v2:
>   - Use new devm_clk_get_optional() function as it simplifies handling when
>     the optional clock is not present.
> ---
>   drivers/i2c/busses/i2c-designware-common.c  | 18 ++++++++++++++++--
>   drivers/i2c/busses/i2c-designware-core.h    |  2 ++
>   drivers/i2c/busses/i2c-designware-platdrv.c |  5 +++++
>   3 files changed, 23 insertions(+), 2 deletions(-)
> 
Build & boot tested on linux-next that has the required commit
60b8f0ddf1a9 ("clk: Add (devm_)clk_get_optional() functions").

Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
