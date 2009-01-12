From: Darius <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] iMX/MXC support for I2C
Date: Mon, 12 Jan 2009 16:29:00 +0200
Message-ID: <gkfnji$uo4$2@ger.gmane.org>
References: <493CF201.8030406@gmail.com> <20081216213455.GC8032@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20081216213455.GC8032-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Ben Dooks wrote:

>> +static void __init i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx,
>> +							unsigned int rate)
>> +{
>> +	unsigned int i2c_clk_rate;
>> +	unsigned int div;
>> +	int i;
>> +
>> +	/* Divider value calculation */
>> +	i2c_clk_rate = clk_get_rate(i2c_imx->clk);
>> +	div = (i2c_clk_rate + rate - 1) / rate;
>> +	if (div < i2c_clk_div[0][0])
>> +		i = 0;
>> +	else if (div > i2c_clk_div[ARRAY_SIZE(i2c_clk_div) - 1][0])
>> +		i = ARRAY_SIZE(i2c_clk_div) - 1;
>> +	else
>> +		for (i = 0; i2c_clk_div[i][0] < div; i++);
> 
> I'm not sure if I really like the use of
> 'i2c_clk_div[ARRAY_SIZE(i2c_clk_div) - 1]; a lot, I'll see if I
> can think of anything better.
> 

How about this? I think it's ok?
I'd like to prepare ready version for adding to mainline.
