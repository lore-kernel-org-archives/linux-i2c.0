From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: i2c: Convert UniPhier FI2C controller
 to  json-schema
Date: Wed, 26 Feb 2020 10:46:51 -0600
Message-ID: <20200226164651.GA17752@bogus>
References: <20200221025535.30311-1-yamada.masahiro@socionext.com>
 <20200221025535.30311-2-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44405 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgBZQqx (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 26 Feb 2020 11:46:53 -0500
Content-Disposition: inline
In-Reply-To: <20200221025535.30311-2-yamada.masahiro@socionext.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
Cc: devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-i2c@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel@lists.infradead.org

On Fri, 21 Feb 2020 11:55:34 +0900, Masahiro Yamada wrote:
> Convert the UniPhier FIFO-builtin I2C (a.k.a. FIFO) controller binding
> to DT schema format.
> 
> There are two types of I2C controllers used on the UniPhier platform.
> This is the new one with FIFO support, which is used on the Pro4 SoC
> or newer.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  .../bindings/i2c/i2c-uniphier-f.txt           | 25 ----------
>  .../bindings/i2c/socionext,uniphier-fi2c.yaml | 50 +++++++++++++++++++
>  2 files changed, 50 insertions(+), 25 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-uniphier-f.txt
>  create mode 100644 Documentation/devicetree/bindings/i2c/socionext,uniphier-fi2c.yaml
> 

Applied, thanks.

Rob
