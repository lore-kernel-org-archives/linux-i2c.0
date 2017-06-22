From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: algo-bit: add support for I2C_M_STOP
Date: Thu, 22 Jun 2017 11:06:06 +0200
Message-ID: <20170622110606.6ae3aabc@endymion>
References: <20170617171238.19638-1-wsa+renesas@sang-engineering.com>
        <20170619103002.5d502c92@endymion>
        <20170620172810.h2anac45n5u3oova@ninjato>
        <20170621091843.657de813@endymion>
        <20170621143018.GA1571@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170621143018.GA1571@katana>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 21 Jun 2017 16:30:18 +0200, Wolfram Sang wrote:
> Which reminds me: Have you ever seen a 10-bit client device in the wild?
> I wanted to buy one for testing reasons but was not able to locate one.
> I only know a Renesas IP core which has 10-bit slave capability (but no
> driver support for that yet).

I remember wishing I could drop support, asking around, and a few
people replying to me that 10-bit slaves actually exist. But of course
I can't find the discussion thread again.

I can see one driver for a 10-bit address I2C device:
drivers/media/i2c/tw2804.c (device instantiated from
drivers/media/usb/go7007/go7007-usb.c.)

However it seems that in many cases I2C_M_TEN is used directly (instead
of the more correct I2C_CLIENT_TEN.) See for example
drivers/input/touchscreen/atmel_mxt_ts.c,
drivers/input/touchscreen/elants_i2c.c,
drivers/input/touchscreen/mms114.c,
drivers/media/pci/cx23885/cx23885-i2c.c,
drivers/media/pci/cx25821/cx25821-i2c.c, which are clearly talking to
10-bit I2C devices, but without instantiating an i2c_client for them.

I see also commits explicitly adding or fixing 10-bit address support
in various I2C bus drivers, I don't think developers would be doing
that if they didn't need it.

-- 
Jean Delvare
SUSE L3 Support
