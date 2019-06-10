From: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [RFC PATCH 22/57] drivers: i2c: Use generic helper to match
 device by acpi_dev
Date: Mon, 10 Jun 2019 13:49:25 +0100
Message-ID: <c9a807a5-c847-7553-71a5-dff47775014a@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
 <1559577023-558-23-git-send-email-suzuki.poulose@arm.com>
 <20190606200337.GA8739@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190606200337.GA8739@kunai>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 06/06/2019 21:03, Wolfram Sang wrote:
> 
>> -	dev = bus_find_device(&i2c_bus_type, NULL, adev,
>> -			      i2c_acpi_find_match_device);
>> +	dev = bus_find_device(&i2c_bus_type, NULL, adev, device_match_acpi_dev);
> 
> In general, this looks like a nice cleanup which I am in favour of.
> However, I didn't understand why ACPI uses bus_find_device() but OF has
> a seperate helper bus_find_device_by_of_node(). Why this inconsistency
> of having a seperate helper here and not there?

This was skipped purposefully due to the header file dependency issues with
adding "acpi_bus.h" to linux/device.h, which kind of creates a circular
dependency for adding "struct acpi_device" to the prototype.

However, I think I have found a way to solve that and include that in
the next version.

Thanks
Suzuki
