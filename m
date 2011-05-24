From: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 00/13]  V3 Split i2c-designware.c to support PCI drivers.
Date: Tue, 24 May 2011 15:00:39 -0700
Message-ID: <4DDC2A87.2090108@gmail.com>
References: <1299961407-26852-1-git-send-email-dirk.brandewie@gmail.com> <20110314234337.GN15795@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110314234337.GN15795-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 03/14/2011 04:43 PM, Ben Dooks wrote:
> On Sat, Mar 12, 2011 at 12:23:14PM -0800, dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
>> From: Dirk Brandewie<dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>
>> This patch set reworks i2c-designware.c to enable supporting multiple
>> instances of the driver in the system and adds support for Designware
>> I2C IP cores behind PCI devices.
>>
>> The patch set has been refactored to hopefully make it easier to
>> review.
>>
>> TODO:
>> Ben disliked the module names, they haven't changed yet waiting for
>> feedback on the list.
>
> Right, merged into next-i2c pending any further feedback.
>

Ben,

Is this patch set going to make it into 2.6.40 merge window?

TIA
--Dirk
