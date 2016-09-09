From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] i2c: mux: demux-pinctrl: run properly with multiple
 instances
Date: Fri, 9 Sep 2016 09:08:45 +0200
Message-ID: <20160909070844.GB18476@verge.net.au>
References: <20160823152803.2051-1-wsa+renesas@sang-engineering.com>
 <20160908145027.GB1485@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:60260 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751350AbcIIHIw (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 9 Sep 2016 03:08:52 -0400
Content-Disposition: inline
In-Reply-To: <20160908145027.GB1485@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Pantelis Antoniou <pantelis.antoniou@konsulko.com>

On Thu, Sep 08, 2016 at 04:50:27PM +0200, Wolfram Sang wrote:
> On Tue, Aug 23, 2016 at 05:28:03PM +0200, Wolfram Sang wrote:
> > We can't use a static property for all the changesets, so we now create
> > dynamic ones for each changeset.
> > 
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Fixes: 50a5ba87690814 ("i2c: mux: demux-pinctrl: add driver")
> 
> Applied to for-current (and thus will be in 4.8), thanks!
> 
> > Simon: I think you can retest your demuxer-dts-series now.
> 
> Simon: you think we can get that into 4.9? Would be awesome.

Sorry, this slipped through the cracks.
Lets aim for v4.10.
