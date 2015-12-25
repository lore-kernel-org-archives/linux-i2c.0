From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Subject: Re: [PATCH 0/2] i2c: proper RuntimePM for the adapter device
Date: Fri, 25 Dec 2015 11:23:57 +0530
Message-ID: <CAKfKVtHWrxJQ6P0MpsHLtr2g9n4t6RhS6_71oxqsZPAOHe3ZgQ@mail.gmail.com>
References: <1450891169-13708-1-git-send-email-wsa@the-dreams.de>
	<CAKfKVtHt8BpakkffRp=_2GUxqK5JO0WCsizCrjtwH5hv+TWvWg@mail.gmail.com>
	<20151224084105.GA1548@katana>
	<CAKfKVtEmsrQT6x2p=Knz836iNXw3vwQyx1M_WJ=GJjVDgBjWFA@mail.gmail.com>
	<20151224222539.GA1624@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qg0-f65.google.com ([209.85.192.65]:34602 "EHLO
	mail-qg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbbLYFx6 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 25 Dec 2015 00:53:58 -0500
In-Reply-To: <20151224222539.GA1624@tetsubishi>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-pm@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

On Fri, Dec 25, 2015 at 3:55 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> I think the below drivers
>>
>> drivers/i2c/busses/i2c-at91.c
>> drivers/i2c/busses/i2c-designware-core.c
>> drivers/i2c/busses/i2c-designware-platdrv.c
>> drivers/i2c/busses/i2c-rcar.c
>> drivers/i2c/busses/i2c-sh_mobile.c
>> drivers/i2c/busses/i2c-hix5hd2.c
>> drivers/i2c/busses/i2c-nomadik.c
>> drivers/i2c/busses/i2c-omap.c
>> drivers/i2c/busses/i2c-qup.c
>> drivers/i2c/busses/i2c-s3c2410.c
>
> They use RuntimePM on their platform device, not on the adapter device
> AFAICS.
>
Indeed my bad.
