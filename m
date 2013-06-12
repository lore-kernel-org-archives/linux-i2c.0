From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCHv5 0/8] Add I2C support for Allwinner SoCs
Date: Wed, 12 Jun 2013 18:53:29 +0200
Message-ID: <1371056017-8166-1-git-send-email-maxime.ripard@free-electrons.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBG6P4KGQKGQEF5JS7JQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post?hl=en-GB>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en-GB>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi?hl=en-GB>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe?hl=en-GB>,
 <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe?hl=en-GB>,
 <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, kevin-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

This patchset adds support for the I2C controller found on most of the
Allwinner SoCs, especially the already supported A10 and A13, and the
yet to come A31.

This driver leverages the Marvel mv64xxx i2c controller driver, that has
an almost identical logic, with a slightly different register layout.

It has been tested on a A13-Olinuxino and an A10s-Olinuxino.

Thanks,
Maxime

Changes from v4:
  * Don't expose the reg offset structure through the platform data
  * Move the register offset structures to the driver and declare them stat=
ic
  * Default at marvell's register layout when using platform data, and swit=
ch
    between the Allwinner and the Marvell ones only when using DT.
  * Remove the pull-ups in the device tree muxings

Changes from v3:
  * Merged the driver in the Marvell mv64xxx i2c controller

Changes from v2:
  * Slightly modified the switch comments again
  * Removed the of_* calls in favor of platform_get_* functions

Changes from v1:
  * Added comments to the switch statements to clarify when the fall throug=
h to
    the next case is made on purpose
  * Use devm_ioremap_resource instead of of_iomap
  * Moved the reset after enabling the clocks
  * Added Emilio Lopez' patch to add the available i2c controllers to the
    cubieboard

Emilio L=F3pez (1):
  ARM: sun4i: cubieboard: Enable the i2c controllers

Maxime Ripard (7):
  i2c: mv64xxx: Add macros to access parts of registers
  i2c: mv64xxx: make the registers offset configurable
  i2c: mv64xxx: Add Allwinner sun4i compatible
  ARM: sunxi: dt: Add i2c controller nodes to the DTSI
  ARM: sun4i: dt: Add i2c muxing options
  ARM: sun5i: dt: Add i2c muxing options
  ARM: sun5i: olinuxino: Enable the i2c controllers

 arch/arm/boot/dts/sun4i-a10-cubieboard.dts |  12 +++
 arch/arm/boot/dts/sun4i-a10.dtsi           |  48 ++++++++++++
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts  |  18 +++++
 arch/arm/boot/dts/sun5i-a13.dtsi           |  48 ++++++++++++
 drivers/i2c/busses/Kconfig                 |   3 +-
 drivers/i2c/busses/i2c-mv64xxx.c           | 118 +++++++++++++++++++------=
----
 6 files changed, 206 insertions(+), 41 deletions(-)

--=20
1.8.3

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/groups/opt_out.
