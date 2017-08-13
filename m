From: Hans de Goede <j.w.r.degoede@gmail.com>
Subject: Re: [PATCH resend v2] i2c-cht-wc: Add Intel Cherry Trail Whiskey Cove
 SMBUS controller driver
Date: Sun, 13 Aug 2017 12:09:31 +0200
Message-ID: <c0f592f8-77b9-7765-8530-ac01ffaffab6@gmail.com>
References: <20170806105943.31470-1-hdegoede@redhat.com>
 <20170806105943.31470-2-hdegoede@redhat.com>
 <20170812120410.he2jkil7clhlybd4@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38168 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbdHMKJe (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 13 Aug 2017 06:09:34 -0400
Received: by mail-wr0-f196.google.com with SMTP id g32so5264774wrd.5
        for <linux-i2c@vger.kernel.org>; Sun, 13 Aug 2017 03:09:34 -0700 (PDT)
In-Reply-To: <20170812120410.he2jkil7clhlybd4@ninjato>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org

Hi,

On 12-08-17 14:04, Wolfram Sang wrote:
> 
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License version
>> + * 2 as published by the Free Software Foundation.
> 
> Here you say V2 only, in MODULE_LICENSE you say V2+.

Good catch, I've added the ", or (at your option) any later version."
text here for v3 of the patch (which was my intention all along).

> ...
> 
>> +static const struct property_entry bq24190_props[] = {
>> +	PROPERTY_ENTRY_STRING("extcon-name", "cht_wcove_pwrsrc"),
>> +	PROPERTY_ENTRY_BOOL("omit-battery-class"),
>> +	PROPERTY_ENTRY_BOOL("disable-reset"),
>> +	{ }
>> +};
>> +
>> +static int cht_wc_i2c_adap_i2c_probe(struct platform_device *pdev)
>> +{
>> +	struct intel_soc_pmic *pmic = dev_get_drvdata(pdev->dev.parent);
>> +	struct cht_wc_i2c_adap *adap;
>> +	struct i2c_board_info board_info = {
>> +		.type = "bq24190",
>> +		.addr = 0x6b,
>> +		.properties = bq24190_props,
>> +	};
> 
> I don't know ACPI world much, but it looks to me like the wrong layer to
> add this stuff? Shouldn't that be in the same place where the
> i2c_adapter is instantiated? Because the place requesting the adapter
> should know what is attached to it?

The adapter is instantiated by the drivers/mfd/intel_cht_wc.c mfd driver
for the i2c attached Intel Cherry Trail Whiskey Cove PMIC (yes this
is an i2c-controller which is itself attached to an i2c bus). The
mfd/intel_cht_wc.c driver does not really know what is attached any
more (or less) then this (i2c-cht-wc) driver. All boards I've seen
using this PMIC combine it with a bq24192i charger and there is no
other info on this in the ACPI tables.

The i2c-cht-wc driver is only used in combination with this PMIC and we
use the presence of the PMIC as indication that there will be a bq24190
attached to the PMIC's child i2c-bus, so from a having access to the
best information to determine what is attached pov, it does not matter
if we instantiate the i2c-client here or in the MFD driver.

 From a practical/implementation pov however it is a lot easier to
implement the i2c-client instantiation in the i2c-cht-wc adapter
driver because that gives us easy access to the i2c_adapter struct
and to the irq for charger-ic-irq-pin on the PMIC. Esp. getting access
to the irq somewhere else is problematic.

Regards,

Hans
