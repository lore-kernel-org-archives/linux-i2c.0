From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [Patch V3] i2c: imx-lpi2c: add VLLS mode support
Date: Tue, 17 Jan 2017 23:04:50 +0200
Message-ID: <008db20d-9353-4af5-b97c-fa3550f31e20@mleia.com>
References: <1484648455-5454-1-git-send-email-pandy.gao@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:51388 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751166AbdAQVFQ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 17 Jan 2017 16:05:16 -0500
In-Reply-To: <1484648455-5454-1-git-send-email-pandy.gao@nxp.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Gao Pan <pandy.gao@nxp.com>, wsa@the-dreams.de, wsa-dev@sang-engineering.com
Cc: linux-i2c@vger.kernel.org, frank.li@nxp.com

On 01/17/2017 12:20 PM, Gao Pan wrote:
> When system enters VLLS mode, module power is turned off. As a result,
> all registers are reset to HW default value. After exiting VLLS mode,
> registers are still in default mode. As a result, the pinctrl settings
> are incorrect, which will affect the module function.
> 
> The patch recovers the pinctrl setting when exit VLLS mode.
> 
> Signed-off-by: Gao Pan <pandy.gao@nxp.com>
> ---
> V2:
>  -drop "#else branch" and IMX_LPI2C_PM completely
>  -pm = &imx_lpi2c_pm
> 
> V3:
>  -remove unnecessary #ifdef
> 

The change looks good, thank you for updates.

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

--
With best wishes,
Vladimir
