From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4] i2c: hibvt: add Hisilicon BVT I2C controller driver
Date: Mon, 3 Oct 2016 13:52:54 -0500
Message-ID: <20161003185254.GA29178@rob-hp-laptop>
References: <1474959063-6126-1-git-send-email-wenpan@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35512 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753350AbcJCSw4 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 3 Oct 2016 14:52:56 -0400
Content-Disposition: inline
In-Reply-To: <1474959063-6126-1-git-send-email-wenpan@hisilicon.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Pan Wen <wenpan@hisilicon.com>
Cc: wsa@the-dreams.de, mark.rutland@arm.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, howell.yang@hisilicon.com, xuejiancheng@hisilicon.com, jalen.hsu@hisilicon.com, lvkuanliang@hisilicon.com, suwenping@hisilicon.com, raojun@hisilicon.com, kevin.lixu@hisilicon.com

On Tue, Sep 27, 2016 at 02:51:03PM +0800, Pan Wen wrote:
> add Hisilicon BVT I2C controller driver support.
> 
> Signed-off-by: Pan Wen <wenpan@hisilicon.com>
> ---
> change log
> v4:
> Modify the default frequency to 100KHz.
> v3:
> Add a SoC specific compatible string.
> v2:
> 1)Fixed a compile error.
> 2)Dropped the clock-names property.
>  .../devicetree/bindings/i2c/i2c-hibvt.txt          |  24 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/i2c/busses/Kconfig                         |  10 +
>  drivers/i2c/busses/Makefile                        |   1 +
>  drivers/i2c/busses/i2c-hibvt.c                     | 737 +++++++++++++++++++++
>  4 files changed, 772 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-hibvt.txt
>  create mode 100644 drivers/i2c/busses/i2c-hibvt.c
