Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE40C10F1B
	for <linux-i2c@archiver.kernel.org>; Mon, 19 Dec 2022 09:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiLSJXC (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 19 Dec 2022 04:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbiLSJXA (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 19 Dec 2022 04:23:00 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A9D63B8;
        Mon, 19 Dec 2022 01:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671441774; x=1702977774;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=52iEItY8ZXitQ7SKEinWt/UMnHA2rJUFDIU4axb89Hg=;
  b=Ei42zOrsoHDBBtxhamiTXIRZkZsvbQPcxOGIkWpgroIIflreXEW+ANMC
   3UO9N8rAY+Ni3t192lalvGd16ASbiAHqvVzhXgIYm4pwIpTCFtZ4HT5yj
   8fY6QMMtN3AlvBVHEP8HJ9LOv7hvDbBk78waCT3xITHuzMKtiPnKuDfh0
   XF0uJYv+kHoUNV0mzjzLLwEiVQIOl9J71OLfJHuZThB8KtnW/FvZcjJ+k
   R+nJKs1mW45mg1EiPLPWaNoX4BIxdGqX/CcJbR6gMH7EpG+CrMXzatLDK
   ChHLulueKv7R/nqTTJdH/2QSwQplYF1pmQHqkS0kS4jTF2hQ5Voh/e1xv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="320479333"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="320479333"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 01:22:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="739270051"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="739270051"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Dec 2022 01:22:50 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 39653F7; Mon, 19 Dec 2022 11:23:19 +0200 (EET)
Date:   Mon, 19 Dec 2022 11:23:19 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org,
        netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH RFC 1/2] i2c: add fwnode APIs
Message-ID: <Y6Ath7zh2pv7DK1b@black.fi.intel.com>
References: <Y5B3S6KZTrYlIH8g@shell.armlinux.org.uk>
 <E1p2sVM-009tqA-Vq@rmk-PC.armlinux.org.uk>
 <Y5G2kkGC69FVWaiK@black.fi.intel.com>
 <Y5G5ZyO1XRgjfN90@shell.armlinux.org.uk>
 <Y6AlC+9iGVGzWSbc@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y6AlC+9iGVGzWSbc@shell.armlinux.org.uk>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Hi,

On Mon, Dec 19, 2022 at 08:47:07AM +0000, Russell King (Oracle) wrote:
> Hi Mika,
> 
> On Thu, Dec 08, 2022 at 10:16:07AM +0000, Russell King (Oracle) wrote:
> > Hi Mika,
> > 
> > On Thu, Dec 08, 2022 at 12:04:02PM +0200, Mika Westerberg wrote:
> > > Hi,
> > > 
> > > On Wed, Dec 07, 2022 at 11:22:24AM +0000, Russell King (Oracle) wrote:
> > > > +EXPORT_SYMBOL(i2c_find_device_by_fwnode);
> > > > +
> > > 
> > > Drop this empty line.
> > 
> > The additional empty line was there before, and I guess is something the
> > I2C maintainer wants to logically separate the i2c device stuff from
> > the rest of the file.
> > 
> > > > +/* must call put_device() when done with returned i2c_client device */
> > > > +struct i2c_client *i2c_find_device_by_fwnode(struct fwnode_handle *fwnode);
> > > 
> > > With the kernel-docs in place you probably can drop these comments.
> > 
> > It's what is there against the other prototypes - and is very easy to
> > get wrong, as I've recently noticed in the sfp.c code as a result of
> > creating this series.
> > 
> > I find the whole _find_ vs _get_ thing a tad confusing, and there
> > probably should be just one interface with one way of putting
> > afterwards to avoid subtle long-standing bugs like this.
> > 
> > Thanks.
> 
> Do you have any comments on my reply please?

Sorry, no comments :) Thanks for the clarification.
