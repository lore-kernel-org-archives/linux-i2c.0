From: =?UTF-8?B?SGVucsO9IMOew7NyIEJhbGR1cnNzb24=?=
        <henry.baldursson@gmail.com>
Subject: Sensor trouble on Lenovo Yoga 910
Date: Fri, 18 Nov 2016 11:15:41 +0000
Message-ID: <CABkmk0WOV-Kc5BSE+ExVQr9oKWtZanF-Azj5+47+pNULLWF1Cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:35390 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752774AbcKRLPn (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 18 Nov 2016 06:15:43 -0500
Received: by mail-it0-f43.google.com with SMTP id c20so21705609itb.0
        for <linux-i2c@vger.kernel.org>; Fri, 18 Nov 2016 03:15:42 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org

Hello

I'm trying to get sensors working on my Lenovo Ideapad Yoga 910.

I'm running kernel 4.8.8. I did try 4.9-rc5 thinking the ISH support
might help, but to no avail.

Here's iio-sensor-proxy trying to read the sensors:

** (process:10981): DEBUG: Found als at
/sys/devices/pci0000:00/0000:00:15.3/i2c_designware.2/i2c-8/i2c-ITE8186:00/0018:048D:8186.0003/HID-SENSOR-200041.3.auto/iio:device0
** (process:10981): DEBUG: Found device
/sys/devices/pci0000:00/0000:00:15.3/i2c_designware.2/i2c-8/i2c-ITE8186:00/0018:048D:8186.0003/HID-SENSOR-200041.3.auto/iio:device0
of type ambient light sensor at IIO Buffer Light sensor
** (process:10981): DEBUG: Found accel_3d at
/sys/devices/pci0000:00/0000:00:15.3/i2c_designware.2/i2c-8/i2c-ITE8186:00/0018:048D:8186.0003/HID-SENSOR-200073.2.auto/iio:device1
** (process:10981): DEBUG: Found device
/sys/devices/pci0000:00/0000:00:15.3/i2c_designware.2/i2c-8/i2c-ITE8186:00/0018:048D:8186.0003/HID-SENSOR-200073.2.auto/iio:device1
of type accelerometer at IIO Buffer accelerometer
** (process:10981): DEBUG: Found associated trigger at
/sys/devices/pci0000:00/0000:00:15.3/i2c_designware.2/i2c-8/i2c-ITE8186:00/0018:048D:8186.0003/HID-SENSOR-200073.2.auto/trigger1
** (process:10981): DEBUG: Got type for in_accel_y: is signed: 1,
bytes: 4, bits_used: 16, shift: 0, mask: 0x65535, be: 0
** (process:10981): DEBUG: Got type for in_accel_x: is signed: 1,
bytes: 4, bits_used: 16, shift: 0, mask: 0x65535, be: 0
** (process:10981): DEBUG: Got type for in_accel_z: is signed: 1,
bytes: 4, bits_used: 16, shift: 0, mask: 0x65535, be: 0
** (process:10981): DEBUG: Built channel array for in_accel_x: index:
0, is signed: 1, bytes: 4, bits_used: 16, shift: 0, mask: 0x65535, be:
0
** (process:10981): DEBUG: Built channel array for in_accel_y: index:
1, is signed: 1, bytes: 4, bits_used: 16, shift: 0, mask: 0x65535, be:
0
** (process:10981): DEBUG: Built channel array for in_accel_z: index:
2, is signed: 1, bytes: 4, bits_used: 16, shift: 0, mask: 0x65535, be:
0
** (process:10981): DEBUG: Found associated trigger at
/sys/devices/pci0000:00/0000:00:15.3/i2c_designware.2/i2c-8/i2c-ITE8186:00/0018:048D:8186.0003/HID-SENSOR-200041.3.auto/trigger0
** (process:10981): DEBUG: Got type for in_intensity_both: is signed:
1, bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:10981): DEBUG: Built channel array for in_intensity_both:
index: 0, is signed: 1, bytes: 4, bits_used: 32, shift: 0, mask: 0x0,
be: 0
** (process:10981): DEBUG: Handling driver refcounting method
'ClaimLight' for ambient light sensor device
** (process:10981): DEBUG: Handling driver refcounting method
'ClaimAccelerometer' for accelerometer device
** (process:10981): DEBUG: No new data available on 'iio:device0'
** (process:10981): DEBUG: No new data available on 'iio:device1'
** (process:10981): DEBUG: No new data available on 'iio:device0'
** (process:10981): DEBUG: No new data available on 'iio:device1'

It basically reads the accelerometer orientation as 'normal' and never
updates it, and the light sensor at 0.0 lux and never updates.

I do get this error during boot:
[    2.321857] i2c_hid i2c-ITE8186:00: error in i2c_hid_init_report
size:19 / ret_size:18

It would be nice to get them working, is there anything I can do? I
have no experience debugging hardware interfaces like these myself,
but I'm usually pretty handy


- Henry.
