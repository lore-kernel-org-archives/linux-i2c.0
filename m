From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH] eeprom: New ee1004 driver for DDR4 memory
Date: Mon, 26 Feb 2018 14:40:42 +0100
Message-ID: <CAMRc=MernxfN-P29HnLUFzAiX-UiFx32ZYZW_v6_BH9dXnfCfw@mail.gmail.com>
References: <20180226102000.1b76640e@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180226102000.1b76640e@endymion>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux I2C <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

2018-02-26 10:20 GMT+01:00 Jean Delvare <jdelvare@suse.de>:
> The EEPROMs which hold the SPD data on DDR4 memory modules are no
> longer standard AT24C02-compatible EEPROMs. They are 512-byte EEPROMs
> which use only 1 I2C address for data access. You need to switch
> between the lower page and the upper page of data by sending commands
> on the SMBus.
>
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> ---
>  drivers/misc/eeprom/Kconfig  |   11 +
>  drivers/misc/eeprom/Makefile |    1
>  drivers/misc/eeprom/ee1004.c |  281 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 293 insertions(+)
>

Hi Jean,

is there any reason not to use regmap as is done currently in at24? It
would spare you a lot of code.

Best regards,
Bartosz Golaszewski
