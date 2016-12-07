From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [Patch V1] i2c: fsl-lpi2c: read lpi2c fifo size in probe()
Date: Wed, 7 Dec 2016 03:01:20 +0200
Message-ID: <c7263019-05be-946a-986a-dd138a0b6aec@mleia.com>
References: <1480649896-5222-1-git-send-email-pandy.gao@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:48794 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751527AbcLGBBX (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 6 Dec 2016 20:01:23 -0500
In-Reply-To: <1480649896-5222-1-git-send-email-pandy.gao@nxp.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Gao Pan <pandy.gao@nxp.com>, wsa@the-dreams.de, wsa-dev@sang-engineering.com, cmo@melexis.com, robh@kernel.org
Cc: linux-i2c@vger.kernel.org, frank.li@nxp.com, fugang.duan@nxp.com

On 12/02/2016 05:38 AM, Gao Pan wrote:
> The lpi2c fifo size is a read only parameter resides Parameter
> Register. It's better to read lpi2c tx/rx fifo size in probe()
> other than just define a macro for it.
> 
> Signed-off-by: Gao Pan <pandy.gao@nxp.com>
> ---

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

--
With best wishes,
Vladimir
