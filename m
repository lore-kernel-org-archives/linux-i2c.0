From: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [Patch V2 5/9] I2C: Add smbus quick read/write helper function
Date: Sat, 17 May 2014 21:13:35 +0800
Message-ID: <5377607F.9010800@intel.com>
References: <1398147855-9868-1-git-send-email-tianyu.lan@intel.com> <1398695268-28645-1-git-send-email-tianyu.lan@intel.com> <1398695268-28645-6-git-send-email-tianyu.lan@intel.com> <20140517094120.GA2602@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140517094120.GA2602@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, awilliam-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 05/17/2014 05:41 PM, Wolfram Sang wrote:
> On Mon, Apr 28, 2014 at 10:27:44PM +0800, Lan Tianyu wrote:
>> Add i2c_smbus_quick_write/read() helper function. These will be used
>> in the implementation of i2c ACPI address space handler.
>>
>> Reviewed-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> Signed-off-by: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>
> We had such a function once but removed because of no users. Please
> check 67c2e66571c383404a5acd08189194da660da942 what it takes to bring
> them back. Especially missing are documentation updates...
>
>> +s32 i2c_smbus_quick_write(const struct i2c_client *client)
>
> ... and I like the original function much better.
>
> 1) It is named *_write_quick which follows other function name patterns
> 2) It uses a parameter for the r/w bit. Make sense to me, since this bit
> is the information we send to the device. quick_read doesn't make sense
> to me. We don't receive a bit from the device.
>

Hi Wolfram:
	Great thanks for your review. Ok. I will follow commit 67c2e665 to bring 
i2c_smbus_write_quick(struct i2c_client *client, u8 value) back.

BTW, how about i2c_probe_func_quick_read()? Should we replace it with the 
original i2c_smbus_write_quick()?

	
