From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v3 3/3] i2c: designware: select gpio/default pin when
 prepare/unprepare recovery
Date: Tue, 18 Sep 2018 16:25:18 +0300
Message-ID: <8160d36b-2fb5-c037-893c-c23568a9f6ac@linux.intel.com>
References: <20180917112633.252c591c@xhacker.debian>
 <20180917112949.414dd56f@xhacker.debian>
 <20180917113418.16881f6c@xhacker.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180917113418.16881f6c@xhacker.debian>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 09/17/2018 06:34 AM, Jisheng Zhang wrote:
> + DT maintainers
> 
> On Mon, 17 Sep 2018 11:29:49 +0800
> Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
> 
>> On some platforms, the sda/scl pins are muxed with gpio functions, so
>> they could be used for recovery. Select the gpio/default pin function
>> when prepare/unprepare recovery.
>>
>> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
>> ---
>>   drivers/i2c/busses/i2c-designware-core.h   |  3 +++
>>   drivers/i2c/busses/i2c-designware-master.c | 22 ++++++++++++++++++++++
>>   2 files changed, 25 insertions(+)
>>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
