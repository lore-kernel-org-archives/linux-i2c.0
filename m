From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2] i2c: mux: fix up dependencies
Date: Mon, 14 Nov 2016 15:39:54 +0100
Message-ID: <6094de61-8745-fbff-e516-db95392aa142@axentia.se>
References: <1479134057-30653-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0093.outbound.protection.outlook.com ([104.47.2.93]:56951
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932899AbcKNSP3 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 14 Nov 2016 13:15:29 -0500
In-Reply-To: <1479134057-30653-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: stable@vger.kernel.org, Jonathan Cameron <jic23@jic23.retrosnub.co.uk>

On 2016-11-14 15:34, Linus Walleij wrote:
> We get the following build error from UM Linux after adding
> an entry to drivers/iio/gyro/Kconfig that issues "select I2C_MUX":
> 
> ERROR: "devm_ioremap_resource"
>    [drivers/i2c/muxes/i2c-mux-reg.ko] undefined!
> ERROR: "of_address_to_resource"
>    [drivers/i2c/muxes/i2c-mux-reg.ko] undefined!
> 
> It appears that the I2C mux core code depends on HAS_IOMEM
> for historical reasons, while CONFIG_I2C_MUX_REG does *not*
> have a direct dependency on HAS_IOMEM.
> 
> This creates a situation where a allyesconfig or allmodconfig
> for UM Linux will select I2C_MUX, and will implicitly enable
> I2C_MUX_REG as well, and the compilation will fail for the
> register driver.
> 
> Fix this up by making I2C_MUX_REG depend on HAS_IOMEM and
> removing the dependency from I2C_MUX.
> 
> Cc: stable@vger.kernel.org
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Reported-by: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
> Cc: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
> Cc: Peter Rosin <peda@axentia.se>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Peter Rosin <peda@axentia.se>

Thanks!

Cheers,
Peter
