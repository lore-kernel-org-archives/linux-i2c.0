From: David Daney <ddaney.cavm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 2/2] i2c/of: Automatically populate i2c mux busses
 from device tree data.
Date: Mon, 23 Apr 2012 09:48:40 -0700
Message-ID: <4F9587E8.1050702@gmail.com>
References: <1334265263-13549-1-git-send-email-ddaney.cavm@gmail.com> <1334265263-13549-3-git-send-email-ddaney.cavm@gmail.com> <20120422162008.GA4201@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120422162008.GA4201-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, "Jean Delvare (PC drivers core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 04/22/2012 09:20 AM, Wolfram Sang wrote:
> On Thu, Apr 12, 2012 at 02:14:23PM -0700, David Daney wrote:
>> From: David Daney<david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>>
>> For 'normal' i2c bus drivers, we can call of_i2c_register_devices()
>> and have the device tree framework automatically populate the bus with
>> the devices specified in the device tree.
>>
>> This patch adds a common code to the i2c mux framework to have the mux
>> sub-busses be populated by the of_i2c_register_devices() too.  If the
>> mux device has an of_node, we populate the sub-bus' of_node so that
>> the subsequent call to of_i2c_register_devices() will find the
>> corresponding devices.
>>
>> It seemed better to put this logic in i2c_add_mux_adapter() rather
>> than the individual mux drivers, as they will all probably want to do
>> the same thing.
>
> Both patches looking mostly good, two things here:
>
>> +	/*
>> +	 * Try to get populate the mux adapter's of_node, expands to
>
> "get populate"? I'd think you mean "populate" only, but am not sure
> enough to fix it myself.

You are correct.

>
>> +	 * nothing if !CONFIG_OF.
>> +	 */
>> +	if (mux_dev->of_node) {
>> +		struct device_node *child;
>> +		u32 reg;
>> +		int ret;
>
> We have a "ret" already in this function.
>

Good catch.  That definition of "ret" could (and should) be removed. 
The code works correctly, but fails the elegance test.

I can send a new patch set with those corrections, or if you prefer, you 
could commit these making the changes yourself.

Which do you prefer?

David Daney
