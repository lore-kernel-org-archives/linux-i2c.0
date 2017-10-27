From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH resend v5 3/3] platform/x86: intel_cht_int33fe: Update
 fusb302 type string, add properties
Date: Fri, 27 Oct 2017 12:31:01 +0200
Message-ID: <011c294b-20c3-9c37-3606-626b2201fde9@redhat.com>
References: <20171011094121.6108-1-hdegoede@redhat.com>
 <20171011094121.6108-4-hdegoede@redhat.com>
 <20171026203323.w5xj2mms5epda6pt@ninjato>
 <5f747f91-0eb8-5566-5de3-b5dfd1f134ce@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57888 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752292AbdJ0KbE (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 27 Oct 2017 06:31:04 -0400
In-Reply-To: <5f747f91-0eb8-5566-5de3-b5dfd1f134ce@redhat.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org

Hi,

On 27-10-17 12:13, Hans de Goede wrote:
> Hi,
> 
> On 26-10-17 22:33, Wolfram Sang wrote:
>> On Wed, Oct 11, 2017 at 11:41:21AM +0200, Hans de Goede wrote:
>>> The fusb302 driver as merged in staging uses "typec_fusb302" as i2c-id
>>> rather then just "fusb302" and needs us to set a number of device-
>>> properties, adjust the intel_cht_int33fe driver accordingly.
>>>
>>> One of the properties set is max-snk-mv which makes the fusb302 driver
>>> negotiate up to 12V charging voltage, which is a bad idea on boards
>>> which are not setup to handle this, so this commit also adds 2 extra
>>> sanity checks to make sure that the expected Whiskey Cove PMIC +
>>> TI bq24292i charger combo, which can handle 12V, is present.
>>>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>>
>> I can't apply this one. Is there an immutable branch I need to pick up?
>> Or shall this go via another tree? My base is v4.14-rc5.
> 
> It should be applied on top of this patch:
> 
> http://git.infradead.org/users/dvhart/linux-platform-drivers-x86.git/commitdiff/5c003458db40cf3c89aeddd22c6e934c28b5a565
> 
>  From linux-platform-drivers-x86.git/for-next.
> 
> So either we are going to need an immutable branch from you
> with the first patch of this series so that the platform/x86
> maintainers can merge this, or the other way around :|

Alternatively we could push this patch as a post rc1 fix I guess.

Regards,

Hans
