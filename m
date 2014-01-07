From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v4 3/3] i2c: mv64xxx: Fix bus hang on A0 version of the
 Armada XP SoCs
Date: Wed, 8 Jan 2014 06:17:21 +0800
Message-ID: <20140108061721.20f09871@skate>
References: <1389112504-9931-1-git-send-email-gregory.clement@free-electrons.com>
	<1389112504-9931-4-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1389112504-9931-4-git-send-email-gregory.clement@free-electrons.com>
Sender: stable-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Dear Gregory CLEMENT,

On Tue,  7 Jan 2014 17:35:04 +0100, Gregory CLEMENT wrote:

>  	if (of_device_is_compatible(np, "marvell,mv78230-i2c")) {
> -		drv_data->offload_enabled = true;
>  		drv_data->errata_delay = true;
> +
> +		if (!of_find_property(np, "offload-broken", NULL))
> +			drv_data->offload_enabled = true;
>  	}

I think of_property_read_bool() is more appropriate than
of_find_property() in this situation, because offload-broken is indeed
a boolean property.

Something like:

		drv_data->offload_enable = !of_property_read_bool(np, "offload-broken");

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
