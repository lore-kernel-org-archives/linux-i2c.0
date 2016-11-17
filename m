From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [Patch V5 2/2] i2c: imx: add low power i2c bus driver
Date: Fri, 18 Nov 2016 00:36:55 +0200
Message-ID: <9f77af01-440b-2a29-ec3d-092aeb97cc60@mleia.com>
References: <1479370627-26691-1-git-send-email-pandy.gao@nxp.com>
 <1479370627-26691-2-git-send-email-pandy.gao@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:48716 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750776AbcKQWg7 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 17 Nov 2016 17:36:59 -0500
In-Reply-To: <1479370627-26691-2-git-send-email-pandy.gao@nxp.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Gao Pan <pandy.gao@nxp.com>, wsa@the-dreams.de, u.kleine-koenig@pengutronix.de, cmo@melexis.com, robh@kernel.org
Cc: linux-i2c@vger.kernel.org, frank.li@nxp.com, fugang.duan@nxp.com

On 11/17/2016 10:17 AM, Gao Pan wrote:
> This patch adds lpi2c bus driver to support new i.MX products
> which use lpi2c instead of the old imx i2c.
>
> The lpi2c can continue operating in stop mode when an appropriate
> clock is available. It is also designed for low CPU overhead with
> DMA offloading of FIFO register accesses.
>
> Signed-off-by: Gao Pan <pandy.gao@nxp.com>
> Reviewed-by: Fugang Duan <B38611@freescale.com>

 From my point of view the code quality is good enough to be included.

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

--
With best wishes,
Vladimir
