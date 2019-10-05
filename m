From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 1/2] docs: i2c: Fix SPDX-License-Identifier syntax
Date: Sat,  5 Oct 2019 22:01:22 +0200
Message-ID: <20191005200126.25809-1-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-doc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Evgeniy Polyakov <zbr@ioremap.net>, Jonathan Corbet <corbet@lwn.net>, Alexandre Belloni <alexandre.belloni@bootlin.com>, =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

ReST directives are introduced with two dots.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/i2c/busses/index.rst | 2 +-
 Documentation/i2c/index.rst        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/i2c/busses/index.rst b/Documentation/i2c/busses=
/index.rst
index 97ca4d510816..2a26e251a335 100644
=2D-- a/Documentation/i2c/busses/index.rst
+++ b/Documentation/i2c/busses/index.rst
@@ -1,4 +1,4 @@
-. SPDX-License-Identifier: GPL-2.0
+.. SPDX-License-Identifier: GPL-2.0

 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 I2C Bus Drivers
diff --git a/Documentation/i2c/index.rst b/Documentation/i2c/index.rst
index cd8d020f7ac5..a0fbaf6d0675 100644
=2D-- a/Documentation/i2c/index.rst
+++ b/Documentation/i2c/index.rst
@@ -1,4 +1,4 @@
-. SPDX-License-Identifier: GPL-2.0
+.. SPDX-License-Identifier: GPL-2.0

 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 I2C/SMBus Subsystem
=2D-
2.20.1
