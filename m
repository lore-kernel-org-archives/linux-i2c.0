From: Alexandre Daoud <alex.daoud-ee4meeAH724@public.gmane.org>
Subject: Intel lynx point designware issue
Date: Fri, 30 Jan 2015 16:36:27 +0000
Message-ID: <195CACBC-7E0B-4598-986C-0814289C6ECD@mac.com>
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hey Linux-i2c,

I have a bit of an unorthodox question for this mailing list but you gu=
ys seem like the only people who could help me at this point.

I have a Dell Venue 11 Pro tablet with the Lynxpoint I2C busses (INT33C=
2, INT33C3), one of which drives an i2c-hid touchscreen device. I have =
installed OS X on this device and I have been attempting to port the Li=
nux designware i2c drivers to OS X. The drivers are pretty much just a =
carbon copy of the ones in the Linux kernel with obvious modifications =
to integrate with the Darwin kernel. The issue that I am facing is that=
 no matter what I do, the I2C bus seems to refuse to start an I2C trans=
action. Here is the sequence of events:

I initiate a transaction on the bus with code exactly equivalent to tha=
t in i2c_dw_xfer_init. The bus then generates a IC_INTR_TX_EMPTY interr=
upt and I start filling the transaction fifo by writing to the data com=
mand register. The bus generates a few IC_INTR_TX_EMPTY to avoid overfl=
ow (again, this is following the structure of the Linux kernel drivers =
pretty much line by line). Once the data has been written (with a resta=
rt in the middle for direction change and a stop on the last entry), no=
thing happens. The data to be sent sits in the transaction fifo and the=
 bus does not initiate the transaction, no matter what I try.

Here is a dump of the registers after I have written the transaction da=
ta (the point at which the bus does nothing):

DW_IC_CON: 0x65
DW_IC_TAR: 0x2c
DW_IC_SAR: 0x55
DW_IC_SS_SCL_HCNT: 0x1b0
DW_IC_SS_SCL_LCNT: 0x1fb
DW_IC_FS_SCL_HCNT: 0x48
DW_IC_FS_SCL_LCNT: 0xa0
DW_IC_INTR_STAT: 0x0
DW_IC_INTR_MASK: 0xa0
DW_IC_RAW_INTR_STAT: 0x0
DW_IC_RX_TL: 0x0
DW_IC_TX_TL: 0x1f
DW_IC_STATUS: 0x0
DW_IC_TXFLR: 0x20
DW_IC_RXFLR: 0x0
DW_IC_SDA_HOLD: 0x9
DW_IC_TX_ABRT_SOURCE: 0x0
DW_IC_DMA_CR: 0x0
DW_IC_DMA_TDLR: 0x0
DW_IC_DMA_RDLR: 0x0
DW_IC_SDA_SETUP: 0x64
DW_IC_ENABLE_STATUS: 0x1
DW_IC_FS_SPKLEN: 0x5
DW_IC_COMP_PARAM_1: 0x1f1fee
DW_IC_COMP_VERSION: 0x3131352a
DW_IC_COMP_TYPE: 0x44570140

The bus is configured from the ACPI parameters supplied by Dell.

I know that this mailing list is intended for work on Linux i2c drivers=
 but I=E2=80=99m seriously at a loss now. I=E2=80=99ve been working on =
fixing this issue for the past 3 months, I=E2=80=99ve scoured the inter=
net for any kind of hint as to what=E2=80=99s happening. I=E2=80=99ve a=
lso read the documentation for the Designware bus to no avail. I feel l=
ike the only place I can turn to now is this mailing list, you guys wro=
te the drivers for the Linux kernel after all :) I have a feeling the s=
olution is going to be ridiculously simple and it=E2=80=99s merely some=
thing that I=E2=80=99ve completely overlooked but I would appreciate an=
y help from you guys in understanding why this is happening.

I also apologise in advance if any terminology I have used is incorrect=
=2E Although I have worked with drivers in both Linux and OS X before, =
it=E2=80=99s the first time I work with an I2C bus.

I would also appreciate if you could CC me in your reply as majordomo h=
as yet to confirm my subscription for some reason.

Many thanks in advance,
Alexandre Daoud--
To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
