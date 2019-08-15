From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 2/3] hwmon/ltc2990: Generalise DT to fwnode support
Date: Thu, 15 Aug 2019 11:33:00 -0700
Message-ID: <20190815183300.GA18227@roeck-us.net>
References: <20190815125802.16500-1-max@enpas.org>
 <20190815125802.16500-2-max@enpas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190815125802.16500-2-max@enpas.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Max Staudt <max@enpas.org>
Cc: linux-i2c@vger.kernel.org, linux-hwmon@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.com>, linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, glaubitz@physik.fu-berlin.de
List-Id: linux-i2c@vger.kernel.org

On Thu, Aug 15, 2019 at 02:58:01PM +0200, Max Staudt wrote:
> ltc2990 will now use device_property_read_u32_array() instead of
> of_property_read_u32_array() - allowing the use of software nodes
> via fwnode_create_software_node().
> 
> This allows code using i2c_new_device() to specify a default
> measurement mode for the LTC2990.
> 
> Signed-off-by: Max Staudt <max@enpas.org>

Applied to hwmon-next.

Thanks,
Guenter
