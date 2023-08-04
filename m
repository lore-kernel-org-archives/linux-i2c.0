Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29CDC04A6A
	for <linux-i2c@archiver.kernel.org>; Fri,  4 Aug 2023 04:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjHDEGG (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 4 Aug 2023 00:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjHDEGF (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 4 Aug 2023 00:06:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983BBE7;
        Thu,  3 Aug 2023 21:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691121963; x=1722657963;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8Ri+879dpjTsGVSdU4l/01Crn9p2QEtVdk2BwNRNNuU=;
  b=FfPBAh+DbxrBe8CUw0OL/8eJYY+bZHCxjqhQZp4uboRFHGE2mWLv9uGd
   kdGfv9FSQ0txPi7ircyAqicAUzBqo999X+B0gr8lSpvh+XDDDQBsTi45K
   pWly0SAPIsTvd+3pGj1IomFNPBbPKU2wD6VB4XKw91fcvZPms1mdLds0d
   j+O3+OeDGGr3VPljGgItVSiELs37jEX+do0orVgFK8q44Y/KmkdsvFa6Q
   x23VZCZzLiOjzCKV4ctBfck2ykDa3DSpQ1VqwwWgDoOgcVWveCjRW+tBq
   PWFhtEPeobY7aUrjlxvkysimKwOyLiXFLUhFMg/xTPKFejH0ZnuVgIuyQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="456433349"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="456433349"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 21:06:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="706820621"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="706820621"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 03 Aug 2023 21:06:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qRm4d-008n0a-0s;
        Fri, 04 Aug 2023 07:05:59 +0300
Date:   Fri, 4 Aug 2023 07:05:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Andi Shyti <andi.shyti@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v5 RESEND 2/4] i2c: Add i2c_device_get_match_data()
 callback
Message-ID: <ZMx5Jn0VCNrinrOl@smile.fi.intel.com>
References: <20230803103102.323987-1-biju.das.jz@bp.renesas.com>
 <20230803103102.323987-3-biju.das.jz@bp.renesas.com>
 <ZMuYSdVfiCiUXU8L@smile.fi.intel.com>
 <OS0PR01MB5922933E8AE4B9D17C0158E48608A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922933E8AE4B9D17C0158E48608A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Thu, Aug 03, 2023 at 01:52:05PM +0000, Biju Das wrote:
> > On Thu, Aug 03, 2023 at 11:31:00AM +0100, Biju Das wrote:

> Does these below 2 patches ok?

Looks awesome!

-- 
With Best Regards,
Andy Shevchenko


