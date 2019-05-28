From: Ruslan Babayev <ruslan@babayev.com>
Subject: [net-next,v3 0/2] Enable SFP on ACPI based systems
Date: Mon, 27 May 2019 20:22:11 -0700
Message-ID: <20190528032213.19839-1-ruslan@babayev.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mika.westerberg@linux.intel.com, wsa@the-dreams.de, linux@armlinux.org.uk, andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Changes:
v2: more descriptive commit body
v3: made 'i2c_acpi_find_adapter_by_handle' static inline

Ruslan Babayev (2):
  i2c: acpi: export i2c_acpi_find_adapter_by_handle
  net: phy: sfp: enable i2c-bus detection on ACPI based systems

 drivers/i2c/i2c-core-acpi.c |  3 ++-
 drivers/net/phy/sfp.c       | 33 +++++++++++++++++++++++++--------
 include/linux/i2c.h         |  6 ++++++
 3 files changed, 33 insertions(+), 9 deletions(-)

-- 
2.19.2
