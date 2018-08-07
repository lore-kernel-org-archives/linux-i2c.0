From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v3 0/6] Add support for MSCC Ocelot i2c
Date: Tue, 7 Aug 2018 17:10:11 +0300
Message-ID: <ce7bc15f-5742-8d1b-4b47-2e8b66d3e5c3@linux.intel.com>
References: <20180806185412.7210-1-alexandre.belloni@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180806185412.7210-1-alexandre.belloni@bootlin.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Wolfram Sang <wsa@the-dreams.de>, James Hogan <jhogan@kernel.org>
Cc: Paul Burton <paul.burton@mips.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Allan Nielsen <allan.nielsen@microsemi.com>
List-Id: linux-i2c@vger.kernel.org

On 08/06/2018 09:54 PM, Alexandre Belloni wrote:
> Hello,
> 
> Because the designware IP was not able to handle the SDA hold time before
> version 1.11a, MSCC has its own implementation. Add support for it and then add
> i2c on ocelot boards.
> 
> I would expect patches 1 to 4 to go through the i2c tree and 5-6 through
> the mips tree once patch 4 has been reviewed by the DT maintainers.
> 
For the patches 1-4/6 that touch i2c-designware:

Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

I tested acpi_match_device() conversion to device_get_match_data() 
didn't affect MODEL_CHERRYTRAIL case and quick test that i2c 
communication continue working.
