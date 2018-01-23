From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH i2c-tools] i2c-dev.h: copy over typo fix from kernel
 include
Date: Tue, 23 Jan 2018 14:34:27 +0100
Message-ID: <20180123143427.08069ff9@endymion>
References: <20180115204030.26400-1-wsa@the-dreams.de>
        <20180119093753.71e9457f@endymion>
        <20180119092158.o6x7wy4epnzddv5y@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43885 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751633AbeAWNea (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 23 Jan 2018 08:34:30 -0500
In-Reply-To: <20180119092158.o6x7wy4epnzddv5y@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org

On Fri, 19 Jan 2018 10:21:58 +0100, Wolfram Sang wrote:
> > 652619121974 ("i2c-dev.h: Minimize differences with kernel flavor".) At
> > this point i2c-tools' i2c-dev.h and the kernel's i2c-dev.h are exactly
> > the same file, modulo the difference you just pointed out.  
> 
> Exactly. I wanted to follow up in minimizing the differences. But I was
> unaware of the master plan...
> 
> > So the right thing to do is to delete include/linux/i2c-dev.h from
> > i2c-tools altogether. We no longer use it and we no longer install it,
> > so it should be a straightforward change. I simply forgot to do it
> > after the library conversion.  
> 
> ... which I super like very much!
> 
> Acked-by: Wolfram Sang <wsa@the-dreams.de>

Thanks, done.

https://git.kernel.org/pub/scm/utils/i2c-tools/i2c-tools.git/commit/?id=226bc03acca44cf4b300597308064c44676b6f4b

-- 
Jean Delvare
SUSE L3 Support
