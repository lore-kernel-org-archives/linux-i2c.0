From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] i2c: busses: constify i2c_algorithm structures
Date: Mon, 30 Jan 2017 13:15:54 +0200
Message-ID: <2babe118-e7fa-c579-d00f-16ddcb466b69@linux.intel.com>
References: <1485540377-13686-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:17447 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751408AbdA3LQT (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 30 Jan 2017 06:16:19 -0500
In-Reply-To: <1485540377-13686-1-git-send-email-bhumirks@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bhumika Goyal <bhumirks@gmail.com>, julia.lawall@lip6.fr, ludovic.desroches@atmel.com, wsa@the-dreams.de, sonic.zhang@analog.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, jdelvare@suse.com, patrice.chotard@st.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, adi-buildroot-devel@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com

On 01/27/2017 08:06 PM, Bhumika Goyal wrote:
> Declare i2c_algorithm structures as const as they are only stored in the
> algo field of an i2c_adapter structure. This field is of type const, so
> i2c_algorithm structures having this property can be made const too.
> Done using Coccinelle:
>
...
> diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
> index 6d81c56..a62c14c 100644
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -822,7 +822,7 @@ static u32 i2c_dw_func(struct i2c_adapter *adap)
>  	return dev->functionality;
>  }
>
> -static struct i2c_algorithm i2c_dw_algo = {
> +static const struct i2c_algorithm i2c_dw_algo = {
>  	.master_xfer	= i2c_dw_xfer,
>  	.functionality	= i2c_dw_func,
>  };

Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
