From: Kachalov Anton <mouse@mayc.ru>
Subject: Re: [PATCH v5 1/2] i2c: aspeed: added driver for Aspeed I2C
Date: Mon, 12 Dec 2016 14:06:28 +0300
Message-ID: <825541481540788@web11j.yandex.ru>
References: <1480467618-7497-1-git-send-email-brendanhiggins@google.com>
         <1480467618-7497-2-git-send-email-brendanhiggins@google.com> <20161211222622.GK2552@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from forward5h.cmail.yandex.net ([87.250.230.20]:35574 "EHLO
        forward5h.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751266AbcLLLMi (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 12 Dec 2016 06:12:38 -0500
In-Reply-To: <20161211222622.GK2552@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Brendan Higgins <brendanhiggins@google.com>
Cc: "vz@mleia.com" <vz@mleia.com>, "clg@kaod.org" <clg@kaod.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "joel@jms.id.au" <joel@jms.id.au>, "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>



12.12.2016, 01:26, "Wolfram Sang" <wsa@the-dreams.de>:
> On Tue, Nov 29, 2016 at 05:00:17PM -0800, Brendan Higgins wrote:
>>  Added initial master and slave support for Aspeed I2C controller.
>>  Supports fourteen busses present in ast24xx and ast25xx BMC SoCs by
>>  Aspeed.
>>
>>  Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>
> BTW first the bindings patch please, then the driver.
>
> And one seperate question I just stumbled over:
>
>>  + /* Switch from master mode to slave mode. */
>>  + func_ctrl_reg_val = aspeed_i2c_read(bus, ASPEED_I2C_FUN_CTRL_REG);
>>  + func_ctrl_reg_val &= ~ASPEED_I2CD_MASTER_EN;
>>  + func_ctrl_reg_val |= ASPEED_I2CD_SLAVE_EN;
>>  + aspeed_i2c_write(bus, func_ctrl_reg_val, ASPEED_I2C_FUN_CTRL_REG);
>
> Can't the hardware work both as master and slave on the same bus?

The hardware can work as master and slave on the same bus. This is how IPMB over i2c works on Aspeed.
