From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: Re: [PATCH 1/3] i2c: convert SMBus alert setup function to return an
 ERRPTR
Date: Mon, 17 Feb 2020 10:14:52 +0100
Message-ID: <64a14944-ed27-9f4f-6d1b-e31508c92692@lucaceresoli.net>
References: <20200210172929.6001-1-wsa+renesas@sang-engineering.com>
 <20200210172929.6001-2-wsa+renesas@sang-engineering.com>
 <20200217075837.2agub5deqdpet3ce@rric.localdomain>
 <20200217081758.GA2814@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:36888 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728272AbgBQJPQ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 17 Feb 2020 04:15:16 -0500
In-Reply-To: <20200217081758.GA2814@ninjato>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Robert Richter <rrichter@marvell.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Phil Reid <preid@electromag.com.au>, Jean Delvare <jdelvare@suse.com>, George Cherian <gcherian@marvell.com>, linux-kernel@vger.kernel.org

Hi,

On 17/02/20 09:17, Wolfram Sang wrote:
> 
>>> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>>
>>> -struct i2c_client *i2c_setup_smbus_alert(struct i2c_adapter *adapter,
>>> +struct i2c_client *i2c_install_smbus_alert(struct i2c_adapter *adapter,
>>>  					 struct i2c_smbus_alert_setup *setup);
>>
>> This function naming is a bit odd. It creates a struct i2c_client.
>> Then, there is also i2c_new_client_device() and i2c_new_device(). For
>> i2c_new_client_device() there are no users at all outside of
>> i2c-core-base.c (except for Falcon NIC), it is only a wrapper.
> 
> i2c_new_device (and friends) returned NULL on error. I am currently
> converting all i2c_new_* functions to return an ERRPTR. So,
> i2c_new_client_device is the new function, i2c_new_device is deprecated.
> If you check v5.6-rc1, you will find many more users. Similarily,
> i2c_new_dummy is deprecated (and removed already), i2c_new_dummy_device
> is the new thing.
> 
>> So how about reducing the interface to those both only to:?
>>
>>  i2c_new_device()
>>  i2c_new_device_smbus()
> 
> Given the above, it would be:
> 
> 	i2c_new_client_device()
> 	i2c_new_smbus_device()
> 
> Yet, I think this is too vague. Maybe
> 
> 	i2c_new_smbus_alert_device()

I always found the function naming a bit messy in the linux i2c
implementation. Among the names proposed in this thread,
i2c_new_smbus_alert_device() is the only one that makes sense to me for
the new function: it is not vague, and it is coherent with other names
of recently introduced functions (i2c_new_*_device()). Of course the
"alert device" is not a real device, but it looks like it is as it has
its own "slave" address. So I vote for this name...

> ? Note that I never used SMBus Alert, so I am happy for feedback from
> people actually using it.

...but that said, I'm afraid I'm not using smbus alert.

My 2c,
-- 
Luca
