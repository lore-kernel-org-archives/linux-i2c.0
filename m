From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v4 0/7] Add support for MSCC Ocelot i2c
Date: Thu, 16 Aug 2018 13:58:02 +0300
Message-ID: <7eb26433-9346-db9a-6d76-5c1da8b9baa3@linux.intel.com>
References: <20180816084521.16289-1-alexandre.belloni@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180816084521.16289-1-alexandre.belloni@bootlin.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Wolfram Sang <wsa@the-dreams.de>, James Hogan <jhogan@kernel.org>
Cc: Paul Burton <paul.burton@mips.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Allan Nielsen <allan.nielsen@microsemi.com>
List-Id: linux-i2c@vger.kernel.org

On 08/16/2018 11:45 AM, Alexandre Belloni wrote:
> Hello,
> 
> Because the designware IP was not able to handle the SDA hold time before
> version 1.11a, MSCC has its own implementation. Add support for it and then add
> i2c on ocelot boards.
> 
> I would expect patches 1 to 5 to go through the i2c tree and 6-7 through
> the mips tree once patch 4 has been reviewed by the DT maintainers.
> 
For the patches 1-3 and 5/7 that touch i2c-designware:

Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
