From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2 0/3] eeprom: at24: last bits of the big refactoring
Date: Thu, 12 Apr 2018 17:08:58 +0200
Message-ID: <fe2654fb-8c46-0a29-541a-71850c01b64b@axentia.se>
References: <20180411143828.1046-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180411143828.1046-1-brgl@bgdev.pl>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sven Van Asbroeck <svendev@arcx.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 2018-04-11 16:38, Bartosz Golaszewski wrote:
> This is a follow-up to the big series merged for 4.17. The patches
> contain some bits and pieces that were missing in the last submission
> or depend on some new features merged this merge window.
> 
> v1 -> v2:
> - dropped patch 1/4 because id_table is still needed as pointed out by
>   Peter Rosin
> - fixed patch 3/3: we need to free the dummy client if regmap_init fails
> 
> Bartosz Golaszewski (3):
>   eeprom: at24: use devm_nvmem_register()
>   eeprom: at24: provide and use a helper for releasing dummy i2c clients
>   eeprom: at24: provide a separate routine for creating dummy i2c
>     clients

For all three:

Reviewed-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter
