From: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 0/6] i2c: Xilinx IIC: rework driver
Date: Mon, 3 Aug 2015 07:26:31 +0200
Message-ID: <55BEFB87.1090909@xilinx.com>
References: <1438344034-20211-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1438344034-20211-1-git-send-email-rabel-Ejy783gw450hGw5VS8l+XCM2BslAju9D@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert ABEL <rabel-Ejy783gw450hGw5VS8l+XCM2BslAju9D@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 07/31/2015 02:00 PM, Robert ABEL wrote:
>=20
> This patch series completely reworks Xilinx' XIIC driver. Short summa=
ry:
> Driver didn't work for me and I don't know how it could ever have wor=
ked for anybody.
> So I rewrote it in big parts and now it works for me=E2=84=A2.
>=20
> Due to how the XIIC IP core is written, certain operations have to be=
 done in short succession
> before XIIC is able to send out a single word over I2C. The original =
code didn't take this into
> account. The original code also doesn't expect bus faults, so undefin=
ed behavior will happen
> on spurious interrupts while using the driver.
>=20
> There are still two issues in there which I think might preclude prop=
er SMBus operation, see patch 4 notes.
> However these issues are also in the original code, so there's no reg=
ression here.
>=20
> The bulk of the work is in patch 4 as are the bulk of patch series co=
mments about driver behavior.
>=20
> Regards
>=20
> Robert
>=20
> This patch series depends on: (https://github.com/Xilinx/linux-xlnx)
>=20
> 36bc779 i2c: xiic: Do not continue in case of errors in Rx
> 875c2be i2c: xiic: Remove the disabling of interrupts
> 2abc522 i2c: xiic: move the xiic_process to thread context
> ec52523 i2c: xiic: Do not reset controller before every transfer
> 3d1f868 i2c: xiic: Remove the disabling of interrupts
> 0b018f2 i2c: xiic: Remove busy loop while waiting for bus busy
> 5fc498e i2c: xiic: Add a msg in case of timeout
> b4272fe i2c: xiic: Remove the Addressed as slave interrupt
> 3a0fd6c i2c: xiic: Service all interrupts in isr
>=20
> Patch 6 depends on: (mainline)
>=20
> 37786c7 of: Add helper function to check MMIO register endianness
> 65a7100 of: Document {little,big,native}-endian bindings
>=20

I am confused. Do you want to change xilinx tree or mainline? You are
using public mailing list that's why all you patches have to be based o=
n
the mainline repository not xilinx tree.
Please rebase and resent.

Thanks,
Michal
