From: Jun Gao <jun.gao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 0/2] Add i2c DT binding and device node for Mediatek MT2701 Soc
Date: Wed, 15 Feb 2017 10:32:54 +0800
Message-ID: <1487125976-25243-1-git-send-email-jun.gao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This patch series based on v4.10-rc2, include MT2701 i2c DT binding and device node.

changes since v1:
- Modify commit message

Dependent on "Add clock and power domain DT nodes for Mediatek MT2701"[1].

[1] http://lists.infradead.org/pipermail/linux-mediatek/2016-December/007637.html

Jun Gao (2):
  Documentation: devicetree: Add i2c binding for mediatek MT2701 Soc
    Platform
  arm: dts: mt2701: Add i2c device node

 .../devicetree/bindings/i2c/i2c-mt6577.txt         |   11 ++---
 arch/arm/boot/dts/mt2701-evb.dts                   |   44 ++++++++++++++++++++
 arch/arm/boot/dts/mt2701.dtsi                      |   42 +++++++++++++++++++
 3 files changed, 92 insertions(+), 5 deletions(-)

--
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
