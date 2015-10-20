From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Subject: Re: [PATCH] i2c: pnx: fix warnings caused by enabling unprepared clock
Date: Tue, 20 Oct 2015 14:24:45 +0530
Message-ID: <CAKfKVtFR524MCag-dZCaEThqgGm-KBnKkxrw-cEG2RtCSZWnVw@mail.gmail.com>
References: <1445107947-2888-1-git-send-email-vz@mleia.com>
	<CAKfKVtEEcVN6byknzFv1WgceN8kbZNJB2Q7pkeXe_PmJD3_DTw@mail.gmail.com>
	<5625343A.90407@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:36790 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753943AbbJTIyq (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 20 Oct 2015 04:54:46 -0400
Received: by qgad10 with SMTP id d10so8710568qga.3
        for <linux-i2c@vger.kernel.org>; Tue, 20 Oct 2015 01:54:45 -0700 (PDT)
In-Reply-To: <5625343A.90407@mleia.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Vitaly Wool <vitalywool@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

On Mon, Oct 19, 2015 at 11:49 PM, Vladimir Zapolskiy <vz@mleia.com> wrote:
> On 19.10.2015 19:21, Shubhrajyoti Datta wrote:
>> On Sun, Oct 18, 2015 at 12:22 AM, Vladimir Zapolskiy <vz@mleia.com> wrote:
>>> If common clock framework is configured, the driver generates a warning,
>>> which is fixed by this change:
>> Maybe just describe the issue and the fix.
>> Is it just a warning or  the clk enable doesn't work ?
>>
>> I feel the crash log in the commit msg is not very informative.
>
> It is not a crash, it is a WARN_ON(1) backtrace.

ok

>
> The backtrace is informative enough IMHO, because if you check the code
> around given drivers/clk/clk.c:727 you may find the rootcause, the
> WARN_ON() and that the clock is not enabled as a result.
>
> CLK_COMMON selects HAVE_CLK_PREPARE and all drivers used on platforms
> with common clock framework must have clk_prepare/clk_unprepare, this
> information is omitted as well-known.
>
> But if you insist, I will improve the commit message, I'm interested in
> applying this trivial fix as soon as possible, then concentrate on doing
> something more fascinating.

My request will be to describe the issue.
Like the probe fails or you access registers with clocks not enabled

Or it is a warning fix and the controller works etc.
>
>>>
