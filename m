From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v2] i2c: designware: fixup return handling of wait_for_completion_timeout
Date: Tue, 10 Feb 2015 10:31:01 +0200
Message-ID: <54D9C1C5.4060709@linux.intel.com>
References: <1423555874-19650-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423555874-19650-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Mc Guire <hofrat@osadl.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, Du Wenkai <wenkai.du@intel.com>, Shinya Kuribayashi <skuribay@pobox.com>, Romain Baeriswyl <Romain.Baeriswyl@abilis.com>, Andrew Jackson <Andrew.Jackson@arm.com>, David Box <david.e.box@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 02/10/2015 10:11 AM, Nicholas Mc Guire wrote:
> return type of wait_for_completion_timeout is unsigned long not int, rather
> than introducing a new variable the wait_for_completion_timeout is moved
> into the if condition as the return value is only used to detect timeout.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> ---
>
> v2: Aside from the newly added variable having the wrong type (...) the
>      preferred solution is to simply wrap wait_for_completion_timeout into
>      the condition as the remaining jiffies is actually not used - suggested
>      be Jarkko Nikula <jarkko.nikula@linux.intel.com.
>
> Patch was compile tested with x86_64_defconfig +
> CONFIG_X86_AMD_PLATFORM_DEVICE=y, CONFIG_I2C_DESIGNWARE_PLATFORM=m
> (implies CONFIG_I2C_DESIGNWARE_CORE=y)
>
> Patch is against 3.19.0-rc7 (localversion-next is -next-20150209)
>
>   drivers/i2c/busses/i2c-designware-core.c |    3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
> index 6e25c01..6f19a33 100644
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -656,8 +656,7 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>   	i2c_dw_xfer_init(dev);
>
>   	/* wait for tx to complete */
> -	ret = wait_for_completion_timeout(&dev->cmd_complete, HZ);
> -	if (ret == 0) {
> +	if (!wait_for_completion_timeout(&dev->cmd_complete, HZ)) {
>   		dev_err(dev->dev, "controller timed out\n");
>   		/* i2c_dw_init implicitly disables the adapter */
>   		i2c_dw_init(dev);
>
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
