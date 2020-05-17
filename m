Return-Path: <SRS0=p7YK=67=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28442C433DF
	for <linux-i2c@archiver.kernel.org>; Sun, 17 May 2020 16:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 014A820835
	for <linux-i2c@archiver.kernel.org>; Sun, 17 May 2020 16:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgEQQKa (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Sun, 17 May 2020 12:10:30 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:50663 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbgEQQKa (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 17 May 2020 12:10:30 -0400
X-Originating-IP: 91.175.115.186
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id CAC9440005;
        Sun, 17 May 2020 16:10:27 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Russell King <rmk+kernel@armlinux.org.uk>,
        linux-i2c@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>
Subject: Re: [PATCH 2/2] arm64: dts: add uDPU i2c bus recovery
In-Reply-To: <E1jWGXd-0000Z7-1n@rmk-PC.armlinux.org.uk>
References: <20200506094001.GP1551@shell.armlinux.org.uk> <E1jWGXd-0000Z7-1n@rmk-PC.armlinux.org.uk>
Date:   Sun, 17 May 2020 18:10:27 +0200
Message-ID: <87eerih79o.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Hi Russell,

> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Applied on mvebu/dt64

Thanks,

Gregory


> ---
>  .../boot/dts/marvell/armada-3720-uDPU.dts     | 22 +++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
> index 7eb6c1796cef..95d46e8d081c 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
> @@ -117,18 +117,36 @@
>  	};
>  };
>  
> +&pinctrl_nb {
> +	i2c1_recovery_pins: i2c1-recovery-pins {
> +		groups = "i2c1";
> +		function = "gpio";
> +	};
> +
> +	i2c2_recovery_pins: i2c2-recovery-pins {
> +		groups = "i2c2";
> +		function = "gpio";
> +	};
> +};
> +
>  &i2c0 {
>  	status = "okay";
> -	pinctrl-names = "default";
> +	pinctrl-names = "default", "recovery";
>  	pinctrl-0 = <&i2c1_pins>;
> +	pinctrl-1 = <&i2c1_recovery_pins>;
>  	/delete-property/mrvl,i2c-fast-mode;
> +	scl-gpios = <&gpionb 0 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	sda-gpios = <&gpionb 1 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  };
>  
>  &i2c1 {
>  	status = "okay";
> -	pinctrl-names = "default";
> +	pinctrl-names = "default", "recovery";
>  	pinctrl-0 = <&i2c2_pins>;
> +	pinctrl-1 = <&i2c2_recovery_pins>;
>  	/delete-property/mrvl,i2c-fast-mode;
> +	scl-gpios = <&gpionb 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	sda-gpios = <&gpionb 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  
>  	lm75@48 {
>  		status = "okay";
> -- 
> 2.20.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
