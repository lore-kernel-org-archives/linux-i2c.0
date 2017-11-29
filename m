From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 2/2] MAINTAINERS: add DT binding docs for AT24
Date: Wed, 29 Nov 2017 17:11:27 +0100
Message-ID: <92312f73-dc63-2b11-6a33-45acc9762548@axentia.se>
References: <20171129090442.2865-1-wsa@the-dreams.de>
 <20171129090442.2865-3-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0113.outbound.protection.outlook.com ([104.47.2.113]:59367
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753210AbdK2QLk (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 29 Nov 2017 11:11:40 -0500
In-Reply-To: <20171129090442.2865-3-wsa@the-dreams.de>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Bartosz Golaszewski <brgl@bgdev.pl>

On 2017-11-29 10:04, Wolfram Sang wrote:
> The driver gaines DT support recently, so we should add the binding docs

s/gaines/gained/

Cheers,
Peter

> in the MAINTAINERS file.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aa71ab52fd76d1..c870f329613d04 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2262,6 +2262,7 @@ AT24 EEPROM DRIVER
>  M:	Bartosz Golaszewski <brgl@bgdev.pl>
>  L:	linux-i2c@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/eeprom/at24.txt
>  F:	drivers/misc/eeprom/at24.c
>  F:	include/linux/platform_data/at24.h
>  
> 
