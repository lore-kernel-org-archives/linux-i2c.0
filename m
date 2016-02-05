From: Alexandra Yates <alexandra.yates@linux.intel.com>
Subject: Re: [PATCH V2] i2c: i801: Adding Intel Lewisburg support for iTCO
Date: Fri, 5 Feb 2016 14:09:17 -0800
Message-ID: <56B51D8D.9070003@linux.intel.com>
References: <1454627215-2418-1-git-send-email-alexandra.yates@linux.intel.com>
 <20160204232746.GA2421@tetsubishi> <20160205104855.5ec3432c@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160205104855.5ec3432c@endymion>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

Thank you for your review and feedback.

On 02/05/2016 01:48 AM, Jean Delvare wrote:
> On Fri, 5 Feb 2016 00:27:46 +0100, Wolfram Sang wrote:
>> On Thu, Feb 04, 2016 at 03:06:55PM -0800, Alexandra Yates wrote:
>>> Starting from Intel Sunrisepoint (Skylake PCH) the iTCO watchdog
>>> resources have been moved to reside under the i801 SMBus host
>>> controller whereas previously they were under the LPC device.
>>>
>>> This patch adds Intel lewisburg SMBus support for iTCO device.
>>>
>>> Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>
>>
>> Please state what has changed in v2 of this patch?
>
> Yes, Alexandra, please always include a changelog (between the ---
> separator and the diffstat) when posting patch updates.
>
> In this case there is no code change, the only change is the subject.

correct
>
> If I understand correctly, this is a fixup for commit
> cdc5a3110e7c3ae793f367285789a6bc39c962dc ("i2c: i801: add Intel
> Lewisburg device IDs") which should have included these changes. If so,
> please mention it in the commit message. It may also make sense to tag
> the patch for stable [v4.4].

It is an addition to that commit, at the time I submitted the commit I 
wasn't aware that this portion was needed to load dynamically since this 
part of the code was in flux as well.  As it is the driver loads using 
modprobe. I'll add that to the commit message to make it clear and 
resend the patch.

>
> Reviewed-by: Jean Delvare <jdelvare@suse.de>
>
> Thanks,
>

-- 
Thank you,
<Alexandra>
