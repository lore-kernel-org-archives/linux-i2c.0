From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v1] I2C Designware Core Supports SMBUS BLOCK
Date: Tue, 25 Oct 2016 10:58:16 +0300
Message-ID: <48a57d6a-f70f-8dbf-1192-e936f8dda4b0@linux.intel.com>
References: <1477370113-15145-1-git-send-email-tnhuynh@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:52111 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751194AbcJYH6V (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 25 Oct 2016 03:58:21 -0400
In-Reply-To: <1477370113-15145-1-git-send-email-tnhuynh@apm.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: tnhuynh@apm.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Loc Ho <lho@apm.com>, Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>, patches@apm.com

Hi

On 10/25/2016 07:35 AM, tnhuynh@apm.com wrote:
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -220,6 +220,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
>  		I2C_FUNC_SMBUS_BYTE |
>  		I2C_FUNC_SMBUS_BYTE_DATA |
>  		I2C_FUNC_SMBUS_WORD_DATA |
> +		I2C_FUNC_SMBUS_BLOCK_DATA |
>  		I2C_FUNC_SMBUS_I2C_BLOCK;
>
I guess you need to add the same to DW_DEFAULT_FUNCTIONALITY in 
drivers/i2c/busses/i2c-designware-pcidrv.c too.

-- 
Jarkko
