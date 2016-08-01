From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3] i2c: hibvt: add Hisilicon BVT I2C controller driver
Date: Mon, 1 Aug 2016 14:40:37 -0500
Message-ID: <20160801194037.GA7981@rob-hp-laptop>
References: <1470017939-2519-1-git-send-email-wenpan@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36102 "EHLO
	mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754747AbcHAToC (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 1 Aug 2016 15:44:02 -0400
Content-Disposition: inline
In-Reply-To: <1470017939-2519-1-git-send-email-wenpan@hisilicon.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Pan Wen <wenpan@hisilicon.com>
Cc: wsa@the-dreams.de, mark.rutland@arm.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, howell.yang@hisilicon.com, xuejiancheng@hisilicon.com

On Mon, Aug 01, 2016 at 10:18:59AM +0800, Pan Wen wrote:
> add Hisilicon BVT I2C controller driver support.
> 
> Signed-off-by: Pan Wen <wenpan@hisilicon.com>
> ---
> change log
> v3:
> Add a SoC specific compatible string.
> v2:
> 1)Fixed a compile error.
> 2)Dropped the clock-names property.
>  .../devicetree/bindings/i2c/i2c-hibvt.txt          |  24 +

Acked-by: Rob Herring <robh@kernel.org>>

>  drivers/i2c/busses/Kconfig                         |  10 +
>  drivers/i2c/busses/Makefile                        |   1 +
>  drivers/i2c/busses/i2c-hibvt.c                     | 737 +++++++++++++++++++++
>  4 files changed, 772 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-hibvt.txt
>  create mode 100644 drivers/i2c/busses/i2c-hibvt.c
