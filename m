Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA05324B1E;
	Mon, 16 Mar 2026 16:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773678544; cv=none; b=hw3O0+XKHoM977CUFfMwCPf8XHo0nNr6Go0Zq3EkGebea71Qb3gDE7vGUBI+e9WpOjX/nSzIpooOXz9x9NnPZuXcrW3y6NE/dpiNX7hSiDMamfGZ4uzaigNBPQwT/0arYojGPdb+zRA82YCIlZPO13Las0mR5hOHCda4693SdAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773678544; c=relaxed/simple;
	bh=xGy5Xa1dQr/5pfh8pXxYijxQkHbJMOii4GfmIYyf+38=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=d5hyXBZ1nq+vgqhpoH9yZXCqrQL6ogMDYaJ4+6FJKrDULFpb6NKOkpWFU1lDoSAeG6G0jYkXSf/qmKD06bzdOg6BG/gwvM5IyZPLs0x+TW7fQNgA6tVUcSkHdfAnVkcRQPr5/AOuL+ZWR4s9r3yc0pnkk7MY2pfWaK9YTarOCIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Ie4vuMdT; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Ie4vuMdT"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id E22CE270D2;
	Mon, 16 Mar 2026 17:28:53 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SynF4M5Uyg-P; Mon, 16 Mar 2026 17:28:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1773678533; bh=xGy5Xa1dQr/5pfh8pXxYijxQkHbJMOii4GfmIYyf+38=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ie4vuMdTynPHxBbYmYEBuDW7mJeUD3XImKyeyF4lQt/cBYK67N+aInW0Oi0W0lCuU
	 WpWPKeM8EiasvfX+Du9QVE78IKw73bQkvrcQwALu1IJszLZmp0grbPfoVZJLsvXuOg
	 FsE3NZmnQ7H/2U8dmFn+ZKzD96beO4Oa3M727guddGlUqpW+ULnk1bJRVq9vapih3b
	 CuTqCqY6oXhYLGwr5iHowS8KLFH5aOpMXc51seKJM1xB/0X4vG+EhzJ62pPIu/48br
	 ADe0uqEtxqeum+bP6sIsj/0BBhtX7hKM8/3es0g4+QplAFY7ua5tEmNRWlLdElNjCm
	 8aT2DPnp6bplA==
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Mar 2026 16:28:52 +0000
From: Rustam Adilov <adilov@disroot.org>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] i2c: rtl9300: introduce a property for 8 bit width
 reg address
In-Reply-To: <d91f5897-c565-4574-81e4-5b0624da2766@alliedtelesis.co.nz>
References: <20260314082628.25206-1-adilov@disroot.org>
 <20260314082628.25206-5-adilov@disroot.org>
 <d91f5897-c565-4574-81e4-5b0624da2766@alliedtelesis.co.nz>
Message-ID: <c03ba2a5b0fa3ee0714d9e6cf475a1c6@disroot.org>
X-Sender: adilov@disroot.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello,
On 2026-03-15 21:31, Chris Packham wrote:
> Hi Rustam,
> 
> (sorry I might have prematurely hit send on an earlier reply)
> 
> On 14/03/2026 21:26, Rustam Adilov wrote:
>> In RTL9607C i2c controller, in order to indicate that the width of
>> memory address is 8 bits, 0 is written to MEM_ADDR_WIDTH field as
>> opposed to 1 for RTL9300 and RTL9310.
>>
>> Introduce a new property to a driver data to indicate what value
>> need to written to MEM_ADDR_WIDTH field for this case.
>>
>> Signed-off-by: Rustam Adilov <adilov@disroot.org>
>> ---
>>   drivers/i2c/busses/i2c-rtl9300.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-rtl9300.c b/drivers/i2c/busses/i2c-rtl9300.c
>> index 2525b57a9d03..86a82f2c3ce0 100644
>> --- a/drivers/i2c/busses/i2c-rtl9300.c
>> +++ b/drivers/i2c/busses/i2c-rtl9300.c
>> @@ -60,6 +60,7 @@ struct rtl9300_i2c_drv_data {
>>   	u32 wd_reg;
>>   	u8 max_nchan;
>>   	u8 max_data_len;
>> +	u8 reg_addr_8bit_len;
>>   };
>>   
>>   #define RTL9300_I2C_MUX_NCHAN	8
>> @@ -105,6 +106,7 @@ struct rtl9300_i2c_xfer {
>>   #define RTL9300_I2C_MST_DATA_WORD2			0x10
>>   #define RTL9300_I2C_MST_DATA_WORD3			0x14
>>   #define RTL9300_I2C_MST_GLB_CTRL			0x384
>> +#define RTL9300_REG_ADDR_8BIT_LEN			1
>>   
>>   #define RTL9310_I2C_MST_IF_CTRL				0x1004
>>   #define RTL9310_I2C_MST_IF_SEL				0x1008
>> @@ -299,6 +301,7 @@ static int rtl9300_i2c_smbus_xfer(struct i2c_adapter *adap, u16 addr, unsigned s
>>   				  union i2c_smbus_data *data)
>>   {
>>   	struct rtl9300_i2c_chan *chan = i2c_get_adapdata(adap);
>> +	const struct rtl9300_i2c_drv_data *drv_data;
>>   	struct rtl9300_i2c *i2c = chan->i2c;
>>   	struct rtl9300_i2c_xfer xfer = {0};
>>   	int ret;
>> @@ -308,6 +311,7 @@ static int rtl9300_i2c_smbus_xfer(struct i2c_adapter *adap, u16 addr, unsigned s
>>   
>>   	guard(rtl9300_i2c)(i2c);
>>   
>> +	drv_data = device_get_match_data(i2c->dev);
>>   	ret = rtl9300_i2c_config_chan(i2c, chan);
>>   	if (ret)
>>   		return ret;
>> @@ -315,7 +319,7 @@ static int rtl9300_i2c_smbus_xfer(struct i2c_adapter *adap, u16 addr, unsigned s
>>   	xfer.dev_addr = addr & 0x7f;
>>   	xfer.write = (read_write == I2C_SMBUS_WRITE);
>>   	xfer.reg_addr = command;
>> -	xfer.reg_addr_len = 1;
>> +	xfer.reg_addr_len = drv_data->reg_addr_8bit_len;
> 
> For this one I wonder if we could come up with something that involves a 
> subtraction for the rtl9607? len = 1 just makes sense to me so maybe 
> RTL_9300_ADDR_LEN(1) which expands to 1 - 0 on the rtl9300 and 1 - 1 on 
> the rtl9607 would be easier to follow.

I am not entirely sure i understand this approach. Is RTL_9300_ADDR_LEN(1)
gonna be a "#define"? Would like to know before i proceed with possible
changes for v2.

And wouldn't something like this work just as well:

xfer.reg_addr_len = 1 - drv_data->subtract_len;

But then, i honestly think "drv_data->reg_addr_8bit_len" would be a bit less
cluttery?

> Not a deal breaker just thought I'd mention it.
> 
>>   
>>   	switch (size) {
>>   	case I2C_SMBUS_BYTE:
>> @@ -501,6 +505,7 @@ static const struct rtl9300_i2c_drv_data rtl9300_i2c_drv_data = {
>>   	.wd_reg = RTL9300_I2C_MST_DATA_WORD0,
>>   	.max_nchan = RTL9300_I2C_MUX_NCHAN,
>>   	.max_data_len = RTL9300_I2C_MAX_DATA_LEN,
>> +	.reg_addr_8bit_len = RTL9300_REG_ADDR_8BIT_LEN,
>>   };
>>   
>>   static const struct rtl9300_i2c_drv_data rtl9310_i2c_drv_data = {
>> @@ -524,6 +529,7 @@ static const struct rtl9300_i2c_drv_data rtl9310_i2c_drv_data = {
>>   	.wd_reg = RTL9310_I2C_MST_DATA_CTRL,
>>   	.max_nchan = RTL9310_I2C_MUX_NCHAN,
>>   	.max_data_len = RTL9300_I2C_MAX_DATA_LEN,
>> +	.reg_addr_8bit_len = RTL9300_REG_ADDR_8BIT_LEN,
>>   };
>>   
>>   static const struct of_device_id i2c_rtl9300_dt_ids[] = {
