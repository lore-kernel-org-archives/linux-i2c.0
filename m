From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v10 3/9] i3c: Add sysfs ABI spec
Date: Fri, 26 Oct 2018 16:43:27 +0200
Message-ID: <20181026144333.12276-4-boris.brezillon@bootlin.com>
References: <20181026144333.12276-1-boris.brezillon@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181026144333.12276-1-boris.brezillon@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vitor Soares <Vitor.Soares@synopsys.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linus
List-Id: linux-i2c@vger.kernel.org

Document sysfs files/directories/symlinks exposed by the I3C subsystem.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
Changes in v10:
- None

Changes in v9:
- Add Arnd's R-b

Changes in v8:
- None

Changes in v7:
- Bump KernelVersion to 4.20
- Add new entries under i3c-<bus-id> now that the master controller is
  no longer represented as a device under this directory but implicitly
  represented by the bus object

Changes in v6:
- none

Changes in v5:
- Fix the kernel version
- Rename address into dynamic_address to match changes done in the code

Changes in v4:
- none

Changes in v3:
- none

Changes in v2:
- new patch
---
 Documentation/ABI/testing/sysfs-bus-i3c | 146 ++++++++++++++++++++++++
 1 file changed, 146 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-i3c

diff --git a/Documentation/ABI/testing/sysfs-bus-i3c b/Documentation/ABI/testing/sysfs-bus-i3c
new file mode 100644
index 000000000000..d7c7485b0c17
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-i3c
@@ -0,0 +1,146 @@
+What:		/sys/bus/i3c/devices/i3c-<bus-id>
+KernelVersion:  4.20
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		An I3C bus. This directory will contain one sub-directory per
+		I3C device present on the bus.
+
+What:		/sys/bus/i3c/devices/i3c-<bus-id>/current_master
+KernelVersion:  4.20
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		Expose the master that owns the bus (<bus-id>-<master-pid>) at
+		the time this file is read. Note that bus ownership can change
+		overtime, so there's no guarantee that when the read() call
+		returns, the value returned is still valid.
+
+What:		/sys/bus/i3c/devices/i3c-<bus-id>/mode
+KernelVersion:  4.20
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		I3C bus mode. Can be "pure", "mixed-fast" or "mixed-slow". See
+		the I3C specification for a detailed description of what each
+		of these modes implies.
+
+What:		/sys/bus/i3c/devices/i3c-<bus-id>/i3c_scl_frequency
+KernelVersion:  4.20
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		The frequency (expressed in Hz) of the SCL signal when
+		operating in I3C SDR mode.
+
+What:		/sys/bus/i3c/devices/i3c-<bus-id>/i2c_scl_frequency
+KernelVersion:  4.20
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		The frequency (expressed in Hz) of the SCL signal when
+		operating in I2C mode.
+
+What:		/sys/bus/i3c/devices/i3c-<bus-id>/dynamic_address
+KernelVersion:  4.20
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		Dynamic address assigned to the master controller. This
+		address may change if the bus is re-initialized.
+
+What:		/sys/bus/i3c/devices/i3c-<bus-id>/bcr
+KernelVersion:  4.20
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		BCR stands for Bus Characteristics Register and express the
+		device capabilities in term of speed, maximum read/write
+		length, etc. See the I3C specification for more details.
+		This entry describes the BCR of the master controller driving
+		the bus.
+
+What:		/sys/bus/i3c/devices/i3c-<bus-id>/dcr
+KernelVersion:  4.20
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		DCR stands for Device Characteristics Register and express the
+		device capabilities in term of exposed features. See the I3C
+		specification for more details.
+		This entry describes the DCR of the master controller driving
+		the bus.
+
+What:		/sys/bus/i3c/devices/i3c-<bus-id>/pid
+KernelVersion:  4.20
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		PID stands for Provisional ID and is used to uniquely identify
+		a device on a bus. This PID contains information about the
+		vendor, the part and an instance ID so that several devices of
+		the same type can be connected on the same bus.
+		See the I3C specification for more details.
+		This entry describes the PID of the master controller driving
+		the bus.
+
+What:		/sys/bus/i3c/devices/i3c-<bus-id>/hdrcap
+KernelVersion:  4.20
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		Expose the HDR (High Data Rate) capabilities of a device.
+		Returns a list of supported HDR mode, each element is separated
+		by space. Modes can be "hdr-ddr", "hdr-tsp" and "hdr-tsl".
+		See the I3C specification for more details about these HDR
+		modes.
+		This entry describes the HDRCAP of the master controller
+		driving the bus.
+
+What:		/sys/bus/i3c/devices/i3c-<bus-id>/<bus-id>-<device-pid>
+KernelVersion:  4.20
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		An I3C device present on I3C bus identified by <bus-id>. Note
+		that all devices are represented including the master driving
+		the bus.
+
+What:		/sys/bus/i3c/devices/i3c-<bus-id>/<bus-id>-<device-pid>/dynamic_address
+KernelVersion:  4.20
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		Dynamic address assigned to device <bus-id>-<device-pid>. This
+		address may change if the bus is re-initialized.
+
+What:		/sys/bus/i3c/devices/i3c-<bus-id>/<bus-id>-<device-pid>/bcr
+KernelVersion:  4.20
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		BCR stands for Bus Characteristics Register and express the
+		device capabilities in term of speed, maximum read/write
+		length, etc. See the I3C specification for more details.
+
+What:		/sys/bus/i3c/devices/i3c-<bus-id>/<bus-id>-<device-pid>/dcr
+KernelVersion:  4.20
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		DCR stands for Device Characteristics Register and express the
+		device capabilities in term of exposed features. See the I3C
+		specification for more details.
+
+What:		/sys/bus/i3c/devices/i3c-<bus-id>/<bus-id>-<device-pid>/pid
+KernelVersion:  4.20
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		PID stands for Provisional ID and is used to uniquely identify
+		a device on a bus. This PID contains information about the
+		vendor, the part and an instance ID so that several devices of
+		the same type can be connected on the same bus.
+		See the I3C specification for more details.
+
+What:		/sys/bus/i3c/devices/i3c-<bus-id>/<bus-id>-<device-pid>/hdrcap
+KernelVersion:  4.20
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		Expose the HDR (High Data Rate) capabilities of a device.
+		Returns a list of supported HDR mode, each element is separated
+		by space. Modes can be "hdr-ddr", "hdr-tsp" and "hdr-tsl".
+		See the I3C specification for more details about these HDR
+		modes.
+
+What:		/sys/bus/i3c/devices/<bus-id>-<device-pid>
+KernelVersion:  4.20
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		These directories are just symbolic links to
+		/sys/bus/i3c/devices/i3c-<bus-id>/<bus-id>-<device-pid>.
-- 
2.17.1
