From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH V4] i2c: designware: fix wrong Tx/Rx FIFO for ACPI
Date: Tue, 13 Dec 2016 15:35:57 +0200
Message-ID: <d2853af4-d8ea-e1ff-fcf8-b4aa73c0afd0@linux.intel.com>
References: <1481623414-19220-1-git-send-email-tnhuynh@apm.com>
 <1481628337.7188.63.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1481628337.7188.63.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tin Huynh <tnhuynh@apm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Loc Ho <lho@apm.com>, Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>, patches@apm.com
List-Id: linux-i2c@vger.kernel.org

On 12/13/2016 01:25 PM, Andy Shevchenko wrote:
> On Tue, 2016-12-13 at 17:03 +0700, Tin Huynh wrote:
>> ACPI always sets Tx/Rx FIFO to 32. This configuration will
>> cause problem if the IP core supports a FIFO size of less than 32.
>> The driver should read the FIFO size from the IP and select the
>> smaller
>> one of the two.
>>
>> Signed-off-by: Tin Huynh <tnhuynh@apm.com>
>>
>
> One comment below, after addressing it
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
Feel free to add my

Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
