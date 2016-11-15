From: Kieran Bingham <kieran@ksquared.org.uk>
Subject: Re: [PATCHv7 08/11] i2c: match vendorless strings on the internal
 string length
Date: Tue, 15 Nov 2016 09:49:15 +0000
Message-ID: <64c4a261-1097-6baa-0ab0-b9ca16bcdf66@bingham.xyz>
References: <1478522866-29620-1-git-send-email-kieran@bingham.xyz>
 <1478522866-29620-9-git-send-email-kieran@bingham.xyz>
 <20161114203208.GA4207@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161114203208.GA4207@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Lee Jones <lee.jones@linaro.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, sameo@linux.intel.com
List-Id: linux-i2c@vger.kernel.org



On 14/11/16 22:27, Wolfram Sang wrote:
> On Mon, Nov 07, 2016 at 12:47:43PM +0000, Kieran Bingham wrote:
>> If a user provides a shortened string to match a device to the sysfs i2c
>> interface it will match on the first string that contains that string
>> prefix.
>>
>> for example:
>>   echo a 0x68 > /sys/bus/i2c/devices/i2c-2/new_device
>> will match as3711, as3722, and ak8975 incorrectly.
>>
>> Correct this by using sysfs_streq to match the string exactly
>>
>> Signed-off-by: Kieran Bingham <kieran@bingham.xyz>
> 
> Any objections that I squash this directly into patch 2? It is more like
> a bugfix, no?

No objection

Acked-by: Kieran Bingham <kieran@bingham.xyz>


-- 
Regards

Kieran Bingham
