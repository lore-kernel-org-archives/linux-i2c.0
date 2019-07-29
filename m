From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] i2c: busses: Use dev_get_drvdata where possible
Date: Mon, 29 Jul 2019 16:23:38 +0300
Message-ID: <c58ef749-fae3-8df5-2d20-59d766256409@linux.intel.com>
References: <20190723111110.11121-1-hslester96@gmail.com>
 <20190723203452.5714f142@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190723203452.5714f142@endymion>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>, Chuhong Yuan <hslester96@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 7/23/19 9:34 PM, Jean Delvare wrote:
> On Tue, 23 Jul 2019 19:11:10 +0800, Chuhong Yuan wrote:
>> Instead of using to_pci_dev + pci_get_drvdata,
>> use dev_get_drvdata to make code simpler.
>>
>> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
>> ---
>>   drivers/i2c/busses/i2c-designware-pcidrv.c | 6 ++----
>>   drivers/i2c/busses/i2c-i801.c              | 3 +--
>>   2 files changed, 3 insertions(+), 6 deletions(-)
>> (...)
> 
> Looks good to me, thanks.
> 
> Reviewed-by: Jean Delvare <jdelvare@suse.de>
> 
For the i2c-designware-pcidrv.c

Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
