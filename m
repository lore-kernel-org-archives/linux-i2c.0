From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Subject: Re: [PATCH v2] i2c: mux: fix up dependencies
Date: Mon, 14 Nov 2016 17:13:27 +0000
Message-ID: <969CC1C0-7352-4A0E-BC48-B78CF3FE7004@jic23.retrosnub.co.uk>
References: <1479134057-30653-1-git-send-email-linus.walleij@linaro.org> <6094de61-8745-fbff-e516-db95392aa142@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47401 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933841AbcKNRNi (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 14 Nov 2016 12:13:38 -0500
In-Reply-To: <6094de61-8745-fbff-e516-db95392aa142@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: stable@vger.kernel.org



On 14 November 2016 14:39:54 GMT+00:00, Peter Rosin <peda@axentia.se> wrote:
>On 2016-11-14 15:34, Linus Walleij wrote:
>> We get the following build error from UM Linux after adding
>> an entry to drivers/iio/gyro/Kconfig that issues "select I2C_MUX":
>> 
>> ERROR: "devm_ioremap_resource"
>>    [drivers/i2c/muxes/i2c-mux-reg.ko] undefined!
>> ERROR: "of_address_to_resource"
>>    [drivers/i2c/muxes/i2c-mux-reg.ko] undefined!
>> 
>> It appears that the I2C mux core code depends on HAS_IOMEM
>> for historical reasons, while CONFIG_I2C_MUX_REG does *not*
>> have a direct dependency on HAS_IOMEM.
>> 
>> This creates a situation where a allyesconfig or allmodconfig
>> for UM Linux will select I2C_MUX, and will implicitly enable
>> I2C_MUX_REG as well, and the compilation will fail for the
>> register driver.
>> 
>> Fix this up by making I2C_MUX_REG depend on HAS_IOMEM and
>> removing the dependency from I2C_MUX.
>> 
>> Cc: stable@vger.kernel.org
>> Reported-by: kbuild test robot <fengguang.wu@intel.com>
>> Reported-by: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
>> Cc: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
>> Cc: Peter Rosin <peda@axentia.se>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
>Acked-by: Peter Rosin <peda@axentia.se>
>
>Thanks!
Thanks for sorting this.
Acked-by: Jonathan Cameron <jic23@kernel.org>
>
>Cheers,
>Peter

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
