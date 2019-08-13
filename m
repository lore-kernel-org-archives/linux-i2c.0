From: Max <max@enpas.org>
Subject: Re: [PATCH v2 3/4] hwmon/ltc2990: Add platform_data support
Date: Tue, 13 Aug 2019 15:31:28 +0200
Message-ID: <effdad7c-9451-c281-a0b9-2cc62d392a60@enpas.org>
References: <20190812235237.21797-1-max@enpas.org>
 <20190812235237.21797-3-max@enpas.org> <20190813080237.GA29986@roeck-us.net>
 <6912362a-1f58-a9d6-f86b-d16930aa359c@enpas.org>
 <275c42b3-9a91-a73a-0696-3c5a0a344509@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <275c42b3-9a91-a73a-0696-3c5a0a344509@roeck-us.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-i2c@vger.kernel.org, linux-hwmon@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.com>, linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, glaubitz@physik.fu-berlin.de
List-Id: linux-i2c@vger.kernel.org

On 08/13/2019 03:24 PM, Guenter Roeck wrote:
> Sorry, I don't understand. Why exactly can't you replace of_property_read_u32_array()
> with device_property_read_u32_array() and use fwnode_create_software_node()
> in the calling code to set the properties ?

Sorry, I was unaware of this option. This sounds good, I'll look into it.

Max
