From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [V1, 2/2] dt-bindings: i2c: Update i2c-brcmstb compatible string
Date: Thu, 17 Dec 2015 15:57:51 -0800
Message-ID: <56734BFF.4000207@gmail.com>
References: <1450298950-5229-1-git-send-email-kdasu.kdev@gmail.com> <1450298950-5229-2-git-send-email-kdasu.kdev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33735 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753991AbbLQX6H (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 17 Dec 2015 18:58:07 -0500
Received: by mail-pa0-f47.google.com with SMTP id ur14so50120453pab.0
        for <linux-i2c@vger.kernel.org>; Thu, 17 Dec 2015 15:58:06 -0800 (PST)
In-Reply-To: <1450298950-5229-2-git-send-email-kdasu.kdev@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Kamal Dasu <kdasu.kdev@gmail.com>, linux-i2c@vger.kernel.org, wsa@the-dreams.de
Cc: f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com

On 16/12/15 12:49, Kamal Dasu wrote:
> Adding compatibility with the DSL and CM SoCs that use
> the "Peripheral" i2c hardware. "brcm,brcmper-i2c" is
> also an allowed string.
> 
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
>  Documentation/devicetree/bindings/i2c/i2c-brcmstb.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-brcmstb.txt b/Documentation/devicetree/bindings/i2c/i2c-brcmstb.txt
> index d6f724e..aeceace 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-brcmstb.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-brcmstb.txt
> @@ -2,7 +2,7 @@ Broadcom stb bsc iic master controller
>  
>  Required properties:
>  
> -- compatible: should be "brcm,brcmstb-i2c"
> +- compatible: should be "brcm,brcmstb-i2c" or "brcm,brcmper-i2c"
>  - clock-frequency: 32-bit decimal value of iic master clock freqency in Hz
>  		   valid values are 375000, 390000, 187500, 200000
>  		   93750, 97500, 46875 and 50000
> 


-- 
Florian
