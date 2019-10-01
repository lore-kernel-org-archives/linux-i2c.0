From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/2] i2c: pxa: migrate to new i2c_slave APIs
Date: Tue, 1 Oct 2019 19:29:13 +0300
Message-ID: <20191001162913.GR32742@smile.fi.intel.com>
References: <20191001160001.2388-1-alpawi@amazon.com>
 <20191001160001.2388-2-alpawi@amazon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191001160001.2388-2-alpawi@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Williams <alpawi@amazon.com>
Cc: Patrick Williams <patrick@stwcx.xyz>, Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Max Staudt <max@enpas.org>, Juergen Fitschen <jfi@ssv-embedded.de>, Elie Morisse <syniurge@gmail.com>, Ajay Gupta <ajayg@nvidia.com>, Stefan Roese <sr@denx.de>, Florian Fainelli <f.fainelli@gmail.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Baolin Wang <baolin.wang@linaro.org>, Paul Cercueil <paul@crapouillou.net>, Enrico Weigelt <info@metux.net>, Allison Randal <allison@lohutok.net>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org



On Tue, Oct 01, 2019 at 10:59:59AM -0500, Patrick Williams wrote:
> The i2c subsystem was enhanced circa 2015 to support operating as
> an i2c-slave device.  Prior to that, the i2c-pxa driver supported
> an i2c-slave but had its own APIs.  There are no existing in-kernel
> drivers or platforms that utilize the i2c-pxa APIs.
> 
> Migrate the i2c-pxa driver to the general i2c-slave APIs so that
> existing drivers, such as the i2c-slave-eeprom, can be used.
> 
> This has been tested with a Marvell EspressoBin, using i2c-pxa and
> i2c-slave-eeprom, acting as a slave, and a RaspeberryPi 3, using the
> at24 driver, acting as a master.

There are quite a few people in the Cc list. I'm not sure they all are
interested in this. I deliberately dropped few names, sorry, if I was mistaken.

> +		if (isr & ISR_RWM) {
> +			u8 byte = 0;
> +
> +			i2c_slave_event(i2c->slave, I2C_SLAVE_READ_REQUESTED,
> +					&byte);
> +			writel(byte, _IDBR(i2c));
> +		} else {
> +			i2c_slave_event(i2c->slave, I2C_SLAVE_WRITE_REQUESTED,
> +					NULL);
> +		}

Hmm... Perhaps

		u8 byte = 0;

		i2c_slave_event(i2c->slave, I2C_SLAVE_READ_REQUESTED, &byte);
		if (isr & ISR_RWM)
			writel(byte, _IDBR(i2c));

-- 
With Best Regards,
Andy Shevchenko
