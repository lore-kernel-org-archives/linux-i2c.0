From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH 1/2] i2c: designware: Add ACPI HID for Hisilicon
 Hip08-Lite I2C controller
Date: Mon, 3 Feb 2020 09:28:19 +0800
Message-ID: <3f8fb782-478e-05a1-4375-862d9a4780bc@huawei.com>
References: <1580643255-38214-1-git-send-email-guohanjun@huawei.com>
 <20200202195204.GV32742@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20200202195204.GV32742@smile.fi.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linuxarm@huawei.com, Sheng Feng <fengsheng5@huawei.com>
List-Id: linux-i2c@vger.kernel.org

On 2020/2/3 3:52, Andy Shevchenko wrote:
> On Sun, Feb 02, 2020 at 07:34:14PM +0800, Hanjun Guo wrote:
>> Add ACPI HID HISI02A3 for Hisilicon Hip08 Lite, which has different
>> clock frequency from Hip08 for I2C controller.
> 
> The series is good for me, but I think you should reverse the order of the
> patches in it.

I will send a updated version as you suggested.

Thanks
Hanjun
