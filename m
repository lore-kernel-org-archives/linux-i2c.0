From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/5] i2c: designware: factorize setting SDA hold time
Date: Tue, 17 Jul 2018 15:11:50 +0300
Message-ID: <5a1846aa7c03cc889f072d1aab6967ff254b49de.camel@linux.intel.com>
References: <20180717114837.21839-1-alexandre.belloni@bootlin.com>
         <20180717114837.21839-2-alexandre.belloni@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180717114837.21839-2-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, James Hogan <jhogan@kernel.org>
Cc: Paul Burton <paul.burton@mips.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Allan Nielsen <allan.nielsen@microsemi.com>
List-Id: linux-i2c@vger.kernel.org

On Tue, 2018-07-17 at 13:48 +0200, Alexandre Belloni wrote:
> Factorize setting the SDA hold time in a new function
> i2c_dw_set_sda_hold_time() that is used for both master and slave
> mode.
> 
> This conveniently pulls the fix for the spurious warning from commit
> 7a20e707aae2 ("i2c: designware: suppress unneeded SDA hold time
> warnings")
> in slave mode.

Isn't this a duplication of 

commit 1080ee7e28e1cea86310739e5dd4612868768aed
Author: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Date:   Tue Jun 19 14:23:22 2018 +0300

    i2c: designware: Move SDA hold time configuration to common code

?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
