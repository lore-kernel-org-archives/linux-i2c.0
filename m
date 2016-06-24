From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] i2c: hibvt: add Hisilicon BVT I2C controller driver
Date: Fri, 24 Jun 2016 10:47:24 -0500
Message-ID: <20160624154724.GA8468@rob-hp-laptop>
References: <1466585726-28467-1-git-send-email-wenpan@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36858 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040AbcFXPr0 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 24 Jun 2016 11:47:26 -0400
Content-Disposition: inline
In-Reply-To: <1466585726-28467-1-git-send-email-wenpan@hisilicon.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Pan Wen <wenpan@hisilicon.com>
Cc: wsa@the-dreams.de, mark.rutland@arm.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, howell.yang@hisilicon.com, xuejiancheng@hisilicon.com

On Wed, Jun 22, 2016 at 04:55:26PM +0800, Pan Wen wrote:
> add Hisilicon BVT I2C controller driver support.
> 
> Signed-off-by: Pan Wen <wenpan@hisilicon.com>
> ---
>  .../devicetree/bindings/i2c/i2c-hibvt.txt          |  24 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/i2c/busses/Kconfig                         |  10 +
>  drivers/i2c/busses/Makefile                        |   1 +
>  drivers/i2c/busses/i2c-hibvt.c                     | 736 +++++++++++++++++++++
>  4 files changed, 771 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-hibvt.txt
>  create mode 100644 drivers/i2c/busses/i2c-hibvt.c
