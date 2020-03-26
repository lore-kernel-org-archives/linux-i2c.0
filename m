From: Alain Volmat <alain.volmat-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH v2 0/2] i2c: i2c-stm32f7: allow range of I2C bus frequency
Date: Thu, 26 Mar 2020 13:44:19 +0100
Message-ID: <1585226661-26262-1-git-send-email-alain.volmat@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, pierre-yves.mordret-qxv4g6HH51o@public.gmane.org, mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alexandre.torgue-qxv4g6HH51o@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-stm32-XDFAJ8BFU24N7RejjzZ/Li2xQDfSxrLKVpNB7YpNyf8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, fabrice.gasnier-qxv4g6HH51o@public.gmane.org, alain.volmat-qxv4g6HH51o@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This serie introduces the possibility to set bus frequency other
than 100KHz, 400KHz and 1MHz.

Changelog:
v2: fix i2c: i2c-stm32f7: allows for any bus frequency patch

Alain Volmat (2):
  dt-bindings: i2c: i2c-stm32f7: allow clock-frequency range
  i2c: i2c-stm32f7: allows for any bus frequency

 .../devicetree/bindings/i2c/st,stm32-i2c.yaml |   8 +-
 drivers/i2c/busses/i2c-stm32f7.c              | 116 +++++++++---------
 2 files changed, 65 insertions(+), 59 deletions(-)
