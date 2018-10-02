From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] eeprom: New ee1004 driver for DDR4 memory
Date: Tue, 2 Oct 2018 11:43:46 +0200
Message-ID: <20181002114346.4bcf7927@endymion>
References: <20180226102000.1b76640e@endymion>
        <CAMRc=MernxfN-P29HnLUFzAiX-UiFx32ZYZW_v6_BH9dXnfCfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMRc=MernxfN-P29HnLUFzAiX-UiFx32ZYZW_v6_BH9dXnfCfw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Linux I2C <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 26 Feb 2018 14:40:42 +0100, Bartosz Golaszewski wrote:
> 2018-02-26 10:20 GMT+01:00 Jean Delvare <jdelvare@suse.de>:
> > The EEPROMs which hold the SPD data on DDR4 memory modules are no
> > longer standard AT24C02-compatible EEPROMs. They are 512-byte EEPROMs
> > which use only 1 I2C address for data access. You need to switch
> > between the lower page and the upper page of data by sending commands
> > on the SMBus.
> >
> > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > ---
> >  drivers/misc/eeprom/Kconfig  |   11 +
> >  drivers/misc/eeprom/Makefile |    1
> >  drivers/misc/eeprom/ee1004.c |  281 +++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 293 insertions(+)
> 
> is there any reason not to use regmap as is done currently in at24? It
> would spare you a lot of code.

As it turns out, I don't have the time to look into this. The driver is
not exactly big, it is functional, and I would hate if someone else
would duplicate the work just because my driver is not upstream.

So, Greg, can we just get the driver in the kernel tree as is, and if
anyone really cares about it using regmap, that person will convert the
driver later?

Thanks,
-- 
Jean Delvare
SUSE L3 Support
