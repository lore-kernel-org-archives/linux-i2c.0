From: Domen Puncer Kugler <domen@cba.si>
Subject: i801_smbus / smo8800 irq clash? pcim_enable_device() fails
Date: Sat, 21 Oct 2017 11:49:52 +0100
Message-ID: <CAB1b2sgvMLFpyMDzYPwO9-jKeAkp0738+t4VnkppQv2GFg_RTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Hi,


I'm trying to track down the root cause of
https://bugzilla.kernel.org/show_bug.cgi?id=194141 and I'm a bit
stuck.

Currently my understanding is:
1. early on boot acpi_register_gsi_ioapic(NULL, gsi=18, ...) is called
for smo8800 driver
2. later i801_probe() calls pcim_enable_device(), which eventually
calls acpi_register_gsi_ioapic(i801_smbus, gsi=18, ...), which fails;
failure then propagates back to probe.
(if I insert code to fail on step 1, step 2 succeeds, and driver works)

Now, to me it's understandable that registering IRQ fails, since
smo8800 doesn't share it, but should that mean pcim_register_device
fails too?

--
   Domen
