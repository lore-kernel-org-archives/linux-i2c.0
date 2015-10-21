From: Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/9] i2c: brcmstb: add support for BMIPS_GENERIC
Date: Wed, 21 Oct 2015 11:36:52 +0900
Message-ID: <1445395021-4204-1-git-send-email-jaedon.shin@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Cc: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi all,

This patch series adds support for BMIPS_GENERIC, and fixes running conditions.

Thanks.

Jaedon Shin (9):
  i2c: brcmstb: make the driver buildable on BMIPS_GENERIC
  i2c: brcmstb: fix typo in i2c-brcmstb
  i2c: brcmstb: add missing parenthesis
  i2c: brcmstb: enable ACK condition
  i2c: brcmstb: fix start and stop conditions
  MIPS: BMIPS: brcmstb: add I2C node for bcm7346
  MIPS: BMIPS: brcmstb: add I2C node for bcm7358
  MIPS: BMIPS: brcmstb: add I2C node for bcm7360
  MIPS: BMIPS: brcmstb: add I2C node for bcm7362

 arch/mips/boot/dts/brcm/bcm7346.dtsi      | 72 ++++++++++++++++++++++++++++++-
 arch/mips/boot/dts/brcm/bcm7358.dtsi      | 62 +++++++++++++++++++++++++-
 arch/mips/boot/dts/brcm/bcm7360.dtsi      | 62 +++++++++++++++++++++++++-
 arch/mips/boot/dts/brcm/bcm7362.dtsi      | 52 +++++++++++++++++++++-
 arch/mips/boot/dts/brcm/bcm97346dbsmb.dts | 20 +++++++++
 arch/mips/boot/dts/brcm/bcm97358svmb.dts  | 16 +++++++
 arch/mips/boot/dts/brcm/bcm97360svmb.dts  | 16 +++++++
 arch/mips/boot/dts/brcm/bcm97362svmb.dts  | 12 ++++++
 drivers/i2c/busses/Kconfig                |  2 +-
 drivers/i2c/busses/i2c-brcmstb.c          | 11 +++--
 10 files changed, 310 insertions(+), 15 deletions(-)

-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
