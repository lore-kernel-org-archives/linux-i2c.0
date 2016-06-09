From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCHv5 0/8] 2c: Relax mandatory I2C ID table passing
Date: Thu, 9 Jun 2016 15:45:52 -0400
Message-ID: <adcdbb75-41ae-774e-21cb-c039e2f0686f@osg.samsung.com>
References: <1462374888-22888-1-git-send-email-kieran@bingham.xyz>
 <20160609191513.GB23522@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160609191513.GB23522@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Kieran Bingham <kieran@ksquared.org.uk>
Cc: Lee Jones <lee.jones@linaro.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, grant.likely@linaro.org, sameo@linux.intel.com
List-Id: linux-i2c@vger.kernel.org

Hello Wolfram,

On 06/09/2016 03:15 PM, Wolfram Sang wrote:
> Hi Kieran,
> 
>> * Device Tree
>>   I tested that the device would still register by adding a node in the device
>>   tree for the board, and testing with a built-in module. 
>>
>>  - This worked fine.
>>
>> * Module Autoloading
>>   With the device tree node in the board dts file, it wouldn't automatically
>>   load from the external module. This was due to the rtc-ds1307 module not
>>   exporting an of_match table, and not yet having Javier's "report OF style
>>   modalias when probing using DT" [0]  patch applied
> 
> What I didn't get here: did your version of the RTC driver use probe()
> or probe_new() without i2c_device_id table or did you try both? I assume
> module autoloading only fails with probe_new(), otherwise we would be in
> serious trouble. But I'd wonder then that userspace instantiation works.
>

I can't answer for Kieran but you trimmed this last sentence from him:

>  - With the module updated, and Javiers patch applied, the module autoloads
>

So my understanding is that by updated he meant a patched rtc-ds1307 driver
using a .probe_new, whose i2c_device_id table was removed and of_device_id
table added (that's not present in the mainline driver).

And that's why he needed my RFC patch to report a MODALIAS=of:N*T*Cfoo,bar
and match what's exported to the module using the of_device_id table.

Because drivers that only use .probe and have an i2c_device_id table will
continue to match and report MODALIAS=i2c:foo as before after this series.

> Thanks to you and Javier for the testing. I pushed the patches to a
> local branch for now and will merge once this question is clear.
>
> Regards,
> 
>    Wolfram
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
