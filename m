From: Max Staudt <max@enpas.org>
Subject: Re: [PATCH v5 2/3] hwmon/ltc2990: Generalise DT to fwnode support
Date: Tue, 20 Aug 2019 17:08:38 +0200
Message-ID: <5aebf319-c958-da62-a232-c3851f8b47b9@enpas.org>
References: <20190819121618.16557-1-max@enpas.org>
 <20190819121618.16557-2-max@enpas.org> <20190820150735.GA12198@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190820150735.GA12198@roeck-us.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-i2c@vger.kernel.org, linux-hwmon@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.com>, linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, glaubitz@physik.fu-berlin.de
List-Id: linux-i2c@vger.kernel.org

On 08/20/2019 05:07 PM, Guenter Roeck wrote:
> On Mon, Aug 19, 2019 at 02:16:17PM +0200, Max Staudt wrote:
>> ltc2990 will now use device_property_read_u32_array() instead of
>> of_property_read_u32_array() - allowing the use of software nodes
>> via fwnode_create_software_node().
>>
>> This allows code using i2c_new_device() to specify a default
>> measurement mode for the LTC2990 via fwnode_create_software_node().
>>
>> Signed-off-by: Max Staudt <max@enpas.org>
>> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> Applied to hwmon-next.
> 
> Thanks,
> Guenter

Thanks for your help, reviewing, and applying!

Max
