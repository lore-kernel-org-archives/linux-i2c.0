From: Ruslan Babayev <ruslan@babayev.com>
Subject: [net-next,v4 0/2] Enable SFP on ACPI based systems
Date: Tue, 28 May 2019 16:02:31 -0700
Message-ID: <20190528230233.26772-1-ruslan@babayev.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mika.westerberg@linux.intel.com, wsa@the-dreams.de, linux@armlinux.org.uk, andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Changes:
v2:
	- more descriptive commit body
v3:
	- made 'i2c_acpi_find_adapter_by_handle' static inline
v4:
	- don't initialize i2c_adapter to NULL. Instead see below...
	- handle the case of neither DT nor ACPI present as invalid.
	- alphabetical includes.
	- use has_acpi_companion().
	- use the same argument name in i2c_acpi_find_adapter_by_handle()
	  in both stubbed and non-stubbed cases.

Ruslan Babayev (2):
  i2c: acpi: export i2c_acpi_find_adapter_by_handle
  net: phy: sfp: enable i2c-bus detection on ACPI based systems

 drivers/i2c/i2c-core-acpi.c |  3 ++-
 drivers/net/phy/sfp.c       | 35 +++++++++++++++++++++++++++--------
 include/linux/i2c.h         |  6 ++++++
 3 files changed, 35 insertions(+), 9 deletions(-)

-- 
2.19.2
