From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: I2c client driver + ACPI on Baytrail & kernel 4.4.2 = ?
Date: Mon, 14 Mar 2016 14:21:16 +0200
Message-ID: <56E6ACBC.6010508@linux.intel.com>
References: <CA+V1LzrWqmx2GH6cs65mS=YHkvx+6wnnq7RpeYChH886pn5fog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:28709 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965059AbcCNMVS (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 14 Mar 2016 08:21:18 -0400
In-Reply-To: <CA+V1LzrWqmx2GH6cs65mS=YHkvx+6wnnq7RpeYChH886pn5fog@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: sergk sergk2mail <sergk.admin@gmail.com>, linux-i2c@vger.kernel.org

Hi

On 03/13/2016 02:43 PM, sergk sergk2mail wrote:
> Hi All,
> Please help to correct create i2c client with ACPI support for device
> (touchscreen) on i2c on vanilla 4.4.2 kernel x86_64 Baytrail,
> disrtibutive = Arch.
> ========================================================
> According kernel Documentation I have created such skeleton:
>
>
> #define DEVICE_NAME  "testme"
>
> static const struct acpi_device_id icn_ts_acpi_match[] = {
>      { "CHPN0001", 0 },
>      { "PNP05C0", 0 },
>      { },
> };

Touchscreen and PNPxxxx: can it be i2c-hid compatible touchscreen?

Those typically have vendor specific ACPI _HID but device is matched 
using ACPI PNP compatible ID (_CID) "PNP0C50" or "ACPI0C50". See 
drivers/hid/i2c-hid/i2c-hid.c.

Just thinking if you have device with _CID "PNP0C50" and either device 
is matched before your driver with i2c-hid driver or your driver doesn't 
probe because "PNP05C0" != "PNP0C50".

> MAIN QUESTIONS:
>
> 1) What is wrong with i2c client driver code? Why it is NOT obtain
> info from ACPI DSD table?
>
Your example looks ok. Another what comes to my mind is the device 
actually present. Sometimes DSDT tables may specify multiple alternative 
devices but only one being actually connected. You could check that by 
reading the device status which reads 15 if the device is present.

cat /sys/bus/acpi/devices/ACPI01234/status
15

> 2) In which way should be created i2c dev while registering i2c acpi
> driver? Who\where\what and how should create this i2c device?
>
i2c-core registers the i2c devices connected to certain bus when adapter 
device for that bus is registered in i2c-core.c: i2c_register_adapter().

-- 
Jarkko
