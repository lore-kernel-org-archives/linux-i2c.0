From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v2] dts: keystone: Use new "ti,keystone-i2c" compatible
Date: Wed, 21 Oct 2015 13:38:54 +0300
Message-ID: <56276B3E.3020208@ti.com>
References: <55F68E36.2030609@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56519 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752016AbbJUKjQ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 21 Oct 2015 06:39:16 -0400
In-Reply-To: <55F68E36.2030609@nokia.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Alexander Sverdlin <alexander.sverdlin@nokia.com>, Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Sekhar Nori <nsekhar@ti.com>

On 09/14/2015 12:07 PM, Alexander Sverdlin wrote:
> Now as "i2c-davinci" driver has special handling for Keystone it's time to switch
> the device tree to use new "compatible" property. Old one is left for backwards-
> compatibility.
>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> ---

To: Santosh
Cc: Murali, Sekhar

Seems this patch is Keystone 2 specific.

>
> Changes in v2:
> - As suggested by Mark Rutland, kept the old "compatible" for backwards-
>    compatibility
>
>   arch/arm/boot/dts/keystone.dtsi |    6 +++---
>   1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
> index 72816d6..abd7455 100644
> --- a/arch/arm/boot/dts/keystone.dtsi
> +++ b/arch/arm/boot/dts/keystone.dtsi
> @@ -106,7 +106,7 @@
>   		};
>
>   		i2c0: i2c@2530000 {
> -			compatible = "ti,davinci-i2c";
> +			compatible = "ti,keystone-i2c", "ti,davinci-i2c";
>   			reg = <0x02530000 0x400>;
>   			clock-frequency = <100000>;
>   			clocks = <&clki2c>;
> @@ -116,7 +116,7 @@
>   		};
>
>   		i2c1: i2c@2530400 {
> -			compatible = "ti,davinci-i2c";
> +			compatible = "ti,keystone-i2c", "ti,davinci-i2c";
>   			reg = <0x02530400 0x400>;
>   			clock-frequency = <100000>;
>   			clocks = <&clki2c>;
> @@ -126,7 +126,7 @@
>   		};
>
>   		i2c2: i2c@2530800 {
> -			compatible = "ti,davinci-i2c";
> +			compatible = "ti,keystone-i2c", "ti,davinci-i2c";
>   			reg = <0x02530800 0x400>;
>   			clock-frequency = <100000>;
>   			clocks = <&clki2c>;
>


-- 
regards,
-grygorii
