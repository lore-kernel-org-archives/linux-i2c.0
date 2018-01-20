From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH i2c-tools] CHANGES: add i2ctransfer
Date: Sat, 20 Jan 2018 20:35:21 +0100
Message-ID: <20180120203521.1722869f@endymion>
References: <20180115173644.12342-1-wsa+renesas@sang-engineering.com>
        <20180119092252.6eaa32c6@endymion>
        <20180119091929.unxyczdyrwle2psa@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41763 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756422AbeATTfY (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 20 Jan 2018 14:35:24 -0500
In-Reply-To: <20180119091929.unxyczdyrwle2psa@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org

On Fri, 19 Jan 2018 10:19:29 +0100, Wolfram Sang wrote:
> > > +  i2ctransfer: new tool to send user-defined I2C messages in one transfer  
> > 
> > Good idea. A leading capital would be appreciated for consistency.  
> 
> Ack. Shall I resend or could you fix locally?

Why me? You have write access to the repository, you might as well do
it yourself, with my:

Acked-by: Jean Delvare <jdelvare@suse.de>

> > Speaking of i2ctransfer, would you agree to remove it from the
> > i2c-tools-3.1 branch? As I recall, the only reason why it was added  
> 
> Acked-by: Wolfram Sang <wsa@the-dreams.de>

Done, thanks.

-- 
Jean Delvare
SUSE L3 Support
