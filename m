From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 00/21] eeprom: at24: driver refactoring
Date: Mon, 19 Mar 2018 16:43:35 +0200
Message-ID: <CAHp75VevXq6NwpmvTU_2GzSdLjUQ47RLM__M3jNLBjZ1YoeQHw@mail.gmail.com>
References: <20180319091721.18193-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180319091721.18193-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Mar 19, 2018 at 11:17 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> This series contains what I hope to be a non-controversial refactoring
> of the at24 eeprom driver.
>
> Most changes revolve around at24_probe() which became quite complicated
> and hard to read.
>
> The only functional changes are: disabling the internal locking
> mechanisms of regmap (since we already take care of that in the driver)
> and removing an if checking if byte_len is a power of 2 (as we do
> support models for which it's not true).
>
> All other patches affect readability and code structure.
>
> Tested with a couple models and different both for device tree and
> platform data modes.

Is there any available tree with that series applied?
I would test it on Intel Galileo Gen 2 which has ACPI enumerated AT24
EEPROM attached.

>
> Bartosz Golaszewski (21):
>   eeprom: at24: disable regmap locking
>   eeprom: at24: remove nvmem_config from at24_data
>   eeprom: at24: arrange local variables
>   eeprom: at24: use SPDX identifier instead of GPL boiler-plate
>   eeprom: at24: remove code separators
>   eeprom: at24: drop redundant variable in at24_read()
>   eeprom: at24: drop redundant variable in at24_write()
>   eeprom: at24: make struct initialization uniform in at24_probe()
>   eeprom: at24: don't check if byte_len is a power of 2
>   eeprom: at24: rename at24_get_pdata()
>   eeprom: at24: rename chip to pdata in at24_probe()
>   eeprom: at24: use a helper variable for dev
>   eeprom: at24: readability tweak in at24_probe()
>   eeprom: at24: provide and use at24_base_client_dev()
>   eeprom: at24: switch to using probe_new() from the i2c framework
>   eeprom: at24: move platform data processing into a separate routine
>   eeprom: at24: remove at24_platform_data from at24_data
>   eeprom: at24: refactor at24_probe()
>   eeprom: at24: tweak newlines
>   eeprom: at24: fix a line break
>   eeprom: at24: simplify the i2c functionality checking
>
>  drivers/misc/eeprom/at24.c | 293 ++++++++++++++++++++++++---------------------
>  1 file changed, 156 insertions(+), 137 deletions(-)
>
> --
> 2.16.1
>



-- 
With Best Regards,
Andy Shevchenko
