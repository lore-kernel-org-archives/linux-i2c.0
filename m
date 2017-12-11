From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] eeprom: at24: code shrink
Date: Mon, 11 Dec 2017 09:08:48 +0100
Message-ID: <20171211080848.t34igariuresgsvf@pengutronix.de>
References: <20171210192947.32211-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:55123 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752414AbdLKIIu (ORCPT
        <rfc822;linux-i2c@vger.kernel.ORG>); Mon, 11 Dec 2017 03:08:50 -0500
Content-Disposition: inline
In-Reply-To: <20171210192947.32211-1-brgl@bgdev.pl>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

On Sun, Dec 10, 2017 at 08:29:47PM +0100, Bartosz Golaszewski wrote:
> @@ -625,7 +610,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	at24->offset_adj = at24_get_offset_adj(chip.flags, chip.byte_len);
>  
>  	at24->client[0].client = client;
> -	at24->client[0].regmap = devm_regmap_init_i2c(client, config);
> +	at24->client[0].regmap = devm_regmap_init_i2c(client, &config);
>  	if (IS_ERR(at24->client[0].regmap))
>  		return PTR_ERR(at24->client[0].regmap);
>  

One side effect here that the lockdep name changes from (unhelpful)
"config" to (unhelpful and ugly) "&config". Probably doesn't matter much
...

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
