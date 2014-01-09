From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 0/5] ARM: sun6i: Add support for the A31 I2C controller
Date: Thu,  9 Jan 2014 18:19:58 +0100
Message-ID: <1389288003-23187-1-git-send-email-maxime.ripard@free-electrons.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRB35WXOLAKGQE6YDMFLA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kevin.z.m.zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, zhuzhenhua-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, duanmintao-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi everyone,

This patchset adds support the A31 i2c controller. This is mostly the
same controller as the one found in the other Allwinner SoCs, except
for the interrupts acking.

On the other SoCs using this driver, the interrupts are acked by
clearing the INT_FLAG bit in the control register, while on the A31,
the interrupt is acked by writing that bit into the control register.

The other difference is that the I2C IP is maintained in reset by a
reset controller, so we're adding optionnal support for the reset
framework in the driver to deassert the device from reset.

Thanks!
Maxime

Maxime Ripard (5):
  i2c: mv64xxx: Add reset deassert call
  i2c: mv64xxx: Add support for the Allwinner A31 I2C driver
  ARM: sun6i: Enable the I2C controllers
  ARM: sun6i: Enable the I2C muxing options
  ARM: sun6i: colombus: Enable the I2C controllers

 .../devicetree/bindings/i2c/i2c-mv64xxx.txt        |  1 +
 arch/arm/boot/dts/sun6i-a31-colombus.dts           | 18 +++++++
 arch/arm/boot/dts/sun6i-a31.dtsi                   | 61 ++++++++++++++++++++++
 drivers/i2c/busses/Kconfig                         |  1 +
 drivers/i2c/busses/i2c-mv64xxx.c                   | 16 ++++++
 5 files changed, 97 insertions(+)

-- 
1.8.4.2
