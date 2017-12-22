From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] i2c: gpio: Enable working over slow can_sleep GPIOs
Date: Fri, 22 Dec 2017 23:22:51 +0100
Message-ID: <20171222222251.d7gfgv44fgrykxaf@pengutronix.de>
References: <f105ae7f6b9ae9f5a26ecdac8d71c55dfedfe688.1513979394.git.jan.kundrat@cesnet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:44023 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755934AbdLVWWy (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 22 Dec 2017 17:22:54 -0500
Content-Disposition: inline
In-Reply-To: <f105ae7f6b9ae9f5a26ecdac8d71c55dfedfe688.1513979394.git.jan.kundrat@cesnet.cz>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>
Cc: linux-i2c@vger.kernel.org, Haavard Skinnemoen <hskinnemoen@gmail.com>, Ben Dooks <ben.dooks@codethink.co.uk>, Wolfram Sang <wsa@the-dreams.de>

On Fri, Dec 22, 2017 at 10:47:16PM +0100, Jan Kundrát wrote:
> "Slow" GPIOs (usually those connected over an SPI or an I2C bus) are,
> well, slow in their operation. It is generally a good idea to avoid
> using them for time-critical operation, but sometimes the hardware just
> sucks, and the software has to cope. In addition to that, the I2C bus
> itself does not actually define any strict timing limits; the bus is
> free to go all the way down to DC. The timeouts (and therefore the
> slowest acceptable frequency) are present only in SMBus.
> 
> The `can_sleep` is IMHO a wrong concept to use here. My SPI-to-quad-UART
> chip (MAX14830) is connected via a 26MHz SPI bus, and it happily drives
> SCL at 200kHz (5µs pulses) during my benchmarks. That's faster than the
> maximal allowed speed of the traditional I2C.
> 
> The previous version of this code did not really block operation over
> slow GPIO pins, anyway. Instead, it just resorted to printing a warning
> with a backtrace each time a GPIO pin was accessed, thereby slowing
> things down even more.
> 
> Finally, it's not just me. A similar patch was originally submitted in
> 2015 [1].
> 
> [1] https://patchwork.ozlabs.org/patch/450956/
> 
> Signed-off-by: Jan Kundrát <jan.kundrat@cesnet.cz>

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
