From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [net-next,v4 1/2] i2c: acpi: export
 i2c_acpi_find_adapter_by_handle
Date: Wed, 29 May 2019 17:49:08 +0200
Message-ID: <20190529154908.GX18059@lunn.ch>
References: <20190528230233.26772-1-ruslan@babayev.com>
 <20190528230233.26772-2-ruslan@babayev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190528230233.26772-2-ruslan@babayev.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ruslan Babayev <ruslan@babayev.com>
Cc: mika.westerberg@linux.intel.com, wsa@the-dreams.de, linux@armlinux.org.uk, f.fainelli@gmail.com, hkallweit1@gmail.com, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, xe-linux-external@cisco.com
List-Id: linux-i2c@vger.kernel.org

On Tue, May 28, 2019 at 04:02:32PM -0700, Ruslan Babayev wrote:
> This allows drivers to lookup i2c adapters on ACPI based systems similar to
> of_get_i2c_adapter_by_node() with DT based systems.
> 
> Signed-off-by: Ruslan Babayev <ruslan@babayev.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
