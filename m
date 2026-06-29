Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9386A416D04
	for <linux-i2c@vger.kernel.org>; Mon, 29 Jun 2026 14:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782742549; cv=pass; b=aUHoN3uWkTEWwePHlmJcKeGolByhNxCwITYadyNPyEs50P44c5EvLdrraGvWNEBbKRiumBuZOwu8jgw5HQmHbuY7zlrfUG/p6/pY7ceYGV+eT8awCgNTRM7qtysqSXWkBxu/TqY4SADqY5uWdOo932eKS4zRSiWrtxEwX0iErF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782742549; c=relaxed/simple;
	bh=OtZHlosSQyn1xZEj4FbD20xEl2Zg6R/HhfdZz9XIx8g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=IkGaIhDsPfR5+vO3acXsJXZwx5OGERWGGILU2AcaX3HQoEENpu88Dqh8zOwcd+AfP5XBSAucvcFVfiZ5e1glg7h3JXol2AdRD6VpJ6ajUqVkO+E24X9SMliM6Rqkvl/7cSyNv9unSteKjJxj/05Hcd9fIj6k+0hSp41MFNt9GSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n33VHGyN; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n33VHGyN"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39b19e7d6fcso2383571fa.1
        for <linux-i2c@vger.kernel.org>; Mon, 29 Jun 2026 07:15:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782742546; cv=none;
        d=google.com; s=arc-20260327;
        b=QsHiaX0knyc3iX32oAioO8C4itCgghkoauOfeIgJFbCNwRSEaFyqXoIxyZwO1WH5yX
         W4oOivo/3UfOlOs5vc702IGtht4aUCJu0Cjb+xuRfAMUb0fJTrFObGRrOyr6bG7lVVLW
         mKuAuE8HX4gNGcqDo6lYxuTNlpM5OzmJ0L0TRg4Ob3Whm0RCPDx5Dow/Lr5ATnRMcHJ2
         U7r/Un2QXm+YZxK7TiNyYSO1ak4BT9Tm3xfmPPHgq293txJn9wwcmPW2/xOsRtqpy84l
         ino7Ai4IlgVkPSmBm3us7vSRwQy8Lo+07POAog1ijppeEusMasD6OXWnvEtwkSpiLmJ+
         iSAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=59kKtSnZyepLfYP5fS5VCom4sURma9Duve+AdYcsFp8=;
        fh=5MNj+45vgB+8JJ3KnrWdU8wt+4uLQQrMsnWx7Q0/Wd4=;
        b=EgoM0/PycglGn7yIl/O8nJByoo3WAWSJSHyX0Gm3mX8S8e2j1bQS3CvtvLl25vhFdR
         hDFEBjtPYIQgFFDV40Enngk+0Ask69b+oW/DBLS/rr1RwuD+2oyyj0Z1QK5V2LEm3OvJ
         RTU3Dq6C6UCw9hBIfgszpkf2Id2hGC+22zm9PZ/4FNdYrImgtbMaSlczpx9eQSIcw7k3
         XCoflQmxmGF3mAk2U2BG/CwUMAYzFd1OMVo1KOxG6do+uJ5bjpQt99M2av6vJWDaR4a3
         CpAFTEZY3q2TPxq7GxTYsoFr04kqfsUyogq7WmCemLozwugs7RuBQTxNS7MR9KCV2jAE
         p54Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782742546; x=1783347346; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=59kKtSnZyepLfYP5fS5VCom4sURma9Duve+AdYcsFp8=;
        b=n33VHGyNRhhg6V2ukiHyuylPTj0yF2chSqR4UrQLU+PcO9DBVZRMJYw2HvrYxJFCXn
         Ols/xxQvAqk9M7nazKiG4RDLbGHkbTilyq3uwK6ZVlK+K3cx2IXyIQ1CHLfV41m4Jn/0
         IprzgknbhpYZsM3ypptw/UO8Kfd7T9QX6OW+KQFP8Zi4OY8EpmnVVVbfIZxAJeO/5qe1
         vlFwz94t1OWM/5yeY7MwAnRwwV5wGObQF0MF6uxHfYijcc4ciLjnU8sRpYtqooVqf6ab
         rJrIEHAXlO9jy/1dIxR3BFWSYf8V/01upD3zrBTzZ2bbwB3aSr0qZIz6PMR3cwNTivDi
         cnnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782742546; x=1783347346;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=59kKtSnZyepLfYP5fS5VCom4sURma9Duve+AdYcsFp8=;
        b=pntE6c712MZ7PmypGmVlFe2p9uokIIUeGKDMlCRrFuOawO1BPUc3lWR/RfFQsQZBHp
         tbmNkIlZVJWFULZ/YtONwlg/AB+7DSiHOeA3vzyKGJW16Z7iaWhJlkEdKKRea48QwKUt
         9of+a0mB6m+P9QEJhdiUrN4tB3AlWG4t0Q+mw4sQG6OdvkEMnLepMSEUL6w5dsmpVYuo
         4t32R0QotcTxuZ6Txj+KGV+0IJBqWrTdkRNl6/IahHtNZkWra3V4+yxoOoyz7qqGguxm
         KDO18plexzdxclB1bZoBUj2vEa6Xh4w6v+5IMjkjlw/Ejjkc7Vc73GQyOjB3HtkIGOGR
         QbBA==
X-Forwarded-Encrypted: i=1; AHgh+RqyitvKhdQ9+mNQygbDv8+ty3NiuzsrBPnFLixd72OMv+gBqXBsmBtF+mwNgnsRNc5CT1v5nd5bTUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnidEomKx2OX3qgvfUA/LT/USb3Ey9u0SW22CgUHIs63uV6TBC
	IlkNoteeMMI+8zVaukKHa2bAzmEf5tP4tD96Y6lptQlaI2FoBzfDzmLHdmUTRU8hYvZnr1icCl/
	GnzpmvEsozSqQx45FLtkBav7FAwMsn2I=
X-Gm-Gg: AfdE7cm4V0KPNt/IQ1bKE1EPw0X2Gt00JnZQc03WNKzkTQ8JbAA1bROdB5AXFazLuc3
	gZcleQ4L6NPdSeeZJDnsMqZRCDxblEAByTc6yw5vrtSCI3kBPtjzjm6DkcGeFKKClL1VoQgX4WG
	WpLV5j84pRbowHIzXhVxHUVhPqYNCpeu/nG4CgYaaWBfw5b0LXX2wbJHOAchy2XeVJMKoo/Cu0W
	hzvh+HRhxYlTuAP9F16W2kMT/Q8qz09hGIHWZITsK/awgeC6+3SgaapKI7sso12LeiZoQuJFxR5
	38bYvUeymEV4tuu4ULz2HffZ1sdfAAlXxdx/Oto4CQ9msNINWFR3uPJ4
X-Received: by 2002:a05:6512:2c8c:b0:5ae:b542:434a with SMTP id
 2adb3069b0e04-5aeb5424384mr1370778e87.34.1782742545486; Mon, 29 Jun 2026
 07:15:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve Yang <steveyang137@gmail.com>
Date: Mon, 29 Jun 2026 22:15:33 +0800
X-Gm-Features: AVVi8CesCnwacAYxOkZCQnuvvoq6KByS_Mn3G3IGfj6ATQqqNfAwuGq04hFjbXE
Message-ID: <CAMNbjot1DD9p2rouzQq_SGjuo0L6WpuX215HaNOcWV7TZpueBQ@mail.gmail.com>
Subject: [BUG] I2C HID touchpad BLTP7853:00 347D:7853 enumerates but reports
 no events on MECHREVO XINGYAO Series-P916F-PTL
To: linux-input@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

Resending as plain text; sorry if this is a duplicate. My previous
message was rejected by linux-acpi because Gmail sent a HTML part.

I am seeing a non-working internal I2C HID touchpad on a new MECHREVO
laptop. The device enumerates, binds to i2c_hid_acpi + hid-multitouch,
and userspace sees it as a touchpad, but touching/clicking it produces
no input events. The GPIO interrupt counter also does not increase
while touching the pad.

I am new to kernel debugging, but I have the machine here and can test
patches, ACPI overrides, debug kernels, etc.

Hardware
========

DMI, with serial/UUID intentionally omitted:

  BIOS Vendor: MECHREVO
  BIOS Version: 1.00
  BIOS Release Date: 03/14/2026
  Firmware Revision: 1.48
  EC Firmware Revision: 1.0
  System Manufacturer: MECHREVO
  Product Name: XINGYAO Series
  Family: Panther Lake
  Base Board Product Name: XINGYAO Series-P916F-PTL

Software
========

  Linux archbook 7.0.14-arch1-1 #1 SMP PREEMPT_DYNAMIC Sat, 27 Jun
2026 16:15:10 +0000 x86_64 GNU/Linux
  linux-firmware 20260622-1
  libinput 1.31.3
  hid-tools 0.12
  acpica 20251212

Kernel command line at initial capture time:

  BOOT_IMAGE=/vmlinuz-linux root=UUID=<omitted> rw rootflags=subvol=@
loglevel=3 quiet

Device identification
=====================

/sys/bus/i2c/devices/i2c-BLTP7853:00/uevent:

  DRIVER=i2c_hid_acpi
  MODALIAS=acpi:BLTP7853:PNP0C50:

/sys/bus/hid/devices/0018:347D:7853.0001/uevent:

  DRIVER=hid-multitouch
  HID_ID=0018:0000347D:00007853
  HID_NAME=BLTP7853:00 347D:7853
  HID_PHYS=i2c-BLTP7853:00
  MODALIAS=hid:b0018g0004v0000347Dp00007853

udev for /dev/input/event5:

  DEVNAME=/dev/input/event5
  ID_INPUT=1
  ID_INPUT_TOUCHPAD=1
  ID_INPUT_WIDTH_MM=115
  ID_INPUT_HEIGHT_MM=72
  ID_BUS=i2c
  ID_INTEGRATION=internal
  ID_INPUT_TOUCHPAD_INTEGRATION=internal
  LIBINPUT_DEVICE_GROUP=18/347d/7853:i2c-BLTP7853:00

Symptoms / tests
================

1. dmesg shows the device binding successfully:

  input: BLTP7853:00 347D:7853 Mouse ...
  input: BLTP7853:00 347D:7853 Touchpad ...
  hid-generic 0018:347D:7853.0001: input,hidraw0: I2C HID v1.00 Mouse
[BLTP7853:00 347D:7853] on i2c-BLTP7853:00
  input: BLTP7853:00 347D:7853 Touchpad ...
  hid-multitouch 0018:347D:7853.0001: input,hidraw0: I2C HID v1.00
Mouse [BLTP7853:00 347D:7853] on i2c-BLTP7853:00

2. evtest on /dev/input/event5 shows normal-looking touchpad
capabilities, for example
ABS_X/ABS_Y/ABS_MT_POSITION_X/ABS_MT_POSITION_Y/ABS_MT_SLOT/ABS_MT_TRACKING_ID
and BTN_TOUCH/BTN_LEFT. However, during physical touch/click tests it
prints no events after:

  Testing ... (interrupt to exit)

3. /proc/interrupts has an IRQ for the touchpad in the original ACPI
configuration:

  intel-gpio 18 BLTP7853:00

While physically touching/clicking the touchpad, the counter did not increase.

4. debugfs gpio shows this line as claimed by the touchpad and high:

  gpiochip1: 51 GPIOs, parent: platform/INTC10BC:01, INTC10BC:01:
   gpio-18 ( |TPD0 GpioInt(0) ) in hi IRQ

5. KDE/libinput sees a touchpad-class input device, but the pointer
does not move and clicks do not work.

Things already tried
====================

None of these changed the behavior:

  - acpi_osi=Windows 2021
  - BIOS option named "Enable Windows OSI"
  - unbind/bind i2c-BLTP7853:00 from i2c_hid_acpi
  - echo on > /sys/bus/i2c/devices/i2c-BLTP7853:00/power/control
  - unloading huawei_wmi
  - setting HID feature Inputmode=3 with hid-feature
  - setting HID feature Surface Switch=1 and Button Switch=1

ACPI override experiments
=========================

The kernel supports ACPI table upgrade, and I confirmed the modified
SSDT was loaded each time via dmesg, for example:

  ACPI: Table Upgrade: override [SSDT-XXXXXX-I2C_DEVT]

I tried these changes to the touchpad GpioInt resource:

  original: GpioInt(Level, ActiveLow, ...)
  test 1: GpioInt(Level, ActiveHigh, ...)
  test 2: GpioInt(Edge, ActiveLow, ...)
  test 3: GpioInt(Edge, ActiveHigh, ...)

All three GpioInt variants still resulted in an intel-gpio IRQ for
BLTP7853:00, but the IRQ counter did not increase while
touching/clicking the touchpad.

I also forced _CRS to return the SBFI Interrupt() resource instead of
the SBFG GpioInt() resource. That changed the interrupt to:

  IR-IO-APIC 84-fasteoi BLTP7853:00

but it caused an apparent interrupt storm, with the counter increasing
by thousands over a few seconds, and still no evtest events. So the
Interrupt() path does not look correct either.

ACPI notes
==========

The touchpad ACPI device appears in SSDT under:

  \_SB.PC00.I2C5.TPD0

Relevant decompiled pieces from ssdt18.dsl:

  Scope (\_SB.PC00.I2C5)
  {
      Device (TPD0)
      {
          Name (HID2, Zero)
          ...
          Name (SBFG, ResourceTemplate ()
          {
              GpioInt (Level, ActiveLow, ExclusiveAndWake, PullDefault, 0x0000,
                  "\\_SB.GPI1", 0x00, ResourceConsumer, ,)
                  { 0x0000 }
          })
          Name (SBFI, ResourceTemplate ()
          {
              Interrupt (ResourceConsumer, Level, ActiveLow,
ExclusiveAndWake, ,, _Y08)
              {
                  0x00000000,
              }
          })
          CreateWordField (SBFB, \_SB.PC00.I2C5.TPD0._Y07._ADR, BADR)
          CreateDWordField (SBFB, \_SB.PC00.I2C5.TPD0._Y07._SPE, SPED)
          CreateWordField (SBFG, 0x17, INT1)
          CreateDWordField (SBFI, \_SB.PC00.I2C5.TPD0._Y08._INT, INT2)

          Method (_INI, 0, NotSerialized)
          {
              INT1 = GNUM (\TPIT)
              INT2 = INUM (\TPIT)
              If ((TPDM == Zero))
              {
                  SHPO (\TPIT, One)
              }
              SGRA (\TPIT, TPDM)
              If ((TPDM == One))
              {
                  SGII (\TPIT, Zero)
                  GRXE (\TPIT, Zero)
              }
              If ((\TPTY == One))
              {
                  _HID = "BLTP7853"
                  HID2 = One
                  BADR = 0x2C
                  SPED = 0x00061A80
                  Return (Zero)
              }
          }

          Name (_HID, "XXXX0000")
          Name (_CID, "PNP0C50")

          Method (_CRS, 0, NotSerialized)
          {
              If ((TPDM == Zero))
              {
                  Return (ConcatenateResTemplate (I2CM (I2CX, BADR,
SPED), SBFG))
              }
              Return (ConcatenateResTemplate (I2CM (I2CX, BADR, SPED), SBFI))
          }
      }
  }

ssdt13.dsl defines the NVS fields used by that code:

  OperationRegion (LCNV, SystemMemory, 0x6FDE4000, 0x0300)
  Field (LCNV, AnyAcc, Lock, Preserve)
  {
      EDID, 4096,
      TPTY, 8,
      TPST, 8,
      TPIT, 32,
      ...
  }

A possibly relevant observation from the same SSDT: under
\_SB.PC00.I2C5, TPD0 seems to use the PXTC power resource, and the
Arg0==0 path in PON() appears to only route/configure IRQ. The Arg0==1
path, apparently for the touch panel PTPL resource, is the one that
toggles TPWR/TRST GPIOs. I have not tested overriding TPD0 to use that
power resource yet.

Question
========

Does this still look like an ACPI GPIO/resource issue, or should I now
focus on an i2c-hid/hid-multitouch quirk or a missing vendor-specific
reset/init sequence for HID 347D:7853?

I have a full debug bundle available, including acpidump, decompiled
SSDTs, dmesg, udev info, evtest output, hid-recorder output,
dmidecode, and /proc/interrupts snapshots. I can provide any specific
files or test patches you want.

Thanks,
Steve
