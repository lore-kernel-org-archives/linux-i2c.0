From: "Adamski, Krzysztof (Nokia - PL/Wroclaw)"
        <krzysztof.adamski@nokia.com>
Subject: [PATCH] MAINTAINERS: add entry for i2c-axxia driver
Date: Tue, 11 Dec 2018 09:17:52 +0000
Message-ID: <20181211091733.GA28051@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Content-ID: <AB6064D8B3D89A45A2D1AA3B0E079A5A@eurprd07.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
List-Id: linux-i2c@vger.kernel.org

Create separate entry for i2c-axxia and set myself as maintainer.

Even though I don't work for Intel/LSI who is the manufacturer of this
IP, I do have access to some documentation and the actual hardware using
this driver and I'm familiar with the code.

Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0767f1d1b579..2961b4d0a8e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2633,6 +2633,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/axentia,*
 F:	sound/soc/atmel/tse850-pcm5142.c
=20
+AXXIA I2C CONTROLLER
+M:	Krzysztof Adamski <krzysztof.adamski@nokia.com>
+L:	linux-i2c@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/i2c/i2c-axxia.txt
+F:	drivers/i2c/busses/i2c-axxia.c
+
 AZ6007 DVB DRIVER
 M:	Mauro Carvalho Chehab <mchehab@kernel.org>
 L:	linux-media@vger.kernel.org
--=20
2.17.2
