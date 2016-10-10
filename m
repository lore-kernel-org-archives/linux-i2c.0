From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCHv4] hwmon: Add tc654 driver
Date: Mon, 10 Oct 2016 16:54:42 -0500
Message-ID: <20161010215442.GA22578@rob-hp-laptop>
References: <b8294ac3-7bac-eeb3-8923-ed569a19cab2@roeck-us.net>
 <20161010212633.5436-1-chris.packham@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161010212633.5436-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: linux@roeck-us.net, linux-hwmon@vger.kernel.org, iwamoto@allied-telesis.co.jp, Joshua.Scott@alliedtelesis.co.nz, Kevin Tsai <ktsai@capellamicro.com>, Wolfram Sang <wsa@the-dreams.de>, Mark Rutland <mark.rutland@arm.com>, Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Oct 11, 2016 at 10:26:31AM +1300, Chris Packham wrote:
> Add support for the tc654 and tc655 fan controllers from Microchip.
> 
> http://ww1.microchip.com/downloads/en/DeviceDoc/20001734C.pdf
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> Changes in v4:
> - tab-align values in #defines
> - ensure locking in set_pwm covers updating cached values
> - populate the cached value for the config register in tc654_probe()
> 
> Changes in v3:
> - typofix in documentation
> - add missing value to tc654_pwm_map, re-generate based on datasheet.
> - remove unnecessary hwmon_dev member from struct tc654_data
> - bug fixes in set_fan_min() and show_pwm_mode()
> - miscellaneous style fixes
>  
> Changes in v2:
> - Add Documentation/hwmon/tc654
> - Incorporate most of the review comments from Guenter. Additional error
>   handling is added. Unused/unnecessary code is removed. I decided not
>   to go down the regmap path yet. I may circle back to it when I look at
>   using regmap in the adm9240 driver.
> 
>  .../devicetree/bindings/i2c/trivial-devices.txt    |   2 +

Expect a merge conflict with the IIO tree.

Acked-by: Rob Herring <robh@kernel.org>

>  Documentation/hwmon/tc654                          |  31 ++
>  drivers/hwmon/Kconfig                              |  11 +
>  drivers/hwmon/Makefile                             |   1 +
>  drivers/hwmon/tc654.c                              | 514 +++++++++++++++++++++
>  5 files changed, 559 insertions(+)
>  create mode 100644 Documentation/hwmon/tc654
>  create mode 100644 drivers/hwmon/tc654.c
