From: =?UTF-8?B?SGVucsO9IMOew7NyIEJhbGR1cnNzb24=?=
        <henry.baldursson@gmail.com>
Subject: Re: Sensor trouble on Lenovo Yoga 910
Date: Fri, 18 Nov 2016 11:25:39 +0000
Message-ID: <CABkmk0XCFLgcDYJvhNrNwv2vrNiMxmfTHSJ1GddjB1UjkjFTRw@mail.gmail.com>
References: <CABkmk0WOV-Kc5BSE+ExVQr9oKWtZanF-Azj5+47+pNULLWF1Cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:37025 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753037AbcKRLZl (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 18 Nov 2016 06:25:41 -0500
Received: by mail-it0-f49.google.com with SMTP id y23so25910458itc.0
        for <linux-i2c@vger.kernel.org>; Fri, 18 Nov 2016 03:25:41 -0800 (PST)
In-Reply-To: <CABkmk0WOV-Kc5BSE+ExVQr9oKWtZanF-Azj5+47+pNULLWF1Cw@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org

I loaded the i2c-hid module with the debug parameter, which I only
figured out after sending the initial email (duh):

[16455.340845] i2c_hid i2c-SYNA7813:00: Fetching the HID descriptor
[16455.340853] i2c_hid i2c-SYNA7813:00: __i2c_hid_command: cmd=3D20 00
[16455.341748] i2c_hid i2c-SYNA7813:00: HID Descriptor: 1e 00 00 01 e1
01 21 00 24 00 24 00 25 00 17 00 22 00 23 00 cb 06 85 17 02 00 00 00
00 00
[16455.341931] i2c_hid i2c-SYNA7813:00: entering i2c_hid_parse
[16455.341935] i2c_hid i2c-SYNA7813:00: i2c_hid_hwreset
[16455.341937] i2c_hid i2c-SYNA7813:00: i2c_hid_set_power
[16455.341941] i2c_hid i2c-SYNA7813:00: __i2c_hid_command: cmd=3D22 00 00 0=
8
[16455.342115] i2c_hid i2c-SYNA7813:00: resetting...
[16455.342118] i2c_hid i2c-SYNA7813:00: __i2c_hid_command: cmd=3D22 00 00 0=
1
[16455.342311] i2c_hid i2c-SYNA7813:00: __i2c_hid_command: waiting...
[16455.343375] i2c_hid i2c-SYNA7813:00: __i2c_hid_command: finished.
[16455.343381] i2c_hid i2c-SYNA7813:00: asking HID report descriptor
[16455.343385] i2c_hid i2c-SYNA7813:00: __i2c_hid_command: cmd=3D21 00
[16455.355087] i2c_hid i2c-SYNA7813:00: Report Descriptor: 05 0d 09 04
a1 01 85 01 09 22 a1 02 09 42 15 00 25 01 75 01 95 01 81 02 95 07 81
03 75 08 09 51 25 7f 95 01 81 02 05 01 55 0e 65 11 26 28 0c 35 00 46
12 0c 75 10 95 01 09 30 81 02 26 e6 06 46
[16455.356344] i2c_hid i2c-SYNA7813:00: i2c_hid_get_report
[16455.356347] i2c_hid i2c-SYNA7813:00: __i2c_hid_command: cmd=3D22 00 38 0=
2 23 00
[16455.356718] i2c_hid i2c-SYNA7813:00: i2c_hid_get_report
[16455.356720] i2c_hid i2c-SYNA7813:00: __i2c_hid_command: cmd=3D22 00 37 0=
2 23 00
[16455.363366] input: SYNA7813:00 06CB:1785 as
/devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-6/i2c-SYNA7813:00/001=
8:06CB:1785.0004/input/input16
[16455.363652] hid-multitouch 0018:06CB:1785.0004: input,hidraw0: I2C
HID v1.00 Device [SYNA7813:00 06CB:1785] on i2c-SYNA7813:00
[16455.363733] i2c_hid i2c-SYNA7813:00: i2c_hid_set_power
[16455.363738] i2c_hid i2c-SYNA7813:00: __i2c_hid_command: cmd=3D22 00 01 0=
8
[16455.368587] i2c_hid i2c-SYNA7813:00: i2c_hid_set_power
[16455.368592] i2c_hid i2c-SYNA7813:00: __i2c_hid_command: cmd=3D22 00 00 0=
8
[16455.390670] i2c_hid i2c-SYNA7813:00: i2c_hid_set_power
[16455.390675] i2c_hid i2c-SYNA7813:00: __i2c_hid_command: cmd=3D22 00 01 0=
8
[16455.415842] i2c_hid i2c-SYNA7813:00: i2c_hid_set_power
[16455.415850] i2c_hid i2c-SYNA7813:00: __i2c_hid_command: cmd=3D22 00 00 0=
8
[16455.447439] i2c_hid i2c-SYNA7813:00: i2c_hid_set_power
[16455.447445] i2c_hid i2c-SYNA7813:00: __i2c_hid_command: cmd=3D22 00 01 0=
8
[16455.471032] i2c_hid i2c-SYNA2B31:00: Fetching the HID descriptor
[16455.471039] i2c_hid i2c-SYNA2B31:00: __i2c_hid_command: cmd=3D20 00
[16455.471945] i2c_hid i2c-SYNA2B31:00: HID Descriptor: 1e 00 00 01 99
02 21 00 24 00 40 00 25 00 17 00 22 00 23 00 cb 06 8c 7f 03 00 00 00
00 00
[16455.472146] i2c_hid i2c-SYNA2B31:00: entering i2c_hid_parse
[16455.472150] i2c_hid i2c-SYNA2B31:00: i2c_hid_hwreset
[16455.472153] i2c_hid i2c-SYNA2B31:00: i2c_hid_set_power
[16455.472157] i2c_hid i2c-SYNA2B31:00: __i2c_hid_command: cmd=3D22 00 00 0=
8
[16455.473792] i2c_hid i2c-SYNA2B31:00: input: 20 00 03 03 54 01 5f 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 e1 a4 01
00
[16455.474049] i2c_hid i2c-SYNA2B31:00: resetting...
[16455.474056] i2c_hid i2c-SYNA2B31:00: __i2c_hid_command: cmd=3D22 00 00 0=
1
[16455.475716] i2c_hid i2c-SYNA2B31:00: input: 20 00 03 00 80 00 5c 01
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 6f 33 01
00
[16455.475962] i2c_hid i2c-SYNA2B31:00: __i2c_hid_command: waiting...
[16455.477639] i2c_hid i2c-SYNA2B31:00: __i2c_hid_command: finished.
[16455.477645] i2c_hid i2c-SYNA2B31:00: asking HID report descriptor
[16455.477648] i2c_hid i2c-SYNA2B31:00: __i2c_hid_command: cmd=3D21 00
[16455.488898] i2c_hid i2c-SYNA7813:00: i2c_hid_set_power
[16455.488904] i2c_hid i2c-SYNA7813:00: __i2c_hid_command: cmd=3D22 00 00 0=
8
[16455.494888] i2c_hid i2c-SYNA2B31:00: Report Descriptor: 05 01 09 02
a1 01 85 02 09 01 a1 00 05 09 19 01 29 02 15 00 25 01 75 01 95 02 81
02 95 06 81 01 05 01 09 30 09 31 15 81 25 7f 75 08 95 02 81 06 c0 c0
05 0d 09 05 a1 01 85 03 05 0d 09 22 a1 02
[16455.496966] i2c_hid i2c-SYNA2B31:00: i2c_hid_get_report
[16455.496971] i2c_hid i2c-SYNA2B31:00: __i2c_hid_command: cmd=3D22 00 38 0=
2 23 00
[16455.498592] i2c_hid i2c-SYNA2B31:00: i2c_hid_get_report
[16455.498598] i2c_hid i2c-SYNA2B31:00: __i2c_hid_command: cmd=3D22 00 38 0=
2 23 00
[16455.498957] i2c_hid i2c-SYNA2B31:00: i2c_hid_get_report
[16455.498962] i2c_hid i2c-SYNA2B31:00: __i2c_hid_command: cmd=3D22 00 37 0=
2 23 00
[16455.505779] input: SYNA2B31:00 06CB:7F8C Touchpad as
/devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-7/i2c-SYNA2B31:00/001=
8:06CB:7F8C.0005/input/input18
[16455.506207] hid-multitouch 0018:06CB:7F8C.0005: input,hidraw1: I2C
HID v1.00 Mouse [SYNA2B31:00 06CB:7F8C] on i2c-SYNA2B31:00
[16455.506218] i2c_hid i2c-SYNA2B31:00: i2c_hid_set_or_send_report
[16455.506223] i2c_hid i2c-SYNA2B31:00: __i2c_hid_command: cmd=3D22 00
34 03 23 00 04 00 04 03
[16455.510689] i2c_hid i2c-SYNA2B31:00: i2c_hid_set_power
[16455.510692] i2c_hid i2c-SYNA2B31:00: __i2c_hid_command: cmd=3D22 00 01 0=
8
[16455.512663] i2c_hid i2c-SYNA2B31:00: i2c_hid_set_power
[16455.512666] i2c_hid i2c-SYNA2B31:00: __i2c_hid_command: cmd=3D22 00 00 0=
8
[16455.540884] i2c_hid i2c-SYNA2B31:00: i2c_hid_set_power
[16455.540894] i2c_hid i2c-SYNA2B31:00: __i2c_hid_command: cmd=3D22 00 01 0=
8
[16455.586584] i2c_hid i2c-SYNA2B31:00: i2c_hid_set_power
[16455.586590] i2c_hid i2c-SYNA2B31:00: __i2c_hid_command: cmd=3D22 00 00 0=
8
[16455.610960] i2c_hid i2c-SYNA2B31:00: i2c_hid_set_power
[16455.610967] i2c_hid i2c-SYNA2B31:00: __i2c_hid_command: cmd=3D22 00 01 0=
8
[16455.617876] i2c_hid i2c-ITE8186:00: Fetching the HID descriptor
[16455.617883] i2c_hid i2c-ITE8186:00: __i2c_hid_command: cmd=3D01 00
[16455.619067] i2c_hid i2c-ITE8186:00: HID Descriptor: 1e 00 00 01 3c
04 02 00 03 00 11 00 04 00 00 00 05 00 06 00 8d 04 86 81 18 10 00 00
00 00
[16455.619255] i2c_hid i2c-ITE8186:00: entering i2c_hid_parse
[16455.619259] i2c_hid i2c-ITE8186:00: i2c_hid_hwreset
[16455.619261] i2c_hid i2c-ITE8186:00: i2c_hid_set_power
[16455.619265] i2c_hid i2c-ITE8186:00: __i2c_hid_command: cmd=3D05 00 00 08
[16455.619504] i2c_hid i2c-ITE8186:00: resetting...
[16455.619507] i2c_hid i2c-ITE8186:00: __i2c_hid_command: cmd=3D05 00 00 01
[16455.621336] i2c_hid i2c-ITE8186:00: __i2c_hid_command: waiting...
[16455.623987] i2c_hid i2c-ITE8186:00: __i2c_hid_command: finished.
[16455.623992] i2c_hid i2c-ITE8186:00: asking HID report descriptor
[16455.623995] i2c_hid i2c-ITE8186:00: __i2c_hid_command: cmd=3D02 00
[16455.629566] i2c_hid i2c-SYNA2B31:00: i2c_hid_set_power
[16455.629572] i2c_hid i2c-SYNA2B31:00: __i2c_hid_command: cmd=3D22 00 00 0=
8
[16455.652115] i2c_hid i2c-ITE8186:00: Report Descriptor: 06 83 ff 09
80 a1 01 85 5a 09 01 15 00 26 ff 00 75 08 95 10 b1 00 c0 05 20 09 01
a1 01 85 01 05 20 09 73 a1 00 05 20 0a 09 03 15 00 25 02 75 08 95 01
a1 02 0a 30 08 0a 31 08 0a 32 08 b1 00 c0
[16455.654650] i2c_hid i2c-ITE8186:00: i2c_hid_get_report
[16455.654655] i2c_hid i2c-ITE8186:00: __i2c_hid_command: cmd=3D05 00 3f
02 5a 06 00
[16455.656684] i2c_hid i2c-ITE8186:00: report (len=3D19): 12 00 5a ff ff
ff ff ff ff ff ff ff ff ff ff ff ff ff 06
[16455.656691] i2c_hid i2c-ITE8186:00: error in i2c_hid_init_report
size:19 / ret_size:18
[16455.656701] i2c_hid i2c-ITE8186:00: i2c_hid_get_report
[16455.656705] i2c_hid i2c-ITE8186:00: __i2c_hid_command: cmd=3D05 00 31 02=
 06 00
[16455.657850] i2c_hid i2c-ITE8186:00: report (len=3D21): 15 00 01 01 01
05 02 7d 00 00 00 02 00 02 00 12 00 a0 0f 60 f0
[16455.657859] i2c_hid i2c-ITE8186:00: i2c_hid_get_report
[16455.657862] i2c_hid i2c-ITE8186:00: __i2c_hid_command: cmd=3D05 00 32 02=
 06 00
[16455.659463] i2c_hid i2c-ITE8186:00: report (len=3D41): 29 00 02 01 01
05 02 dc 05 00 00 c4 09 ff ff 00 00 54 00 01 00 64 00 05 00 64 00 e8
03 79 00 5a 0c 91 00 88 13 ae 00 10 27
[16455.659472] i2c_hid i2c-ITE8186:00: i2c_hid_get_report
[16455.659475] i2c_hid i2c-ITE8186:00: __i2c_hid_command: cmd=3D05 00 33 02=
 06 00
[16455.660812] i2c_hid i2c-ITE8186:00: report (len=3D35): 23 00 03 01 01
06 02 50 00 00 00 0a 00 4c 00 65 00 6e 00 6f 00 76 00 6f 00 20 00 59
00 6f 00 67 00 61 00
[16455.662221] i2c_hid i2c-ITE8186:00: i2c_hid_set_power
[16455.662225] i2c_hid i2c-ITE8186:00: __i2c_hid_command: cmd=3D05 00 01 08

On Fri, Nov 18, 2016 at 11:15 AM, Henr=C3=BD =C3=9E=C3=B3r Baldursson
<henry.baldursson@gmail.com> wrote:
> Hello
>
> I'm trying to get sensors working on my Lenovo Ideapad Yoga 910.
>
> I'm running kernel 4.8.8. I did try 4.9-rc5 thinking the ISH support
> might help, but to no avail.
>
> Here's iio-sensor-proxy trying to read the sensors:
>
> ** (process:10981): DEBUG: Found als at
> /sys/devices/pci0000:00/0000:00:15.3/i2c_designware.2/i2c-8/i2c-ITE8186:0=
0/0018:048D:8186.0003/HID-SENSOR-200041.3.auto/iio:device0
> ** (process:10981): DEBUG: Found device
> /sys/devices/pci0000:00/0000:00:15.3/i2c_designware.2/i2c-8/i2c-ITE8186:0=
0/0018:048D:8186.0003/HID-SENSOR-200041.3.auto/iio:device0
> of type ambient light sensor at IIO Buffer Light sensor
> ** (process:10981): DEBUG: Found accel_3d at
> /sys/devices/pci0000:00/0000:00:15.3/i2c_designware.2/i2c-8/i2c-ITE8186:0=
0/0018:048D:8186.0003/HID-SENSOR-200073.2.auto/iio:device1
> ** (process:10981): DEBUG: Found device
> /sys/devices/pci0000:00/0000:00:15.3/i2c_designware.2/i2c-8/i2c-ITE8186:0=
0/0018:048D:8186.0003/HID-SENSOR-200073.2.auto/iio:device1
> of type accelerometer at IIO Buffer accelerometer
> ** (process:10981): DEBUG: Found associated trigger at
> /sys/devices/pci0000:00/0000:00:15.3/i2c_designware.2/i2c-8/i2c-ITE8186:0=
0/0018:048D:8186.0003/HID-SENSOR-200073.2.auto/trigger1
> ** (process:10981): DEBUG: Got type for in_accel_y: is signed: 1,
> bytes: 4, bits_used: 16, shift: 0, mask: 0x65535, be: 0
> ** (process:10981): DEBUG: Got type for in_accel_x: is signed: 1,
> bytes: 4, bits_used: 16, shift: 0, mask: 0x65535, be: 0
> ** (process:10981): DEBUG: Got type for in_accel_z: is signed: 1,
> bytes: 4, bits_used: 16, shift: 0, mask: 0x65535, be: 0
> ** (process:10981): DEBUG: Built channel array for in_accel_x: index:
> 0, is signed: 1, bytes: 4, bits_used: 16, shift: 0, mask: 0x65535, be:
> 0
> ** (process:10981): DEBUG: Built channel array for in_accel_y: index:
> 1, is signed: 1, bytes: 4, bits_used: 16, shift: 0, mask: 0x65535, be:
> 0
> ** (process:10981): DEBUG: Built channel array for in_accel_z: index:
> 2, is signed: 1, bytes: 4, bits_used: 16, shift: 0, mask: 0x65535, be:
> 0
> ** (process:10981): DEBUG: Found associated trigger at
> /sys/devices/pci0000:00/0000:00:15.3/i2c_designware.2/i2c-8/i2c-ITE8186:0=
0/0018:048D:8186.0003/HID-SENSOR-200041.3.auto/trigger0
> ** (process:10981): DEBUG: Got type for in_intensity_both: is signed:
> 1, bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
> ** (process:10981): DEBUG: Built channel array for in_intensity_both:
> index: 0, is signed: 1, bytes: 4, bits_used: 32, shift: 0, mask: 0x0,
> be: 0
> ** (process:10981): DEBUG: Handling driver refcounting method
> 'ClaimLight' for ambient light sensor device
> ** (process:10981): DEBUG: Handling driver refcounting method
> 'ClaimAccelerometer' for accelerometer device
> ** (process:10981): DEBUG: No new data available on 'iio:device0'
> ** (process:10981): DEBUG: No new data available on 'iio:device1'
> ** (process:10981): DEBUG: No new data available on 'iio:device0'
> ** (process:10981): DEBUG: No new data available on 'iio:device1'
>
> It basically reads the accelerometer orientation as 'normal' and never
> updates it, and the light sensor at 0.0 lux and never updates.
>
> I do get this error during boot:
> [    2.321857] i2c_hid i2c-ITE8186:00: error in i2c_hid_init_report
> size:19 / ret_size:18
>
> It would be nice to get them working, is there anything I can do? I
> have no experience debugging hardware interfaces like these myself,
> but I'm usually pretty handy
>
>
> - Henry.
