From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] i2c: i801: Fix Failed to allocate irq -2147483648 error
Date: Mon, 27 Nov 2017 16:38:50 +0100
Message-ID: <a733c418-9a88-fd40-96b7-40690c757db0@redhat.com>
References: <20171122112817.9554-1-hdegoede@redhat.com>
 <20171124144957.6a7323cc@endymion>
 <5ba5b26d-18d9-6f07-d9a9-52cde30ea5ee@redhat.com>
 <20171127110427.624a8b3c@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53876 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752291AbdK0Pix (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 27 Nov 2017 10:38:53 -0500
In-Reply-To: <20171127110427.624a8b3c@endymion>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, stable@vger.kernel.org

Hi,

On 27-11-17 11:04, Jean Delvare wrote:
> On Sat, 25 Nov 2017 14:43:08 +0100, Hans de Goede wrote:
>> On 11/24/2017 02:49 PM, Jean Delvare wrote:
>>> Isn't it a BIOS bug?
>>
>> No, as mentioned in:
>>
>>>> BugLink: https://communities.intel.com/thread/114759
>>
>> The BIOS deliberately does not contain IRQ routing issues because some
>> variants of the Windows driver for this falling over if their is
>> any IRQ routing set, so this is a "feature" not a bug :|
> 
> What I do not understand is how Apollo Lake systems are different from
> any other Intel system, which already had a compatible SMBus controller
> and apparently having an IRQ configured was never an issue?

I've no answer there I'm afraid.

>>> (...)
>>> However if this is considered a BIOS bug then a pr_err(FW_BUG...) would
>>> be good to add IMHO.
>>
>> See above, that would just replace one error message with another on all
>> Apollo Lake systems.
> 
> Turning a cryptic error message into a meaningful error message isn't
> necessarily a bad thing.

Given all the effort distros have done with splash-screens to give
users a nice clean boot experience, we really want dmesg --level=err
to not print anything unless there is a real problem with either the
hardware or the kernel, printing an error message on all Apollo Lake
systems is really not helpful IMHO.

Regards,

Hans
