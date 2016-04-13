From: Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH] i2c: simtec: Convert to use devm_* APIs
Date: Wed, 13 Apr 2016 08:43:49 +0800
Message-ID: <CAFRkauAArNSY-_nytHYTVScjM46Zy8yTogjSMM7iqK421CTKOg@mail.gmail.com>
References: <1460449814.28557.0.camel@ingics.com>
	<20160412214831.GI1526@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33313 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795AbcDMAnv (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 12 Apr 2016 20:43:51 -0400
Received: by mail-lf0-f65.google.com with SMTP id p64so4960046lfg.0
        for <linux-i2c@vger.kernel.org>; Tue, 12 Apr 2016 17:43:50 -0700 (PDT)
In-Reply-To: <20160412214831.GI1526@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ben Dooks <ben@simtec.co.uk>, linux-i2c@vger.kernel.org

2016-04-13 5:48 GMT+08:00 Wolfram Sang <wsa@the-dreams.de>:
> On Tue, Apr 12, 2016 at 04:30:14PM +0800, Axel Lin wrote:
>> Use devm_* APIs to simplify the code a bit.
>>
>> Signed-off-by: Axel Lin <axel.lin@ingics.com>
>
> Thanks! Were you able to test it on hardware?
>
I don't have this h/w, so I cannot test it.

Axel
