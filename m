From: Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 1/2] i2c: Add Imagination Technologies I2C SCB driver
Date: Thu, 6 Nov 2014 14:21:50 -0300
Message-ID: <545BAE2E.8010608@imgtec.com>
References: <1415218919-9085-1-git-send-email-ezequiel.garcia@imgtec.com> <1415218919-9085-2-git-send-email-ezequiel.garcia@imgtec.com> <545BA6F9.3090207@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <545BA6F9.3090207-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, James Hartley <james.hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org



On 11/06/2014 01:51 PM, Vladimir Zapolskiy wrote:
> Hi Ezequiel,
> 
> On 05.11.2014 22:21, Ezequiel Garcia wrote:
>> From: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
>>
>> Add support for the IMG I2C Serial Control Bus (SCB) found on the
>> Pistachio and TZ1090 SoCs.
>>
>> Signed-off-by: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
>> [Ezequiel: code cleaning and rebasing]
>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
>> ---
>>  drivers/i2c/busses/Kconfig       |   10 +
>>  drivers/i2c/busses/Makefile      |    1 +
>>  drivers/i2c/busses/i2c-img-scb.c | 1397 ++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 1408 insertions(+)
>>  create mode 100644 drivers/i2c/busses/i2c-img-scb.c
>>
> 
> [snip]
> 
>> +static int img_i2c_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs,
>> +			int num)
>> +{
>> +	struct img_i2c *i2c = i2c_get_adapdata(i2c_adap);
>> +	bool atomic = false;
>> +	int i;
>> +
>> +	if (i2c->mode == MODE_SUSPEND) {
>> +		WARN(1, "refusing to service transaction in suspended state\n");
>> +		return -EIO;
>> +	}
>> +
>> +	if (i2c->mode == MODE_FATAL)
>> +		return -EIO;
>> +
>> +	for (i = 0; i < num; i++) {
>> +		if (likely(msgs[i].len))
>> +			continue;
>> +		/*
>> +		 * 0 byte reads are not possible because the slave could try
>> +		 * and pull the data line low, preventing a stop bit.
>> +		 */
>> +		if (unlikely(msgs[i].flags & I2C_M_RD))
>> +			return -EIO;
>> +		/*
>> +		 * 0 byte writes are possible and used for probing, but we
>> +		 * cannot do them in automatic mode, so use atomic mode
>> +		 * instead.
>> +		 */
>> +		atomic = true;
>> +	}
>> +
>> +	clk_prepare_enable(i2c->scb_clk);
> 
> Does it make sense to add a check for returned error here?
> 

Right, that makes sense.

-- 
Ezequiel
