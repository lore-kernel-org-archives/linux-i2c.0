Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14750C83016
	for <linux-i2c@archiver.kernel.org>; Wed,  2 Dec 2020 16:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0D0F2224D
	for <linux-i2c@archiver.kernel.org>; Wed,  2 Dec 2020 16:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387425AbgLBQZj (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 2 Dec 2020 11:25:39 -0500
Received: from mga03.intel.com ([134.134.136.65]:44650 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387405AbgLBQZj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 2 Dec 2020 11:25:39 -0500
IronPort-SDR: /Uyydq9IfpAv/pMxHIdE0o48VS1yFPJjPA2+BJlGKwQBEFiofIugNKbon7b9WjcoqdMa3KGhif
 R8QgDbF15upA==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="173140489"
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="173140489"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 08:23:58 -0800
IronPort-SDR: z4O4g4L1PO3wpDDNNsPM50CYZJtPZa/c5P86NpFIU1DLKE43T7C1bhE3JbX+Mqcn/ZOwZFlmC4
 UHhgTDd9jU7Q==
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="365359254"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 08:23:57 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kkUw7-00BYGn-2w; Wed, 02 Dec 2020 18:24:59 +0200
Date:   Wed, 2 Dec 2020 18:24:59 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wolfram Sang <wsa@kernel.org>,
        Seth Heasley <seth.heasley@intel.com>,
        Neil Horman <nhorman@tuxdriver.com>, linux-i2c@vger.kernel.org,
        Mario Alejandro Posso Escobar <mario.posso.escobar@intel.com>
Subject: Re: [PATCH v1] i2c: ismt: Adding support for
 I2C_SMBUS_BLOCK_PROC_CALL
Message-ID: <20201202162459.GK4077@smile.fi.intel.com>
References: <20201116153245.24083-1-andriy.shevchenko@linux.intel.com>
 <20201202154501.GB13425@kunai>
 <20201202160023.GF13425@kunai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202160023.GF13425@kunai>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Wed, Dec 02, 2020 at 05:00:23PM +0100, Wolfram Sang wrote:
> 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Signed-off-by: Mario Alejandro Posso Escobar <mario.posso.escobar@intel.com>
> > 
> > Applied to for-next, thanks!
> 
> Oops, I thought Andy was the maintainer. Seth, Neil are you okay with
> this patch?

JFYI: Even for maintainers the Co-developed-by case is to have both tags (when
maintainer was a co-developer of a code in question).

-- 
With Best Regards,
Andy Shevchenko


