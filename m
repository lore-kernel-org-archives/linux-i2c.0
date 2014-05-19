From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [Patch V2 6/9] I2C: Add smbus word/block process call helper
 function
Date: Mon, 19 May 2014 17:23:29 +0800
Message-ID: <5379CD91.2080709@intel.com>
References: <1398147855-9868-1-git-send-email-tianyu.lan@intel.com> <1398695268-28645-1-git-send-email-tianyu.lan@intel.com> <1398695268-28645-7-git-send-email-tianyu.lan@intel.com> <20140517102110.GB2602@katana> <53776B32.8010400@intel.com> <20140517171759.GB2597@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20140517171759.GB2597@katana>
Sender: linux-acpi-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: rjw@rjwysocki.net, mika.westerberg@linux.intel.com, awilliam@redhat.com, lenb@kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 05/18/2014 01:17 AM, Wolfram Sang wrote:
>
>>> BTW what were your test scenarios for these functions and smbus quick?
>>>
>>
>>  From ACPI spec, Read/Write quick and Word/Block process call
>> protocol will be used by Bios ACPI code. But so far, I don't find
>> such machines. So these functions has not been tested.
>
> Uh oh, I have some trouble adding untested code. Can't we add until we
> have a user to verify it?

Ok. I will remove these patches from this patchset since currently there are no 
users.

>
> BTW I have to review the other patches later, so please wait before
> resending the series.
>

