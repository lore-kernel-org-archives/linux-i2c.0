From: Mark Jackson <mpfj@mimc.co.uk>
Subject: Re: [i2c] [PATCH v2] Add support for Dallas DS28CM00 Unique ID chip
Date: Tue, 21 Oct 2008 19:42:42 +0100
Message-ID: <48FE22A2.7030604@mimc.co.uk>
References: <48FDED5E.5080605@mimc.co.uk> <20081021173505.2f7673e2@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755383AbYJUSns@vger.kernel.org>
In-Reply-To: <20081021173505.2f7673e2@hyperion.delvare>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: ben-linux@fluff.org, akpm@linux-foundation.org, i2c@lm-sensors.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Jean Delvare wrote:
> On Tue, 21 Oct 2008 15:55:26 +0100, Mark Jackson wrote:
>> This patch adds support for the (I2C based) DS28CM00 ID chip.
>> (v2 after running through checkpatch)
>>
>> Signed-off-by: M.Jackson <mpfj@mimc.co.uk> 
>> ---
>>  drivers/i2c/chips/Kconfig    |    7 ++
>>  drivers/i2c/chips/Makefile   |    1 +
>>  drivers/i2c/chips/ds28cm00.c |  166 ++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 174 insertions(+), 0 deletions(-)
> 
> Nack. No new drivers under drivers/i2c/chips please, it's going away
> soon.

Okay ... where should any new drivers be located ?

<...snip...>

>> +static int ds28cm00_attach_adapter(struct i2c_adapter *adapter);
>> +static int ds28cm00_detect(struct i2c_adapter *adapter, int address, int kind);
>> +static int ds28cm00_detach_client(struct i2c_client *client);
>> +
>> +/* This is the driver that will be inserted */
>> +static struct i2c_driver ds28cm00_driver = {
>> +	.driver = {
>> +		.name	= "ds28cm00",
>> +	},
>> +	.attach_adapter	= ds28cm00_attach_adapter,
>> +	.detach_client	= ds28cm00_detach_client,
>> +};
> 
> attach_adapter and detach_client are deprecated. Please use probe and
> remove instead.

Are there any existing chip drivers that use this new method ?

Thanks
Mark
