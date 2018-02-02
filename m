From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH V2] eeprom: at24: support second page of M24M01
Date: Fri, 2 Feb 2018 10:34:29 +0100
Message-ID: <CAMRc=McmD2ZyHxbQAsOJwjaHZkU-cLX-aEBbdZ1zrN=H3heo6g@mail.gmail.com>
References: <20180125134016.GA21654@ppcx2.izt.loc> <CAMRc=MdvhkZaMnR_G8UERdRgDa_8GchrrVUgwEE04aMMHtBOAw@mail.gmail.com>
 <7c3a9b70-a04b-464e-2632-b0d757f780e1@izt-labs.de> <CAMRc=Me8M3P4vKeZgnr0wyqPTnZEyJxUQ0LyqQoyHQyK_gMGLg@mail.gmail.com>
 <20180130141031.36e6x6fb5svtub4i@pp184.izt.loc> <CAMRc=MdiNRmRo7FHM5s-1gAWVE0s9sNQTtKswHVzUg=eC_-deA@mail.gmail.com>
 <20180130165033.cab653gbq7b7gass@pp184.izt.loc>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:46009 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbeBBJea (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 2 Feb 2018 04:34:30 -0500
Received: by mail-oi0-f41.google.com with SMTP id c189so14882294oib.12
        for <linux-i2c@vger.kernel.org>; Fri, 02 Feb 2018 01:34:30 -0800 (PST)
In-Reply-To: <20180130165033.cab653gbq7b7gass@pp184.izt.loc>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Johannes Poehlmann <johannes.poehlmann@izt-labs.de>
Cc: linux-i2c <linux-i2c@vger.kernel.org>

2018-01-30 17:50 GMT+01:00 Johannes Poehlmann <johannes.poehlmann@izt-labs.de>:
> The M24M01-D* eeproms are in effect 2 eeproms under 2 I2C addresses:
>
> 1. a standard 1Mbit eeprom (driver model 24c1024 is working)
>
> 2. a 256 Byte "ID page" that is a write lockable page.
>    As the ID page demands 2 byte addresses, the 24c02 driver model
>    can not be used.
>
> I was thinking about not to pollute the name space of chip names
> with a made up name that is not the name of a real chip.
>
> I would propose to name it "24cb02", thus making clear
> that we have a kind of 24c02 but with 2 byte address.
> (The "b" ist meant to say this)

If anything, this is just super confusing.

>
> Signed-off-by: Johannes Poehlmann <Johannes.Poehlmann@izt-labs.de>
> ---
>  drivers/misc/eeprom/at24.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 4d63ac8..debc8e3 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -139,6 +139,7 @@ static const struct i2c_device_id at24_ids[] = {
>         { "24cs01",     AT24_DEVICE_MAGIC(16,
>                                 AT24_FLAG_SERIAL | AT24_FLAG_READONLY) },
>         { "24c02",      AT24_DEVICE_MAGIC(2048 / 8,     0) },
> +       { "24cb02",     AT24_DEVICE_MAGIC(2048 / 8,     AT24_FLAG_ADDR16) },

Please add the device tree support as well.

>         { "24cs02",     AT24_DEVICE_MAGIC(16,
>                                 AT24_FLAG_SERIAL | AT24_FLAG_READONLY) },
>         { "24mac402",   AT24_DEVICE_MAGIC(48 / 8,
> --
> 2.1.4
>

Take a look at what we do with at24cs* and at24mac* models: at24cs32
stands for the serial number block, while for the regular memory area
we use at24c32.

Analogously in your case: the 'regular' memory block of this EEPROM is
compatible with 'atmel,24c1024', so this is the compatible you'll use
to access it. For the write-lockable page, it's OK to use
'atmel,24cm01'.

Best regards,
Bartosz Golaszewski
