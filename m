From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] net: phy: sfp: enable i2c-bus detection on ACPI based
 systems
Date: Sun, 5 May 2019 21:51:15 +0200
Message-ID: <085da32a-8c3a-bf91-38b0-4802375ae414@gmail.com>
References: <20190505193435.3248-1-ruslan@babayev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190505193435.3248-1-ruslan@babayev.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Ruslan Babayev <ruslan@babayev.com>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>
Cc: xe-linux-external@cisco.com, "David S. Miller" <davem@davemloft.net>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 05.05.2019 21:34, Ruslan Babayev wrote:
> Signed-off-by: Ruslan Babayev <ruslan@babayev.com>
> Cc: xe-linux-external@cisco.com
> ---
>  drivers/i2c/i2c-core-acpi.c |  3 ++-
>  drivers/net/phy/sfp.c       | 33 +++++++++++++++++++++++++--------
>  include/linux/i2c.h         |  6 ++++++
>  3 files changed, 33 insertions(+), 9 deletions(-)
> 
Regarding the formal part:
- It should be [PATCH net-next]
- Commit description is missing (scripts/checkpatch.pl should have complained)

And maybe it would be better to split exporting i2c_acpi_find_adapter_by_handle
and extending sfp.c to two patches. If Wolfram acks the i2c patch, then I think
the series could go through the netdev tree. Eventually up to David.
