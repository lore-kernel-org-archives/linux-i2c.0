From: David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/5] i2c: Convert i2c-octeon.c to use device tree.
Date: Wed, 18 Apr 2012 09:20:28 -0700
Message-ID: <4F8EE9CC.20000@cavium.com>
References: <1332808075-8333-1-git-send-email-ddaney.cavm@gmail.com> <1332808075-8333-2-git-send-email-ddaney.cavm@gmail.com> <4F7115FA.6080507@gmail.com> <4F7117FD.7000700@cavium.com> <20120418151621.GF19802@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120418151621.GF19802-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Daney <ddaney.cavm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org" <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, "ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org" <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 04/18/2012 08:16 AM, Wolfram Sang wrote:
>>>> -	if (i2c_data == NULL) {
>>>> -		dev_err(i2c->dev, "no I2C frequency data\n");
>>>> +	/*
>>>> +	 * "clock-rate" is a legacy binding, the official binding is
>>>> +	 * "clock-frequency".  Try the official one first and then
>>>> +	 * fall back if it doesn't exist.
>>>> +	 */
>>>> +	data = of_get_property(pdev->dev.of_node, "clock-frequency",&len);
>>>> +	if (!data || len != sizeof(*data))
>>>> +		data = of_get_property(pdev->dev.of_node, "clock-rate",&len);
>>>> +	if (data&&   len == sizeof(*data)) {
>>>> +		i2c->twsi_freq = be32_to_cpup(data);
>>>
>>> Can't you use of_property_read_u32?
>>
>> I will investigate, and use it if possible.
>
> Any outcome?

Yes, I have implemented Rob's suggestions.  A new patch set reflecting 
this is coming soon.

>
> And shouldn't the bindings be documented? Or are they only standard and
> we hide the legacy one?
>

Yes, they are documented here:

http://patchwork.linux-mips.org/patch/3536/

look in the cavium-i2c.txt file.

Thanks,
David Daney
