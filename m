From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: Re: i2c_new_{secondary_device,dummy,device}() return type.
Date: Fri, 9 Feb 2018 18:07:05 +0000
Message-ID: <7e3f4e66-aee8-1b48-bc4d-2b9e63d28918@ideasonboard.com>
References: <6f03d1e1-b542-99cb-7cfe-8eae9addd8d9@ideasonboard.com>
 <19f18d1d-efba-a6ca-32f4-0b55f284f27e@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <19f18d1d-efba-a6ca-32f4-0b55f284f27e@gmail.com>
Content-Language: en-GB
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, "open list:MEDIA DRIVERS FOR RENESAS - FCP" <linux-renesas-soc@vger.kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: linux-i2c@vger.kernel.org

Hi Heiner,

On 09/02/18 17:59, Heiner Kallweit wrote:
> Am 09.02.2018 um 11:01 schrieb Kieran Bingham:
>> Hi Wolfram,
>>
>> As part of my work looking at using i2c_new_secondary_device() to move address
>> mappings into the device tree, it has become evident that the return code of the
>> i2c_new_secondary_device() is obfuscated, and is simply a valid client - or NULL.
>>
>> This means that we must 'guess' as to whether the device failed due to a memory
>> allocation, or if the device address was already in use (perhaps a more common
>> failure).
>>
>> Because of this - I would like to see the return codes of
>> i2c_new_secondary_device(), ic2_new_dummy(), and therefore i2c_new_device()
>> support returning ERR_PTR()s rather than a client or NULL.
>>
>> These functions are used fairly extensively - thus it will be a fair bit of work
>> (or a good coccinelle script) - So I'd like to ask your opinion on the validity
>> of this task before I commence anything down that rabbit hole!
>>
>> Any comments? Pre-ack/nack? (from anyone?)
>>
> 
> This has been addressed as part of adding a devm_i2c_new_dummy().
> Related patches are in status "under review" since end of December.
> See also here:
> https://marc.info/?l=linux-i2c&m=151375074832371&w=2
> https://patchwork.ozlabs.org/patch/851268/
> 
> Maybe these patches cover already what you need.

Thankyou - I will take a look (albeit - next week now!)

--
Regards

Kieran

> 
> Rgds, Heiner
> 
>> --
>> Regards
>>
>> Kieran Bingham
>> .
>>
> 
