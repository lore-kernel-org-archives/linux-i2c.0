From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v1] i2c: designware: save the preset value of
 DW_IC_SDA_HOLD
Date: Mon, 29 Aug 2016 09:17:26 +0300
Message-ID: <70696be2-bead-9241-508d-dd1b02181766@linux.intel.com>
References: <1472283570-31471-1-git-send-email-zhuo-hao.lee@intel.com>
 <1472387502.4887.321.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472387502.4887.321.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Zhuo-hao Lee <zhuo-hao.lee@intel.com>, mika.westerberg@linux.intel.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 08/28/2016 03:31 PM, Andy Shevchenko wrote:
> On Sat, 2016-08-27 at 15:39 +0800, Zhuo-hao Lee wrote:
>> There are several ways to set the SDA hold time for i2c controller,
>> including: Device Tree, built-in device properties and ACPI. However,
>> if the SDA hold time is not specified by above method, we should
>> read the value, where it is preset by firmware, and save it to
>> sda_hold_time. This is needed because when i2c controller enters
>> runtime suspend, the DW_IC_SDA_HOLD value will be reset to chipset
>> default value. And during runtime resume, i2c_dw_init will be called
>> to reconfigure i2c controller. If sda_hold_time is zero, the chipset
>> default hold time will be used, that will be too short for some
>> platforms. Therefore, to have a better tolerance, the DW_IC_SDA_HOLD
>> value should be kept by sda_hold_time.
>
> Looks good to me.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
