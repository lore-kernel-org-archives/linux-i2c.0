From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH/RFC 1/3] dt-bindings: i2c: i2c-gpio: Add support for
 named gpios
Date: Thu, 31 Aug 2017 12:55:29 -0500
Message-ID: <20170831175529.vuchpgvi2aigz2r5@rob-hp-laptop>
References: <1503566474-5335-1-git-send-email-geert+renesas@glider.be>
 <1503566474-5335-2-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:37991 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbdHaRzb (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 31 Aug 2017 13:55:31 -0400
Content-Disposition: inline
In-Reply-To: <1503566474-5335-2-git-send-email-geert+renesas@glider.be>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Wolfram Sang <wsa@the-dreams.de>, Mark Rutland <mark.rutland@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org

On Thu, Aug 24, 2017 at 11:21:12AM +0200, Geert Uytterhoeven wrote:
> The current i2c-gpio DT bindings use a single unnamed "gpios" property
> to refer to the SDA and SCL signal lines by index.  This is error-prone
> for the casual DT writer and reviewer, as one has to look up the order
> in the DT bindings.
> 
> Fix this by amending the DT bindings to use two separate named gpios
> properties, and deprecate the old unnamed variant.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-gpio.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-gpio.txt b/Documentation/devicetree/bindings/i2c/i2c-gpio.txt
> index 4f8ec947c6bd9cad..61033f73577dd70e 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-gpio.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-gpio.txt
> @@ -2,8 +2,9 @@ Device-Tree bindings for i2c gpio driver
>  
>  Required properties:
>  	- compatible = "i2c-gpio";
> -	- gpios: sda and scl gpio
> -
> +	- sda-gpios: gpio used for the sda signal
> +	- scl-gpios: gpio used for the scl signal
> +	- gpios: sda and scl gpio, alternative for {sda,scl}-gpios (deprecated)
>  
>  Optional properties:
>  	- i2c-gpio,sda-open-drain: sda as open drain

Well, if we're going to change things, we should drop these open-drain 
properties. We have open-drain flags in gpio cells, so we don't need 
these I think.

Rob
