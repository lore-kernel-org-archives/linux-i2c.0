From: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC]: Supporting PIO mode of operation in i2c_msg->flags
Date: Tue, 16 Jun 2015 14:26:09 +0530
Message-ID: <557FE4A9.5030004@linaro.org>
References: <5562EF9D.1090403@linaro.org> <20150611234118.GA1534@katana> <557D6FAF.1050408@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <557D6FAF.1050408-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org



On Sunday 14 June 2015 05:42 PM, Vaibhav Hiremath wrote:
>
>
> On Friday 12 June 2015 05:11 AM, Wolfram Sang wrote:
>>> Current implementation:
>>> --------------------
>>>
>>> Everyone probably does have their own custom implementation for this.
>>> Or some other mechanism to achieve this (may be hardware support).
>>
>> Do you have examples? It is easier to look at code.
>>
>
> As I mentioned in the "Problem Statement",
>
> I2C interface for PMIC may need to be used at the end of poweroff
> sequence where you cannot afford to sleep/schedule, as interrupt has
> been disabled.
>
> Earlier I was working on OMAP platform, where I remember we had
> implemented something for such requirement, but as I am not in TI
> anymore, I can not access the internal code.
>
> Let me check whether I can share the current marvell codebase
> outside.
>
>
>>> /* We can also check i2c_check_functionality(adap,I2C_FUNC_PIO) */
>>>     if (msg->flags & I2C_M_PIO) {
>>>         /* PIO mode operation */
>>>     } else {
>>>         /* non-pio mode of operation */
>>>     }
>>
>> I'd rather let the core decide. Like introduce a master_xfer_nosleep
>> callback and let the core use the standard or the nosleep one. We'd need
>> the same for smbus as well.
>>
>> This leads to the question if we need a M_FLAG or expose the *_nosleep
>> functions directly?
>>
>
> I thought of it, but did not convince myself after looking at the usage
> of this. This function would be used only when interrupt is disabled.
>
>
>> And I wonder about the demand for it. There are a number of SoCs with
>> designated I2C cores for the PMIC which do automated transfers.
>>
>
> This is exactly the same reason I did not propose it as a core change.
> as I feel that the use of this is very minimal and with M_FLAG driver
> can very well handle it.
>

Wolfram,

Any update on this?

If we could close on this, I can quickly change the code and submit the
patch for review.

Thanks,
Vaibhav
