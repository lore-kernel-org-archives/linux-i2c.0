Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB50C433F5
	for <linux-i2c@archiver.kernel.org>; Mon, 14 Feb 2022 15:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355654AbiBNPKu (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 14 Feb 2022 10:10:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355658AbiBNPKe (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 14 Feb 2022 10:10:34 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648C94E398;
        Mon, 14 Feb 2022 07:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644851426; x=1676387426;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=kKVOBmMe2B7p8elBdEp7lhzQwa1aL7hnCEPJyvhHj1I=;
  b=QEhlFIzQZ89Oq1L/pSpv5Z7mutPmU+z86pwikYXDpqp9db7Ot7Si0GLX
   ug7PuoGS/wO1eW7HEIO99bGG/th59GpxTjK/4nnlG0rKv/mkLZrLGyOGJ
   TweehWXGH90K446wLWr053ZL+VfEdKPPNNMIl2xw2igB7R8X1KRPLfWvG
   ztZt2IHZ2TsgImfTn9OWqNzyGtraG/hGN+91lGbliDyoBk70ZKeBWu4c4
   Osjc6YVSHwL7KYVY7fq7iL07ISQ2eQkkDPho9drPJD5pTKBOXoy6uSZG4
   s4ACdjZz4fGNfwg77X1EyEQ/h952V0PceY/0pDZcPIgAxcQm3PLDEjvmQ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="237516123"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="237516123"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 07:10:26 -0800
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="495709581"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.59])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 07:10:24 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nJcyn-004Zzv-JX;
        Mon, 14 Feb 2022 17:09:29 +0200
Date:   Mon, 14 Feb 2022 17:09:29 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wolfram Sang <wsa@kernel.org>,
        syzbot+0591ccf54ee05344e4eb@syzkaller.appspotmail.com
Subject: Re: [PATCH v1 1/1] i2c: smbus: Check for parent device before
 dereference
Message-ID: <YgpwqcRbDp38+NAa@smile.fi.intel.com>
References: <20220204155920.13364-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220204155920.13364-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Fri, Feb 04, 2022 at 05:59:20PM +0200, Andy Shevchenko wrote:
> An I²C adapter might be instantiated without parent. In such case
> there is no property can be retrieved. Skip SMBus alert setup when
> this happens.

As of today the problem is still in v5.17-rcX.

-- 
With Best Regards,
Andy Shevchenko


