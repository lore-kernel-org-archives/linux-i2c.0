From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH] eeprom: at24: code shrink
Date: Mon, 11 Dec 2017 10:38:01 +0100
Message-ID: <CAMRc=MdxCgsbwpBah8qDbTaM-Dt2gEqEPizmg7FqHsqsg9AjgQ@mail.gmail.com>
References: <20171210192947.32211-1-brgl@bgdev.pl> <20171211080848.t34igariuresgsvf@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:44334 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752415AbdLKJiC (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 11 Dec 2017 04:38:02 -0500
Received: by mail-oi0-f51.google.com with SMTP id l6so11140775oih.11
        for <linux-i2c@vger.kernel.org>; Mon, 11 Dec 2017 01:38:02 -0800 (PST)
In-Reply-To: <20171211080848.t34igariuresgsvf@pengutronix.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

2017-12-11 9:08 GMT+01:00 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutroni=
x.de>:
> Hello,
>
> On Sun, Dec 10, 2017 at 08:29:47PM +0100, Bartosz Golaszewski wrote:
>> @@ -625,7 +610,7 @@ static int at24_probe(struct i2c_client *client, con=
st struct i2c_device_id *id)
>>       at24->offset_adj =3D at24_get_offset_adj(chip.flags, chip.byte_len=
);
>>
>>       at24->client[0].client =3D client;
>> -     at24->client[0].regmap =3D devm_regmap_init_i2c(client, config);
>> +     at24->client[0].regmap =3D devm_regmap_init_i2c(client, &config);
>>       if (IS_ERR(at24->client[0].regmap))
>>               return PTR_ERR(at24->client[0].regmap);
>>
>
> One side effect here that the lockdep name changes from (unhelpful)
> "config" to (unhelpful and ugly) "&config". Probably doesn't matter much
> ...
>
> Best regards
> Uwe
>

We can always rename the variable to regmap_config or smth, but in
case of a lockdep splat we'll see the stack trace anyway.

Thanks,
Bartosz
