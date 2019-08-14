From: Max Staudt <max@enpas.org>
Subject: Re: [PATCH v2 3/4] hwmon/ltc2990: Add platform_data support
Date: Wed, 14 Aug 2019 20:11:22 +0200
Message-ID: <a35b87c2-6bcd-fc27-ceb5-6a18c06f5cc2@enpas.org>
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

Hi Guenter,

Thanks for your feedback!
Reply below.


On 08/13/2019 03:24 PM, Guenter Roeck wrote:
> Sorry, I don't understand. Why exactly can't you replace of_property_read_u32_array()
> with device_property_read_u32_array() and use fwnode_create_software_node()
> in the calling code to set the properties ?

Thanks for this hint.

Turns out wcove is the only user of fwnode_create_software_node(), and intel_cht_int33fe is the only other driver to contain the string "software_node". Please bear with us if we didn't know about this handy trick yet. And handy it is!

device_property_read_*() is also really helpful to know about, as it covers both the DT case, as well as other firmware interfaces - thanks for the hint. Is there any reason to ever use of_property_read_*() anymore?

I've applied your suggested changes, and will send another patch round soon (I want to try one last thing). Please let me/us know what you think once it's on the list.


Max
