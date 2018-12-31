From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 3/3] i2c: at91: added slave mode support
Date: Mon, 31 Dec 2018 12:53:48 +0200
Message-ID: <20181231105348.GV10650@smile.fi.intel.com>
References: <20181227151311.20107-1-ludovic.desroches@microchip.com>
 <20181227151311.20107-4-ludovic.desroches@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181227151311.20107-4-ludovic.desroches@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, me@jue.yt, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org, wsa@the-dreams.de, Juergen Fitschen <jfi@ssv-embedded.de>
List-Id: linux-i2c@vger.kernel.org

> Slave mode driver is based on the concept of i2c-designware driver.

> +/*
> + *  i2c slave support for Atmel's AT91 Two-Wire Interface (TWI)
> + *
> + *  Copyright (C) 2017 Juergen Fitschen <me@jue.yt>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + */

Perhaps, you can use SPDX instead of boiler plate license text in the files?

-- 
With Best Regards,
Andy Shevchenko
