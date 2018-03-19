From: Peter Rosin <peda@axentia.se>
Subject: Re: [RFC PATCH 1/2] i2c: Add i2c_verify_device_id() to verify device
 id
Date: Mon, 19 Mar 2018 20:55:55 +0100
Message-ID: <11684f49-dee5-7037-f5c9-5bb8becf114f@axentia.se>
References: <1521475859-16765-1-git-send-email-linux@roeck-us.net>
 <99548eb6-1958-b2a1-1f2c-ba995f8965ee@axentia.se>
 <20180319184850.GB23774@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180319184850.GB23774@roeck-us.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Adrian Fiergolski <adrian.fiergolski@cern.ch>
List-Id: linux-i2c@vger.kernel.org

On 2018-03-19 19:48, Guenter Roeck wrote:
> On Mon, Mar 19, 2018 at 05:47:05PM +0100, Peter Rosin wrote:
>> I also wonder if NXP will ever release a chip with part-id 0 and
>> die-revision 0? If not, an all zero struct i2c_device_identity
>> could be used instead of manufacturer_id 0xffff and that would
>> simplify the pca954x driver code a bit more. But I guess we can
>> never know the answer to that question. And even if we did, the
>> answer might change later. But it would be nice...
>>
> 
> That would be nice. You could ask at i2c.support@nxp.com, but I guess
> it would always be somewhat risky since the standard doesn't restrict
> its use, and some product manager at NXP might decide in the future
> that a device ID of 0x00 would be "cool".

No need to bother NXP, PCA9848 has already claimed 0-0-0. Sigh.

But while I googled that I found old datasheets for the chips PCA9672
through PCA9675 which use a different layout for the three bytes in
the device id. They have 8 manufacturer bits, 7 category bits, 6 bits
of feature indication and then 3 bits of revision. The top category
bits are zero so it is compatible for NXP chips. But since noone else
has implemented this, it is probably safe, but still a little bit
disturbing.

I also found that NXP apparently uses the same part id (0x100) and die
revision (0) for PCA9570 and PCA9670. That seems odd.

Example old datasheet (2006):
https://www.digchip.com/datasheets/download_datasheet.php?id=1098812&part-number=PCA9672

Cheers,
Peter
