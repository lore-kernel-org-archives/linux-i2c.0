From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCHv5 0/8] 2c: Relax mandatory I2C ID table passing
Date: Mon, 9 May 2016 10:14:26 +0100
Message-ID: <20160509091426.GG8324@dell>
References: <1462374888-22888-1-git-send-email-kieran@bingham.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462374888-22888-1-git-send-email-kieran@bingham.xyz>
Sender: linux-kernel-owner@vger.kernel.org
To: Kieran Bingham <kieran@ksquared.org.uk>
Cc: Wolfram Sang <wsa@the-dreams.de>, javier@osg.samsung.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, grant.likely@linaro.org, sameo@linux.intel.com
List-Id: linux-i2c@vger.kernel.org

On Wed, 04 May 2016, Kieran Bingham wrote:

> This patch set finally pops up again, after a long time stuck somewhe=
re in the
> midst of my stack.
>=20
> As it stood last year, the requirements were to rename probe2 to prob=
e_new, and
> ensure that it was correctly tested. The rename was the easy bit, but=
 the
> testing took me more time to get things set up properly. And other co=
mmitments
> then got in the way of things. Of course this patch set has also been=
 rebased
> as well, but there wasn't any major pain there.
>=20
> Testing
> -------
>=20
> To try to establish testing, I have used a beagle-bone-black, and a D=
S1307 RTC
> connected to the BBB SCL and SDA lines. The main reason for these cho=
ices is
> accesibility. i.e. I have them, and the BBB readily boots a kernel fo=
r me to
> test and iterate with.
>=20
> I've tested the device with i2cdetect, and then worked through testin=
g the
> sysfs interface, device tree, and module autoloading, each time ensur=
ing that
> the RTC enumerates and operates
>=20
> * new_device (built-in, and external module)
>   echo ds1307 0x68 > /sys/bus/i2c/devices/i2c-2/new_device
>   cat /sys/class/rtc/rtc0/date
>=20
>  - Both of those worked fine.
>=20
> * Device Tree
>   I tested that the device would still register by adding a node in t=
he device
>   tree for the board, and testing with a built-in module.=20
>=20
>  - This worked fine.
>=20
> * Module Autoloading
>   With the device tree node in the board dts file, it wouldn't automa=
tically
>   load from the external module. This was due to the rtc-ds1307 modul=
e not
>   exporting an of_match table, and not yet having Javier's "report OF=
 style
>   modalias when probing using DT" [0]  patch applied
>=20
>  - With the module updated, and Javiers patch applied, the module aut=
oloads
>=20
> Finally, I feel I can safely add this tag to the patch set:
> Tested-by: Kieran Bingham <kieran@bingham.xyz>

Great work Kieran.

Wolfram, Javier,

Looks like Kieran has ticked each of your boxes.

I guess there is nothing stopping this set from being applied now,
right?

> Please let me know if there is any other specific use case missing he=
re that
> needs to be tested.
>=20
> [0] https://patchwork.ozlabs.org/patch/502201/
>=20
> Patches
> -------
> Lee Jones (8):
>   i2c: Add pointer dereference protection to i2c_match_id()
>   i2c: Add the ability to match device to compatible string without a=
n
>     of_node
>   i2c: Match using traditional OF methods, then by vendor-less
>     compatible strings
>   i2c: Make I2C ID tables non-mandatory for DT'ed devices
>   i2c: Export i2c_match_id() for direct use by device drivers
>   i2c: Provide a temporary .probe_new() call-back type
>   mfd: 88pm860x: Move over to new I2C device .probe() call
>   mfd: as3722: Rid driver of superfluous I2C device ID structure
>=20
>  drivers/i2c/i2c-core.c      | 75 +++++++++++++++++++++++++++++++++++=
++++------
>  drivers/mfd/88pm860x-core.c |  5 ++-
>  drivers/mfd/as3722.c        | 12 ++------
>  include/linux/i2c.h         | 22 ++++++++++++-
>  4 files changed, 91 insertions(+), 23 deletions(-)
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
