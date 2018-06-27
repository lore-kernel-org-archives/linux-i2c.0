From: Eddie James <eajames@linux.vnet.ibm.com>
Subject: Re: [PATCH v10 5/7] i2c: fsi: Add transfer implementation
Date: Wed, 27 Jun 2018 08:21:30 -0500
Message-ID: <6713efb9-c4c3-f648-a1e9-7918110091e4@linux.vnet.ibm.com>
References: <1528918579-27602-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1528918579-27602-6-git-send-email-eajames@linux.vnet.ibm.com>
 <20180626023823.i3fmdegn2sric5kx@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180626023823.i3fmdegn2sric5kx@ninjato>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, benh@kernel.crashing.org, joel@jms.id.au, mark.rutland@arm.com, gregkh@linuxfoundation.org, rdunlap@infradead.org, andy.shevchenko@gmail.com, peda@axentia.se
List-Id: linux-i2c@vger.kernel.org



On 06/25/2018 09:38 PM, Wolfram Sang wrote:
> On Wed, Jun 13, 2018 at 02:36:17PM -0500, Eddie James wrote:
>> Execute I2C transfers from the FSI-attached I2C master. Use polling
>> instead of interrupts as we have no hardware IRQ over FSI.
>>
>> Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
>> ---
>>   drivers/i2c/busses/i2c-fsi.c | 195 ++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 193 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
>> index 4611a0b..8c0a6cb 100644
>> --- a/drivers/i2c/busses/i2c-fsi.c
>> +++ b/drivers/i2c/busses/i2c-fsi.c
>> @@ -155,6 +155,7 @@ struct fsi_i2c_port {
>>   	struct i2c_adapter	adapter;
>>   	struct fsi_i2c_master	*master;
>>   	u16			port;
>> +	u16			xfrd;
>>   };
>>   
>>   static int fsi_i2c_read_reg(struct fsi_device *fsi, unsigned int reg,
>> @@ -230,6 +231,99 @@ static int fsi_i2c_set_port(struct fsi_i2c_port *port)
>>   	return fsi_i2c_write_reg(fsi, I2C_FSI_RESET_ERR, &dummy);
>>   }
>>   
>> +static int fsi_i2c_start(struct fsi_i2c_port *port, struct i2c_msg *msg,
>> +			 bool stop)
>> +{
>> +	struct fsi_i2c_master *i2c = port->master;
>> +	u32 cmd = I2C_CMD_WITH_START | I2C_CMD_WITH_ADDR;
>> +
>> +	port->xfrd = 0;
>> +
>> +	if (msg->flags & I2C_M_RD)
>> +		cmd |= I2C_CMD_READ;
> Since you support MANGLING, I'd think you can easily support
> I2C_M_REV_DIR_ADDR here, too?

Hm, I don't really understand the purpose of that flag. From the docs:

This toggles the Rd/Wr flag. That is, if you want to do a write, but
     need to emit an Rd instead of a Wr, or vice versa, you set this
     flag. For example:
S Addr Rd [A] Data [A] Data [A] ... [A] Data [A] P

I don't think our hardware supports this type of operation.

Thanks,
Eddie

>
