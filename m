From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH] i2c: pnx: fix warnings caused by enabling unprepared
 clock
Date: Tue, 20 Oct 2015 13:58:28 +0300
Message-ID: <56261E54.7040808@mleia.com>
References: <1445107947-2888-1-git-send-email-vz@mleia.com>	<CAKfKVtEEcVN6byknzFv1WgceN8kbZNJB2Q7pkeXe_PmJD3_DTw@mail.gmail.com>	<5625343A.90407@mleia.com> <CAKfKVtFR524MCag-dZCaEThqgGm-KBnKkxrw-cEG2RtCSZWnVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from li271-223.members.linode.com ([178.79.152.223]:38253 "EHLO
	mail.mleia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750805AbbJTK6a (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 20 Oct 2015 06:58:30 -0400
In-Reply-To: <CAKfKVtFR524MCag-dZCaEThqgGm-KBnKkxrw-cEG2RtCSZWnVw@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Cc: Vitaly Wool <vitalywool@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

On 20.10.2015 11:54, Shubhrajyoti Datta wrote:
> On Mon, Oct 19, 2015 at 11:49 PM, Vladimir Zapolskiy <vz@mleia.com> wrote:
>> On 19.10.2015 19:21, Shubhrajyoti Datta wrote:
>>> On Sun, Oct 18, 2015 at 12:22 AM, Vladimir Zapolskiy <vz@mleia.com> wrote:
>>>> If common clock framework is configured, the driver generates a warning,
>>>> which is fixed by this change:
>>> Maybe just describe the issue and the fix.
>>> Is it just a warning or  the clk enable doesn't work ?
>>>
>>> I feel the crash log in the commit msg is not very informative.
>>
>> It is not a crash, it is a WARN_ON(1) backtrace.
> 
> ok
> 
>>
>> The backtrace is informative enough IMHO, because if you check the code
>> around given drivers/clk/clk.c:727 you may find the rootcause, the
>> WARN_ON() and that the clock is not enabled as a result.
>>
>> CLK_COMMON selects HAVE_CLK_PREPARE and all drivers used on platforms
>> with common clock framework must have clk_prepare/clk_unprepare, this
>> information is omitted as well-known.
>>
>> But if you insist, I will improve the commit message, I'm interested in
>> applying this trivial fix as soon as possible, then concentrate on doing
>> something more fascinating.
> 
> My request will be to describe the issue.
> Like the probe fails or you access registers with clocks not enabled
> 
> Or it is a warning fix and the controller works etc.

If I change initial description to the one below, would you be satisfied
with it?

The driver can not be used on a platform with common clock framework
until clk_prepare/clk_unprepare calls are added, otherwise clk_enable
calls will fail and a warning is generated.

--
With best wishes,
Vladimir
