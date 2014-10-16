From: Andreas Werner <andreas.werner@men.de>
Subject: [PATCH 2/2] Documentation/ABI/testing/men_eeprod: Added sysfs
 description for men_eeprod
Date: Thu, 16 Oct 2014 10:15:27 +0200
Message-ID: <dd7d012a2067068570c000fa85eb1760097baa92.1413416105.git.andreas.werner@men.de>
References: <cover.1413416105.git.andreas.werner@men.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1413416105.git.andreas.werner@men.de>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, wsa@the-dreams.de, linux-i2c@vger.kernel.org, johannes.thumshirn@men.de, andreas.werner@men.de
List-Id: linux-i2c@vger.kernel.org

This patch adds the description for the men_eeprod.
men_eeprod is a driver for the MEN Board Information EEPROM which
exports the data using sysfs entries.

Signed-off-by: Andreas Werner <andreas.werner@men.de>
---
 .../ABI/testing/sysfs-bus-i2c-devices-men_eeprod   | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-i2c-devices-men_eeprod

diff --git a/Documentation/ABI/testing/sysfs-bus-i2c-devices-men_eeprod b/Documentation/ABI/testing/sysfs-bus-i2c-devices-men_eeprod
new file mode 100644
index 0000000..a488d0e
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-i2c-devices-men_eeprod
@@ -0,0 +1,69 @@
+What:		/sys/bus/i2c/devices/i2c-<busnr>/<busnr>-<devaddr>/eeprod_id
+Date:		October 2014
+Contact:	Andreas Werner <andreas.werner@men.de>
+Description:
+		Show the identifier of the EEPROM structure.
+		There are different layouts of the EEPROM with more or less
+		information. The ID identifies each of the layouts.
+
+		Currently supported structure is EEPROD2 (0x0E)
+
+What:		/sys/bus/i2c/devices/i2c-<busnr>/<busnr>-<devaddr>/revision
+Date:		October 2014
+Contact:	Andreas Werner <andreas.werner@men.de>
+Description:
+		Show the revision of the board.
+		Format of the revision field is XX.XX.XX
+
+What:		/sys/bus/i2c/devices/i2c-<busnr>/<busnr>-<devaddr>/serialnr
+Date:		October 2014
+Contact:	Andreas Werner <andreas.werner@men.de>
+Description:
+		Show the serialnumber of the board. The serial number is
+		a decimal number.
+
+What:		/sys/bus/i2c/devices/i2c-<busnr>/<busnr>-<devaddr>/hw_name
+Date:		October 2014
+Contact:	Andreas Werner <andreas.werner@men.de>
+Description:
+		Show the name of the board including the model.
+		There are boards which have different features such as
+		different size of RAM, the model identifies the different
+		types.
+
+		Format of the hw_name is: <name><model>.
+		Example: F075P00 where F75P is the hw_name and 00 the model.
+
+What:		/sys/bus/i2c/devices/i2c-<busnr>/<busnr>-<devaddr>/prod_date
+Date:		October 2014
+Contact:	Andreas Werner <andreas.werner@men.de>
+Description:
+		Show the board production date.
+
+		Format of the date: YYYY-MM-DD
+
+What:		/sys/bus/i2c/devices/i2c-<busnr>/<busnr>-<devaddr>/rep_date
+Date:		October 2014
+Contact:	Andreas Werner <andreas.werner@men.de>
+Description:
+		Show the last repair date.
+		If the board returns back to the repair department, this field
+		will be programmed with the current date.
+		If the board has never returned, the field will be empty and
+		the read access to this sysfs entry returns -EINVAL.
+
+		Format of the date: YYYY-MM-DD
+
+What:		/sys/bus/i2c/devices/i2c-<busnr>/<busnr>-<devaddr>/user_section
+Date:		October 2014
+Contact:	Andreas Werner <andreas.werner@men.de>
+Description:
+		Read or write access to the user section of the EEPROM
+		This sysfs entry is a binary file where customer can write
+		there own data to.
+		The size of this file depends on the EEPROM layout which is
+		identified by the eeprod_id.
+
+		eeprod_id	user_section size
+		---------------------------------
+		0x0E		232 byte
-- 
2.1.0
