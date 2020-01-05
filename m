From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: [PATCH 22/26] docs: i2c: instantiating-devices: use monospace for filenames
Date: Sun,  5 Jan 2020 23:50:08 +0100
Message-ID: <20200105225012.11701-22-luca@lucaceresoli.net>
References: <20200105224006.10321-1-luca@lucaceresoli.net>
 <20200105225012.11701-1-luca@lucaceresoli.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200105225012.11701-1-luca@lucaceresoli.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: Luca Ceresoli <luca@lucaceresoli.net>, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Use a monospace (literal) formatting for better readability of filenames.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 Documentation/i2c/instantiating-devices.rst | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/i2c/instantiating-devices.rst b/Documentation/i2c/instantiating-devices.rst
index cbcafb36b417..f06d44c5b692 100644
--- a/Documentation/i2c/instantiating-devices.rst
+++ b/Documentation/i2c/instantiating-devices.rst
@@ -224,15 +224,15 @@ In general, the kernel should know which I2C devices are connected and
 what addresses they live at. However, in certain cases, it does not, so a
 sysfs interface was added to let the user provide the information. This
 interface is made of 2 attribute files which are created in every I2C bus
-directory: new_device and delete_device. Both files are write only and you
-must write the right parameters to them in order to properly instantiate,
-respectively delete, an I2C device.
+directory: ``new_device`` and ``delete_device``. Both files are write
+only and you must write the right parameters to them in order to properly
+instantiate, respectively delete, an I2C device.
 
-File new_device takes 2 parameters: the name of the I2C device (a string)
-and the address of the I2C device (a number, typically expressed in
-hexadecimal starting with 0x, but can also be expressed in decimal.)
+File ``new_device`` takes 2 parameters: the name of the I2C device (a
+string) and the address of the I2C device (a number, typically expressed
+in hexadecimal starting with 0x, but can also be expressed in decimal.)
 
-File delete_device takes a single parameter: the address of the I2C
+File ``delete_device`` takes a single parameter: the address of the I2C
 device. As no two devices can live at the same address on a given I2C
 segment, the address is sufficient to uniquely identify the device to be
 deleted.
-- 
2.24.1
