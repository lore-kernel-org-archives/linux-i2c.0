From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH resend v3] i2c: hibvt: add Hisilicon BVT I2C controller
 driver
Date: Fri, 23 Sep 2016 12:49:30 -0500
Message-ID: <20160923174930.GA2208@rob-hp-laptop>
References: <1474284590-12652-1-git-send-email-wenpan@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34221 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030267AbcIWRtc (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 23 Sep 2016 13:49:32 -0400
Content-Disposition: inline
In-Reply-To: <1474284590-12652-1-git-send-email-wenpan@hisilicon.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Pan Wen <wenpan@hisilicon.com>
Cc: wsa@the-dreams.de, mark.rutland@arm.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, howell.yang@hisilicon.com, xuejiancheng@hisilicon.com, jalen.hsu@hisilicon.com, lvkuanliang@hisilicon.com, suwenping@hisilicon.com, raojun@hisilicon.com, kevin.lixu@hisilicon.com

On Mon, Sep 19, 2016 at 07:29:50PM +0800, Pan Wen wrote:
> add Hisilicon BVT I2C controller driver support.
> 
> Signed-off-by: Pan Wen <wenpan@hisilicon.com>
> ---
>  .../devicetree/bindings/i2c/i2c-hibvt.txt          |  24 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/i2c/busses/Kconfig                         |  10 +
>  drivers/i2c/busses/Makefile                        |   1 +
>  drivers/i2c/busses/i2c-hibvt.c                     | 737 +++++++++++++++++++++
>  4 files changed, 772 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-hibvt.txt
>  create mode 100644 drivers/i2c/busses/i2c-hibvt.c
