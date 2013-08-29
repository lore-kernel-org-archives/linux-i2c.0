From: Nguyen Viet Dung <nv-dung-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Subject: Re: [PATCH v3 1/1 resend] i2c: rcar: modify I2C driver
Date: Thu, 29 Aug 2013 18:46:17 +0900
Message-ID: <521F1869.1090408@jinso.co.jp>
References: <1377590122-9309-1-git-send-email-nv-dung@jinso.co.jp> <1377590122-9309-2-git-send-email-nv-dung@jinso.co.jp> <20130828090246.GC4086@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130828090246.GC4086@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

Thank your for the guide.

I have understood your guide.
And I have released version 4 of I2C patch.

Please check it for me.

Thanks,
Nguyen Viet Dung

On 08/28/2013 06:02 PM, Wolfram Sang wrote:
> On Tue, Aug 27, 2013 at 04:55:22PM +0900, Nguyen Viet Dung wrote:
>> This patch modify I2C driver of rcar-H1 to usable on both rcar-H1 and rcar-H2.
>>
>> Signed-off-by: Nguyen Viet Dung <nv-dung-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
> Yes, this is much better. Only minor things...
>
>> +	switch (priv->devtype) {
>> +	default:
>> +	case I2C_RCAR_H1:
>> +		cdf_width = 2;
>> +		break;
>> +	case I2C_RCAR_H2:
>> +		cdf_width = 3;
>> +		break;
>> +	}
>> +
> Please put the default case block at the end.
>
>> @@ -632,6 +649,13 @@ static int rcar_i2c_probe(struct platform_device *pdev)
>>   	bus_speed = 100000; /* default 100 kHz */
>>   	if (pdata && pdata->bus_speed)
>>   		bus_speed = pdata->bus_speed;
>> +
>> +	if (!pdev->id_entry) {
>> +		dev_err(&pdev->dev, "no entry\n");
>> +		return -ENODEV;
>> +	}
> This cannot happen. Since you have 'i2c-rcar' in the id_table, the
> driver core will always match against the id_table and there is always a
> driver_data defined.
>
>
>> +	priv->devtype = pdev->id_entry->driver_data;
> Basically the same, but please use
>
> 	platform_get_device_id(pdev)->driver_data;
>
> Otherwise good!
>
> Thanks,
>
>     Wolfram
