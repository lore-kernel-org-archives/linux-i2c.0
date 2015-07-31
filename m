From: Robert ABEL <rabel-Ejy783gw450hGw5VS8l+XCM2BslAju9D@public.gmane.org>
Subject: [PATCH 0/6] i2c: Xilinx IIC: rework driver
Date: Fri, 31 Jul 2015 14:00:27 +0200
Message-ID: <1438344034-20211-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


This patch series completely reworks Xilinx' XIIC driver. Short summary=
:
Driver didn't work for me and I don't know how it could ever have worke=
d for anybody.
So I rewrote it in big parts and now it works for me=E2=84=A2.

Due to how the XIIC IP core is written, certain operations have to be d=
one in short succession
before XIIC is able to send out a single word over I2C. The original co=
de didn't take this into
account. The original code also doesn't expect bus faults, so undefined=
 behavior will happen
on spurious interrupts while using the driver.

There are still two issues in there which I think might preclude proper=
 SMBus operation, see patch 4 notes.
However these issues are also in the original code, so there's no regre=
ssion here.

The bulk of the work is in patch 4 as are the bulk of patch series comm=
ents about driver behavior.

Regards

Robert

This patch series depends on: (https://github.com/Xilinx/linux-xlnx)

36bc779 i2c: xiic: Do not continue in case of errors in Rx
875c2be i2c: xiic: Remove the disabling of interrupts
2abc522 i2c: xiic: move the xiic_process to thread context
ec52523 i2c: xiic: Do not reset controller before every transfer
3d1f868 i2c: xiic: Remove the disabling of interrupts
0b018f2 i2c: xiic: Remove busy loop while waiting for bus busy
5fc498e i2c: xiic: Add a msg in case of timeout
b4272fe i2c: xiic: Remove the Addressed as slave interrupt
3a0fd6c i2c: xiic: Service all interrupts in isr

Patch 6 depends on: (mainline)

37786c7 of: Add helper function to check MMIO register endianness
65a7100 of: Document {little,big,native}-endian bindings
