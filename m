From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] i2c: xiic: Make the start and the byte count write atomic
Date: Fri, 7 Sep 2018 08:02:50 +0200
Message-ID: <a26d5aa1-de79-c881-da3c-5be67d1fc4a4@xilinx.com>
References: <1535967671-7784-1-git-send-email-shubhrajyoti.datta@gmail.com>
 <20180906185201.GG8607@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180906185201.GG8607@kunai>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, shubhrajyoti.datta@gmail.com
Cc: linux-i2c@vger.kernel.org, michal.simek@xilinx.com, linux-kernel@vger.kernel.org, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
List-Id: linux-i2c@vger.kernel.org

On 6.9.2018 20:52, Wolfram Sang wrote:
> On Mon, Sep 03, 2018 at 03:11:11PM +0530, shubhrajyoti.datta@gmail.com wrote:
>> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>>
>> Disable interrupts while configuring the transfer and enable them back.
>>
>> We have below as the programming sequence
>> 1. start and slave address
>> 2. byte count and stop
>>
>> In some customer platform there was a lot of interrupts between 1 and 2
>> and after slave address (around 7 clock cyles) if 2 is not executed
>> then the transaction is nacked.
>>
>> To fix this case make the 2 writes atomic.
>>
>> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> 
> Added a newline for better readability, added the stable tag and applied
> to for-current, thanks!
> 
> BTW we have no maintainer for this driver. Would you or Michal be
> interested in doing that? I don't maintain the whole driver directory
> anymore.

Normally we do handle it via Zynq fragment to have single point of
contact. I have sent a patch for that. Please take it via i2c tree.

Thanks,
Michal
