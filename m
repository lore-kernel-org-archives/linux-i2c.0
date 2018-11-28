From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 01/15] defconfig: enable I2C_DEBUG_CORE
Date: Wed, 28 Nov 2018 13:30:10 +0200
Message-ID: <20181128113024.42126-2-andriy.shevchenko@linux.intel.com>
References: <20181128113024.42126-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181128113024.42126-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/configs/i386_defconfig   | 1 +
 arch/x86/configs/x86_64_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index 5d362dddec0c..3bbcca9b4ed7 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -320,6 +320,7 @@ CONFIG_I2C_DESIGNWARE_PCI=y
 CONFIG_I2C_DESIGNWARE_PLATFORM=m
 CONFIG_I2C_MUX=y
 CONFIG_I2C_MULTI_INSTANTIATE=m
+CONFIG_I2C_DEBUG_CORE=y
 CONFIG_IIO=y
 CONFIG_INV_MPU6050_I2C=m
 CONFIG_GPIOLIB=y
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index 041801355a1a..15511394847e 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -318,6 +318,7 @@ CONFIG_I2C_DESIGNWARE_PCI=y
 CONFIG_I2C_DESIGNWARE_PLATFORM=m
 CONFIG_I2C_MUX=y
 CONFIG_I2C_MULTI_INSTANTIATE=m
+CONFIG_I2C_DEBUG_CORE=y
 CONFIG_IIO=y
 CONFIG_INV_MPU6050_I2C=m
 CONFIG_GPIOLIB=y
-- 
2.19.2
