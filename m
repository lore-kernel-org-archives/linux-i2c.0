From: Ruslan Babayev <ruslan@babayev.com>
Subject: Enable SFP driver on ACPI based systems
Date: Sun,  5 May 2019 15:05:21 -0700
Message-ID: <20190505220524.37266-1-ruslan@babayev.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@armlinux.org.uk, andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, Andrew Morton <akpm@linux-foundation.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

I have split the patch and resending to all relevant mailing lists as
requested by Heiner Kallweit.


[PATCH net-next 1/2] i2c: acpi: export
[PATCH net-next 2/2] net: phy: sfp: enable i2c-bus detection on ACPI
