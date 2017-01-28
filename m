From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: piix4: Fix request_region size
Date: Sat, 28 Jan 2017 12:13:46 +0100
Message-ID: <20170128121346.1e530c1c@endymion>
References: <20170127145930.13055-1-ricardo.ribalda@gmail.com>
        <1485592582.4916.1.camel@suse.de>
        <20170128110021.GA1604@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54982 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750893AbdA1LOa (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 28 Jan 2017 06:14:30 -0500
In-Reply-To: <20170128110021.GA1604@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Wolfram,

On Sat, 28 Jan 2017 12:00:21 +0100, Wolfram Sang wrote:
> 
> > >  /* count for request_region */
> > > -#define SMBIOSIZE	8
> > > +#define SMBIOSIZE	9
> > 
> > Are you certain that all supported devices have this extra register?
> 
> Isn't it better to have a potentially unused register mapped than a
> potentially used register unmapped?

My concern is that the region request could fail due to a conflict with
another device, if the physical I/O region is only 8 and we try to
request 9.

-- 
Jean Delvare
SUSE L3 Support
