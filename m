From: "Lee, Zhuo-hao" <zhuo-hao.lee@intel.com>
Subject: RE: [PATCH v1] i2c: designware: save the preset value of
 DW_IC_SDA_HOLD
Date: Wed, 31 Aug 2016 00:24:36 +0000
Message-ID: <12EF70CDEA59BA47AD9EC69F20130B3401F5E72F@PGSMSX103.gar.corp.intel.com>
References: <1472283570-31471-1-git-send-email-zhuo-hao.lee@intel.com>
 <20160830205939.GF3645@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:2912 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751080AbcHaAZE (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 30 Aug 2016 20:25:04 -0400
In-Reply-To: <20160830205939.GF3645@katana>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "jarkko.nikula@linux.intel.com" <jarkko.nikula@linux.intel.com>, "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

>On Sat, Aug 27, 2016 at 03:39:30PM +0800, Zhuo-hao Lee wrote:
>> There are several ways to set the SDA hold time for i2c controller,
>> including: Device Tree, built-in device properties and ACPI. However, 
>> if the SDA hold time is not specified by above method, we should read 
>> the value, where it is preset by firmware, and save it to 
>> sda_hold_time. This is needed because when i2c controller enters 
>> runtime suspend, the DW_IC_SDA_HOLD value will be reset to chipset 
>> default value. And during runtime resume, i2c_dw_init will be called 
>> to reconfigure i2c controller. If sda_hold_time is zero, the chipset 
>> default hold time will be used, that will be too short for some 
>> platforms. Therefore, to have a better tolerance, the DW_IC_SDA_HOLD 
>> value should be kept by sda_hold_time.
>> 
>> Signed-off-by: Zhuo-hao Lee <zhuo-hao.lee@intel.com>

>Looks good. But is it a bugfix? Looks more like for-next material to me, but not sure...
Yes, as least for me, this is a bug.
This is an error handling in case Device Tree, built-in device properties and ACPI were not set 
the SDA hold time. We should use the firmware setting instead of chipset reset value. 
