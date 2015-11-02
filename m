From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: Double commits in i2c/for-next branch?
Date: Mon, 2 Nov 2015 14:54:06 +0900
Message-ID: <CAK7LNATzp2fUnRLRObYnULv0YwmFxjMYU+_CwmiSzPEzRKy_WQ@mail.gmail.com>
References: <CAK7LNATkMPJOBABg9TH69Z2gEfudvk_jQHkE-j5QZLevdzBW9A@mail.gmail.com>
	<20151102055051.GA1065@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from conssluserg002.nifty.com ([202.248.44.40]:18976 "EHLO
	conssluserg002-v.nifty.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752067AbbKBFyQ (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 2 Nov 2015 00:54:16 -0500
Received: from mail-yk0-f181.google.com (mail-yk0-f181.google.com [209.85.160.181]) (authenticated)
	by conssluserg002-v.nifty.com with ESMTP id tA25s6v5013610
	for <linux-i2c@vger.kernel.org>; Mon, 2 Nov 2015 14:54:07 +0900
Received: by ykek133 with SMTP id k133so130679789yke.2
        for <linux-i2c@vger.kernel.org>; Sun, 01 Nov 2015 21:54:06 -0800 (PST)
In-Reply-To: <20151102055051.GA1065@tetsubishi>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org

Hi Wolfram,

2015-11-02 14:50 GMT+09:00 Wolfram Sang <wsa@the-dreams.de>:
>
>> [1] was applied to i2c/for-4.4 and then merged
>> into i2c/for-next.   It is supposed to be pulled
>> into the mainline in this merge window.
>
> Yes.
>
>> [2] was directly applied to i2c/for-next and
>> won't be pulled into the mainline.  It will only
>> remain in linux-next.
>
> Unfortunately, I had to rebase for-4.4 this time :( I try to avoid it,
> but sometimes this happens. When I merge that rebased version into
> for-next, double commits happen. Linus will get the pull request for
> for-4.4 only.
>
> Hope that helps,

Understood.

Thanks!




-- 
Best Regards
Masahiro Yamada
