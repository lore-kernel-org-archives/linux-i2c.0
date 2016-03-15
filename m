From: sergk sergk2mail <sergk.admin@gmail.com>
Subject: Re: I2c client driver + ACPI on Baytrail & kernel 4.4.2 = ?
Date: Tue, 15 Mar 2016 22:26:40 +0000
Message-ID: <CA+V1LzqgXpm1nERbXD2MPHFFvsv8skm=-BKLdwYU-uU=RQUaYg@mail.gmail.com>
References: <CA+V1LzrWqmx2GH6cs65mS=YHkvx+6wnnq7RpeYChH886pn5fog@mail.gmail.com>
	<56E6ACBC.6010508@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:34329 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932180AbcCOW0l (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 15 Mar 2016 18:26:41 -0400
Received: by mail-qk0-f174.google.com with SMTP id x1so13621137qkc.1
        for <linux-i2c@vger.kernel.org>; Tue, 15 Mar 2016 15:26:40 -0700 (PDT)
In-Reply-To: <56E6ACBC.6010508@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org

Hi Jarko,
Exploring sysfs shows:

ls -l /sys/bus/acpi/devices/CHPN0001:00
lrwxrwxrwx 1 root root 0 Mar 15 22:08
/sys/bus/acpi/devices/CHPN0001:00 ->
../../../devices/LNXSYSTM:00/LNXSYBUS:00/80860F41:03/CHPN0001:00
root@archiso ~ # cat /sys/bus/acpi/devices/CHPN0001:00/status
0

status is 0 - what does this mean? It is detected via ACPI but not present?
What does "LNXSYBUS:00/80860F41:03"  means?  Does it mean i2c-3, 0x41
?  80860F41:03 == ?

also inside its subfolders I do not see nothing useful:

cat /sys/bus/acpi/devices/CHPN0001:00/adr
0x00000000
root@archiso ~ # cat /sys/bus/acpi/devices/CHPN0001:00/hid
CHPN0001
root@archiso ~ # cat /sys/bus/acpi/devices/CHPN0001:00/modalias
acpi:CHPN0001:PNP0C50:
root@archiso ~ # cat /sys/bus/acpi/devices/CHPN0001:00/path
\_SB_.I2C4.TCS5
root@archiso ~ # cat /sys/bus/acpi/devices/CHPN0001:00/uevent
MODALIAS=acpi:CHPN0001:PNP0C50:
root@archiso ~ # cat /sys/bus/acpi/devices/CHPN0001:00/power/runtime_usage
0
root@archiso ~ # cat /sys/bus/acpi/devices/CHPN0001:00/power/control
auto
root@archiso ~ # cat /sys/bus/acpi/devices/CHPN0001:00/power/runtime_enabled
disabled

So the question is the same - how to obtain via acpi in mentioned
above code i2cbus, bus addr and irq for this touch?

Regards,
                 Serge Kolotylo.

On Mon, Mar 14, 2016 at 12:21 PM, Jarkko Nikula
<jarkko.nikula@linux.intel.com> wrote:
> Hi
>
> On 03/13/2016 02:43 PM, sergk sergk2mail wrote:
>>
>> Hi All,
>> Please help to correct create i2c client with ACPI support for device
>> (touchscreen) on i2c on vanilla 4.4.2 kernel x86_64 Baytrail,
>> disrtibutive = Arch.
>> ========================================================
>> According kernel Documentation I have created such skeleton:
>>
>>
>> #define DEVICE_NAME  "testme"
>>
>> static const struct acpi_device_id icn_ts_acpi_match[] = {
>>      { "CHPN0001", 0 },
>>      { "PNP05C0", 0 },
>>      { },
>> };
>
>
> Touchscreen and PNPxxxx: can it be i2c-hid compatible touchscreen?
>
> Those typically have vendor specific ACPI _HID but device is matched using
> ACPI PNP compatible ID (_CID) "PNP0C50" or "ACPI0C50". See
> drivers/hid/i2c-hid/i2c-hid.c.
>
> Just thinking if you have device with _CID "PNP0C50" and either device is
> matched before your driver with i2c-hid driver or your driver doesn't probe
> because "PNP05C0" != "PNP0C50".
>
>> MAIN QUESTIONS:
>>
>> 1) What is wrong with i2c client driver code? Why it is NOT obtain
>> info from ACPI DSD table?
>>
> Your example looks ok. Another what comes to my mind is the device actually
> present. Sometimes DSDT tables may specify multiple alternative devices but
> only one being actually connected. You could check that by reading the
> device status which reads 15 if the device is present.
>
> cat /sys/bus/acpi/devices/ACPI01234/status
> 15
>
>> 2) In which way should be created i2c dev while registering i2c acpi
>> driver? Who\where\what and how should create this i2c device?
>>
> i2c-core registers the i2c devices connected to certain bus when adapter
> device for that bus is registered in i2c-core.c: i2c_register_adapter().
>
> --
> Jarkko
