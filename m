From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: piix4: Request the SMBUS semaphore inside the
 mutex
Date: Thu, 9 Feb 2017 18:31:39 +0100
Message-ID: <20170209183139.1a63f1fd@endymion>
References: <20170202191516.4476-1-ricardo.ribalda@gmail.com>
        <20170203161739.7264f85b@endymion>
        <20170209160926.fmxmnjb7oqf27pww@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58552 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754342AbdBIRcH (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 9 Feb 2017 12:32:07 -0500
In-Reply-To: <20170209160926.fmxmnjb7oqf27pww@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel

Hi Wolfram,

On Thu, 9 Feb 2017 17:09:26 +0100, Wolfram Sang wrote:
> > Thanks for the quick fix.
> > 
> > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> 
> I wonder: why do you use Signed-off instead of Reviewed-by recently?

I use Signed-off-by for drivers I maintain, and Reviewed-by for the
rest.

But I can use whatever you prefer if that's a problem, I don't really
care.


-- 
Jean Delvare
SUSE L3 Support
