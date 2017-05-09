From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: Regression: bd698d24b1b57: i2c: designware: Get selected speed
 mode sda-hold-time via ACPI
Date: Tue, 09 May 2017 17:54:11 +0300
Message-ID: <1494341651.30052.82.camel@linux.intel.com>
References: <20170509140720.GA21122@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170509140720.GA21122@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, chin.yew.tan@intel.com, mika.westerberg@linux.intel.com, jarkko.nikula@linux.intel.com
Cc: wsa@the-dreams.de, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 2017-05-09 at 15:07 +0100, Lorenzo Pieralisi wrote:
> Hi guys,
> 
> as a heads-up, with today mainline (commit 2868b2513aa7) I get the
> following splat on AMD Seattle, reverting the $SUBJECT commit "solves"
> the problem.
> 
> My I2C knowledge is a bit limited but I am not sure I understand why
> we should be reading eg ss_hcnt/ss_lcnt depending on the dev->clk_freq
> but then i2c_dw_init() _always_ requires those values to be set for
> a given device. Again, I have no insights into I2C inner workings
> so apologies for the silly assumption/question.
> 
> Please have a look into this, thanks.

Since there is no clock defined you got a warning.

It means either ID is not added to drivers/acpi/acpi_apd.c or
platform has wrong values and thus 
dw_i2c_no_acpi_params should be expanded.

I have no such platform, so I can't tell which one is the right fix.
But it's not a revert by my opinion.

> [    1.160597] ------------[ cut here ]------------
> [    1.165207] WARNING: CPU: 0 PID: 1 at drivers/i2c/busses/i2c-
> designware-core.c:293 i2c_dw_clk_rate+0x20/0x30
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
