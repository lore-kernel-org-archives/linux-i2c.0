From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH 1/4] eeprom: at24: don't assign the i2c ID table to at24_driver
Date: Wed, 11 Apr 2018 12:09:10 +0200
Message-ID: <CAMRc=Me66c+ySsmU9bePG7KFU1sTH0OHTfoxrxC_z6Txbu3tqQ@mail.gmail.com>
References: <20180410131206.25760-1-brgl@bgdev.pl> <20180410131206.25760-2-brgl@bgdev.pl>
 <390fac56-8656-ebbb-5405-0a44f1773157@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <390fac56-8656-ebbb-5405-0a44f1773157@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Sven Van Asbroeck <svendev@arcx.com>, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

2018-04-11 11:56 GMT+02:00 Peter Rosin <peda@axentia.se>:
> On 2018-04-10 15:12, Bartosz Golaszewski wrote:
>> We switched to using probe_new(), so this is no longer used
>> by i2c core.
>
> It seems to be used in i2c_device_match() ???
>
> This could easily be me not understanding something...
>

Yes, but i2c core no longer uses the id_table field in struct
i2c_driver. We call i2c_device_match() ourselves instead of letting
i2c core do it and pass the driver data to probe().

Hope that helps,
Bartosz
