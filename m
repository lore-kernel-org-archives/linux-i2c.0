From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 02/12] i2c: designware-master: use core to detect 'no zero
 length' quirk
Date: Thu, 2 Aug 2018 17:00:59 +0300
Message-ID: <db46f7ba-0627-eb0b-9a93-40f26a82b0bf@linux.intel.com>
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
 <20180723202617.15230-3-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180723202617.15230-3-wsa+renesas@sang-engineering.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 07/23/2018 11:26 PM, Wolfram Sang wrote:
> And don't reimplement in the driver.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Only build tested.
> 
>   drivers/i2c/busses/i2c-designware-master.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
I tested this with patch 1 and I like it since with these patches the 
test is done before firing up the HW, waiting for an interrupt and then 
see the length is invalid for us.

i2ctransfer -f 8 r0@0x10

Before (with i2c_designware debugging on):
[   15.607283] i2c_designware i2c_designware.1: i2c_dw_xfer: msgs: 1
[   15.711988] i2c_designware i2c_designware.1: enabled=0x1 stat=0x10
[   15.712002] i2c_designware i2c_designware.1: i2c_dw_xfer_msg: invalid 
message length
Error: Sending messages failed: Invalid argument

After:
[   25.838661] i2c i2c-8: adapter quirk: no zero length (addr 0x0010, 
size 0, read)
Error: Sending messages failed: Operation not supported

Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
