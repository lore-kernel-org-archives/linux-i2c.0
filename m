From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] i2c: i801: Fix Failed to allocate irq -2147483648 error
Date: Tue, 28 Nov 2017 14:42:35 +0100
Message-ID: <5669e600-296a-f120-b2c7-0d875c22c020@redhat.com>
References: <20171122112817.9554-1-hdegoede@redhat.com>
 <20171124144957.6a7323cc@endymion>
 <5ba5b26d-18d9-6f07-d9a9-52cde30ea5ee@redhat.com>
 <20171127110427.624a8b3c@endymion>
 <a733c418-9a88-fd40-96b7-40690c757db0@redhat.com>
 <20171128143707.257a2fa1@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52698 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752535AbdK1Nmh (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 28 Nov 2017 08:42:37 -0500
In-Reply-To: <20171128143707.257a2fa1@endymion>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, stable@vger.kernel.org

Hi,

On 28-11-17 14:37, Jean Delvare wrote:
> On Mon, 27 Nov 2017 16:38:50 +0100, Hans de Goede wrote:
>> On 27-11-17 11:04, Jean Delvare wrote:
>>> Turning a cryptic error message into a meaningful error message isn't
>>> necessarily a bad thing.
>>
>> Given all the effort distros have done with splash-screens to give
>> users a nice clean boot experience, we really want dmesg --level=err
>> to not print anything unless there is a real problem with either the
>> hardware or the kernel,
> 
> I completely agree with that, same goal here.
> 
>> printing an error message on all Apollo Lake
>> systems is really not helpful IMHO.
> 
> It wouldn't have to be an error message, it could be a mere notice.
> 
> What I'm afraid of is that the missing IRQ is an overlook from the
> standard BIOS provided by Intel to integrators, and the error will keep
> spreading until BIOS developers are aware of the problem.

According to: https://communities.intel.com/thread/114759 it was not
an oversight, but done deliberately:

"BTW, the SMBus interface was removed from the mapping table because, in
the Windows environment (where Intel does not provide a driver for general
use), there were all sorts of 3rd-party drivers that are screwed up by the
interrupt routing. It was easier to remove it from the mapping than to rein
in all of these drivers (which mostly seemed to want to use it in polled
mode anyway). As you saw in the log, the i801_i2c driver just switched to
polled mode and kept on trucking..."

I think the clue is "Intel does not provide a driver for general use"
and the 3th party drivers have varying levels of quality, I guess there
is something special about the IRQ routing on Apollo Lake that this was
not an issue before.

Regards,

Hans
