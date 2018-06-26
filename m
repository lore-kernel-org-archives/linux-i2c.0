From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/5] i2c: smbus: add unlocked __i2c_smbus_xfer variant
Date: Tue, 26 Jun 2018 11:37:58 +0900
Message-ID: <20180626023757.l54suaryim2fieq3@ninjato>
References: <20180620085157.30121-1-peda@axentia.se>
 <20180620085157.30121-2-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180620085157.30121-2-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Vadim Pasternak <vadimp@mellanox.com>, Michael Shych <michaelsh@mellanox.com>, Guenter Roeck <linux@roeck-us.net>, Akinobu Mita <akinobu.mita@gmail.com>, Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


> This is not perfectly equivalent, since i2c_smbus_xfer was callable from
> atomic/irq context if you happened to end up emulating SMBus with an I2C
> transfer, and that is no longer the case with this patch. It is unknown
> (to me) if anything depends on that quirk, but it seems fragile enough to
> simply break those cases and require them to call i2c_transfer directly
> instead.

Couldn't we just add the same trylock-code path here as well? I always
wondered why I2C and SMBus were not in sync when it came to that. Yet, I
didn't want to change the code for no reason, but it seems we now have
one?

Rest of the series looks good to me, very nice diffstat!
