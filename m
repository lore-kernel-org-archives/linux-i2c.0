From: Kieran Bingham <kieran@ksquared.org.uk>
Subject: Re: [PATCHv7 07/11] i2c: match dt-style device names from sysfs
 interface
Date: Tue, 15 Nov 2016 09:48:45 +0000
Message-ID: <539439ac-af8c-745d-a028-1282eb9155da@bingham.xyz>
References: <1478522866-29620-1-git-send-email-kieran@bingham.xyz>
 <1478522866-29620-8-git-send-email-kieran@bingham.xyz>
 <20161114194953.GB3603@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161114194953.GB3603@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Lee Jones <lee.jones@linaro.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, sameo@linux.intel.com
List-Id: linux-i2c@vger.kernel.org



On 14/11/16 22:27, Wolfram Sang wrote:
> On Mon, Nov 07, 2016 at 12:47:42PM +0000, Kieran Bingham wrote:
>> A user can choose to instantiate a device on an i2c bus using the sysfs
>> interface by providing a string and address to match and communicate
>> with the device on the bus. Presently this string is only matched
>> against the old i2c device id style strings, even in the presence of
>> full device tree compatible strings with vendor prefixes.
>>
>> Providing a vendor-prefixed string to the sysfs interface will not match
>> against the device tree of_match_device() calls as there is no device
>> tree node to parse from the sysfs interface.
>>
>> Convert i2c_of_match_device_strip_vendor() such that it can match both
> 
> The function name here is the old one...
> 
>> vendor prefixed and stripped compatible strings on the sysfs interface.
>>
>> Signed-off-by: Kieran Bingham <kieran@bingham.xyz>
> 
> ... and in patch 2, the sentence "remove this function if all drivers
> are converted" is obsolete, too, since we need this function always for
> sysfs.
> 
> This make me wonder if we shouldn't squash this patch also in into patch
> 2 (like I suggested for the next one), and create a best-of-all-worlds
> commit message from these three patches?
> 
> Opinions?

That's fine with me - My main reason for keeping them separate during
posting was so that the changes I had made could be seen - but yes - I
think they probably are eligible for squashing.


-- 
Regards

Kieran Bingham
