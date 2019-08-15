From: Max Staudt <max@enpas.org>
Subject: Re: [PATCH v3 2/3] hwmon/ltc2990: Generalise DT to fwnode support
Date: Thu, 15 Aug 2019 23:34:01 +0200
Message-ID: <a0f06836-52b1-0302-8044-272df63b339f@enpas.org>
References: <20190815125802.16500-1-max@enpas.org>
 <20190815125802.16500-2-max@enpas.org> <20190815183300.GA18227@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190815183300.GA18227@roeck-us.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-i2c@vger.kernel.org, linux-hwmon@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.com>, linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, glaubitz@physik.fu-berlin.de
List-Id: linux-i2c@vger.kernel.org

On 08/15/2019 08:33 PM, Guenter Roeck wrote:
> On Thu, Aug 15, 2019 at 02:58:01PM +0200, Max Staudt wrote:
>> ltc2990 will now use device_property_read_u32_array() instead of
>> of_property_read_u32_array() - allowing the use of software nodes
>> via fwnode_create_software_node().
>>
>> This allows code using i2c_new_device() to specify a default
>> measurement mode for the LTC2990.
>>
>> Signed-off-by: Max Staudt <max@enpas.org>
> 
> Applied to hwmon-next.

Hi Guenter,

Thank you for reviewing and taking this patch, as well as teaching me about swnode.


Max
