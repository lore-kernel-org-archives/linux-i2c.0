Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DF7C4332F
	for <linux-i2c@archiver.kernel.org>; Wed,  2 Nov 2022 14:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbiKBOkC (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 2 Nov 2022 10:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiKBOkB (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 2 Nov 2022 10:40:01 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B948427FED
        for <linux-i2c@vger.kernel.org>; Wed,  2 Nov 2022 07:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667400000; x=1698936000;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0h8AyUWrmebWvZULFFlw8Ojwrn/d1iTTDpCkkhWZPC8=;
  b=YyA6PzBpt/SGkMmScqfdMlU8QKJIltkybHxcLe/i5UJyKR80UrC1bUfd
   0f+jqhKm2K7U7MLDVOp9RJqEK6AHoMQeNgN6bF5X7jkkHx1gmNfAmndPm
   Qr+6DrKeXp5qE9R4Htx1A9h5sauoxfAzs8edLCNbSljnP4JXktzfo3Ygd
   NFX2w/cPgICbJcjQAVjA5+z+YSX8ftWkulfoSWJ9UnjORrtDGJDxI7bwr
   Z8GzEXUzx6t3UsGAPImzrkNjwPVjDZHAY7BuYIHjMcLLC83VsPSs+3YbI
   3TAZHnmaiQ8Z2/uMJUbbfgOuNtrPwja4u4e4521o+pTvAkayGyqinz+5L
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="336106532"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="336106532"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 07:37:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="703290544"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="703290544"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 02 Nov 2022 07:37:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oqEs9-006DgR-2J;
        Wed, 02 Nov 2022 16:37:41 +0200
Date:   Wed, 2 Nov 2022 16:37:41 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-i2c@vger.kernel.org, Wolfram Sang <wsa@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>,
        Michael Wu <michael.wu@vatics.com>, Tian Ye <tianye@sugon.com>
Subject: Re: [PATCH v2 12/12] i2c: designware: Add comment to custom register
 value constants
Message-ID: <Y2KAteiXN87LZ72v@smile.fi.intel.com>
References: <20221102131125.421512-1-jarkko.nikula@linux.intel.com>
 <20221102131125.421512-13-jarkko.nikula@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102131125.421512-13-jarkko.nikula@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Wed, Nov 02, 2022 at 03:11:25PM +0200, Jarkko Nikula wrote:
> DW_IC_COMP_VERSION register contains the ASCII representation of the
> Synopsys component version followed by '*'. Here 0x3131312A == "111*"
> means version 1.11 is required for DW_IC_SDA_HOLD register availability.

The '*' means "any letter, starting from a", so I would put it as 1.11a.
And perhaps explain that the fourth character meaning.
This will be in align with their datasheets.

> DW_IC_COMP_TYPE is constant and is derived from two ASCII letters "DW"
> followed by a 16-bit unsigned number.

-- 
With Best Regards,
Andy Shevchenko


