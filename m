From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v10 5/9] MAINTAINERS: Add myself as the I3C subsystem maintainer
Date: Fri, 26 Oct 2018 16:43:29 +0200
Message-ID: <20181026144333.12276-6-boris.brezillon@bootlin.com>
References: <20181026144333.12276-1-boris.brezillon@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181026144333.12276-1-boris.brezillon@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vitor Soares <Vitor.Soares@synopsys.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linus
List-Id: linux-i2c@vger.kernel.org

Create an entry for the I3C subsystem and mark it as maintained by me.
There's no official git repository, patchwork instance, mailing list or
website yet, but this will be added after the subsystem has been
accepted.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
Changes in v10:
- None

Changes in v9:
- None

Changes in v8:
- None

Changes in v7:
- Add a ML (not created yet) and a git repo

Changes in v5:
- Add the sysfs ABI file
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a5b256b25905..293c863b6f9f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6918,6 +6918,18 @@ L:	linux-i2c@vger.kernel.org
 S:	Maintained
 F:	drivers/i2c/i2c-stub.c
 
+I3C SUBSYSTEM
+M:	Boris Brezillon <boris.brezillon@bootlin.com>
+L:	linux-i3c@vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-bus-i3c
+F:	Documentation/devicetree/bindings/i3c/
+F:	Documentation/driver-api/i3c
+F:	drivers/i3c/
+F:	include/linux/i3c/
+F:	include/dt-bindings/i3c/
+
 IA64 (Itanium) PLATFORM
 M:	Tony Luck <tony.luck@intel.com>
 M:	Fenghua Yu <fenghua.yu@intel.com>
-- 
2.17.1
