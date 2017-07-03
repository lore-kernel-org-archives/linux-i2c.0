From: Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH v3 2/2] i2c: Add Spreadtrum I2C controller driver
Date: Mon, 3 Jul 2017 17:29:57 +0800
Message-ID: <CAAfSe-uJZFMA4nr8Ah3OKz0Wx9bJOLHXcWK9Ujxx3kSi=PvaLw@mail.gmail.com>
References: <2083c9d6e96a72f9c1324c8a277acfd780a34094.1498472593.git.baolin.wang@spreadtrum.com>
 <6941c6866078fac8fe81d108b573f7408245a0b9.1498472593.git.baolin.wang@spreadtrum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:32829 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753198AbdGCJ36 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 3 Jul 2017 05:29:58 -0400
In-Reply-To: <6941c6866078fac8fe81d108b573f7408245a0b9.1498472593.git.baolin.wang@spreadtrum.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Baolin Wang <baolin.wang@spreadtrum.com>
Cc: wsa@the-dreams.de, Mark Rutland <mark.rutland@arm.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, linux-i2c@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, baolin.wang@linaro.org, =?UTF-8?B?T3Jzb24gWmhhaSAo57+f5LqsKQ==?= <orson.zhai@spreadtrum.com>

Hi Baolin,

On 26 June 2017 at 18:28, Baolin Wang <baolin.wang@spreadtrum.com> wrote:
> This patch adds the I2C controller driver for Spreadtrum SC9860 platform.
>
> Signed-off-by: Baolin Wang <baolin.wang@spreadtrum.com>
> ---
> Changes since v2:
>  - Remove some redundant comments and parens.
>  - Define macros instead of magic number.
>  - Add some comments to explain clock formula.
>  - Change of_clk_get_by_name() to devm_clk_get().
>  - Deal with other frequency.
>  - Change register definiton to low case.
>  - Change is_last_msg to boolean.
>  - Other optimization.
>
> Changes sice v1:
>  - Power on I2C device in probe().
>  - Remove redundant macros and usb __maybe_unused.
>  - Remove redundant 'of_match_ptr'.
>  - Modify return values and check the return value for 'clk_prepare_enable'.
> ---
>  drivers/i2c/busses/Kconfig    |    7 +
>  drivers/i2c/busses/Makefile   |    1 +
>  drivers/i2c/busses/i2c-sprd.c |  683 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 691 insertions(+)
>  create mode 100644 drivers/i2c/busses/i2c-sprd.c
>

[snip]

> diff --git a/drivers/i2c/busses/i2c-sprd.c b/drivers/i2c/busses/i2c-sprd.c
> new file mode 100644
> index 0000000..a070f61
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-sprd.c
> @@ -0,0 +1,683 @@
> +/*
> + * Copyright (C) 2017 Spreadtrum Communications Inc.
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */

According to RobH's comments [1], we're switching to use
SPDX-License-Identifier tag instead, like [2].

[1] http://lkml.iu.edu/hypermail/linux/kernel/1702.2/05122.html
[2] http://elixir.free-electrons.com/linux/v4.12/source/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts#L6


Thanks,
Chunyan
