From: Eduardo Valentin <eduval@amazon.com>
Subject: [PATCHv7 3/3] Documentation: ABI: Add i2c-slave-mqueue sysfs documentation
Date: Wed, 5 Jun 2019 09:46:51 -0700
Message-ID: <20190605164651.15991-4-eduval@amazon.com>
References: <20190605164651.15991-1-eduval@amazon.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190605164651.15991-1-eduval@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Haiyue Wang <haiyue.wang@linux.intel.com>, jarkko.nikula@linux.intel.com, andriy.shevchenko@intel.com, brendanhiggins@google.com, Eduardo Valentin <eduval@amazon.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Document the slave-mqueue sysfs attribute used by
the i2c-slave-mqueue driver.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <eduval@amazon.com>
---

changes from V6 to V7:
- none

 .../ABI/testing/sysfs-bus-i2c-devices-slave-mqueue     | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-i2c-devices-slave-mqueue

diff --git a/Documentation/ABI/testing/sysfs-bus-i2c-devices-slave-mqueue b/Documentation/ABI/testing/sysfs-bus-i2c-devices-slave-mqueue
new file mode 100644
index 000000000000..28318108ce85
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-i2c-devices-slave-mqueue
@@ -0,0 +1,10 @@
+What:		/sys/bus/i2c/devices/*/slave-mqueue
+Date:		May 2019
+KernelVersion:	5.2
+Contact:	Eduardo Valentin <eduval@amazon.com>
+Description:
+		Reading to this file will return exactly one message,
+		when available, of the i2c-slave-mqueue device attached
+		to that bus. Userspace can also poll on this file to
+		get notified when new messages are available.
+Users:		i2c-slave-mqueue driver
-- 
2.21.0
