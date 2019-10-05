From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 2/2] docs: w1: Fix SPDX-License-Identifier syntax
Date: Sat,  5 Oct 2019 22:01:23 +0200
Message-ID: <20191005200126.25809-2-j.neuschaefer@gmx.net>
References: <20191005200126.25809-1-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191005200126.25809-1-j.neuschaefer@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-doc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Evgeniy Polyakov <zbr@ioremap.net>, Jonathan Corbet <corbet@lwn.net>, Alexandre Belloni <alexandre.belloni@bootlin.com>, =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

ReST directives are introduced with two dots.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/w1/index.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/w1/index.rst b/Documentation/w1/index.rst
index 57cba81865e2..156279f17553 100644
=2D-- a/Documentation/w1/index.rst
+++ b/Documentation/w1/index.rst
@@ -1,4 +1,4 @@
-. SPDX-License-Identifier: GPL-2.0
+.. SPDX-License-Identifier: GPL-2.0

 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 1-Wire Subsystem
=2D-
2.20.1
