From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] eeprom: New ee1004 driver for DDR4 memory
Date: Mon, 26 Feb 2018 15:26:20 +0100
Message-ID: <20180226152620.6740b458@endymion>
References: <20180226102000.1b76640e@endymion>
        <CAMRc=MernxfN-P29HnLUFzAiX-UiFx32ZYZW_v6_BH9dXnfCfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMRc=MernxfN-P29HnLUFzAiX-UiFx32ZYZW_v6_BH9dXnfCfw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux I2C <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Bartosz,

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

No specific reason, just the fact that I never used regmap before so
the idea did not occur to me. I can give it a try, but my driver is
already pretty simple so I'm curious if there's really anything to win.
Let's see.

Is there any documentation available on how to convert an existing
driver to use regmap?

-- 
Jean Delvare
SUSE L3 Support
