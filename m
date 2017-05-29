From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 1/8] i2c: rename core source file to allow refactorization
Date: Mon, 29 May 2017 12:44:28 +0300
Message-ID: <3d19c8c4-339e-f24b-2475-5732be144f71@linux.intel.com>
References: <20170526082101.4746-1-wsa@the-dreams.de>
 <20170526082101.4746-2-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:17434 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750787AbdE2Joc (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 29 May 2017 05:44:32 -0400
In-Reply-To: <20170526082101.4746-2-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.de>, linux-acpi@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

On 05/26/2017 11:20 AM, Wolfram Sang wrote:
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -583,7 +583,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
>  			 */
>
>  			/*
> -			 * i2c-core.c always sets the buffer length of
> +			 * i2c-core always sets the buffer length of
>  			 * I2C_FUNC_SMBUS_BLOCK_DATA to 1. The length will
>  			 * be adjusted when receiving the first byte.
>  			 * Thus we can't stop the transaction here.

FWIW,

Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
