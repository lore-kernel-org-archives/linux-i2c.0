Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5500EE4993
	for <linux-i2c@archiver.kernel.org>; Tue, 22 Aug 2023 12:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjHVMDV (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 22 Aug 2023 08:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjHVMDU (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 22 Aug 2023 08:03:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7782393;
        Tue, 22 Aug 2023 05:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692705799; x=1724241799;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aVU+EGB7ogMF9UdepLrDyRBthFArXJjVizlEKlxbXdg=;
  b=UCIYLsLXRqhuSbyRE+gTUZjOboPjoogC1cjBIhouh9GODoMJLju8G7U3
   rj/d0oIpPBvZgAefHa93vh5x7kXiy12fZuymMmSmbJRyOY+5aQsoz9QY7
   hA8gedMyDuGu3cqjU01HrY/cIWtESlwjvbZoDQk3XhUE3tvZzHUN+QEoT
   gh5MBQ0Zhdn443yspE6wcGpUt1phPDoHKzye4c/r2lX7RUEjY7nUhmf6V
   26MUy2gIVMqc3821cLukDhVq2QO1GVh3twI29Bd5CreaxUh5kFtg18Opl
   +NnyWjsacIaTWjnAFCb4KMky4sos3tM8dywZkCcpu+DDeKK+x81tTEgZI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="364023248"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="364023248"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 05:02:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="729795117"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="729795117"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 22 Aug 2023 05:02:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qYQ5w-009H2B-2Y;
        Tue, 22 Aug 2023 15:02:48 +0300
Date:   Tue, 22 Aug 2023 15:02:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yann Sionneau <ysionneau@kalray.eu>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Julian Vetter <jvetter@kalrayinc.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Currently if the SoC needs pinctrl to switch the SCL
 and SDA from the I2C function to GPIO function, the recovery won't work.
Message-ID: <ZOSj6C+4q/xUNyhA@smile.fi.intel.com>
References: <20230822091555.18015-1-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822091555.18015-1-ysionneau@kalray.eu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Tue, Aug 22, 2023 at 11:15:55AM +0200, Yann Sionneau wrote:
> scl-gpio = <>;
> sda-gpio = <>;
> 
> Are not enough for some SoCs to have a working recovery.
> Some need:
> 
> scl-gpio = <>;
> sda-gpio = <>;
> pinctrl-names = "default", "recovery";
> pinctrl-0 = <&i2c_pins_hw>;
> pinctrl-1 = <&i2c_pins_gpio>;
> 
> The driver was not filling rinfo->pinctrl with the device node
> pinctrl data which is needed by generic recovery code.

...

> +	rinfo->pinctrl = devm_pinctrl_get(dev->dev);
> +	if (IS_ERR(rinfo->pinctrl)) {
> +		if (PTR_ERR(rinfo->pinctrl) == -EPROBE_DEFER)
> +			return PTR_ERR(rinfo->pinctrl);
> +
> +		rinfo->pinctrl = NULL;
> +		dev_err(dev->dev, "getting pinctrl info failed: bus recovery might not work\n");
> +	} else if (!rinfo->pinctrl) {
> +		dev_dbg(dev->dev, "pinctrl is disabled, bus recovery might not work\n");
> +	}

A bit of bikeshedding, would the below be slightly better?

	rinfo->pinctrl = devm_pinctrl_get(dev->dev);
	if (IS_ERR(rinfo->pinctrl)) {
		if (PTR_ERR(rinfo->pinctrl) == -EPROBE_DEFER)
			return PTR_ERR(rinfo->pinctrl);

		rinfo->pinctrl = NULL;
		dev_err(dev->dev, "getting pinctrl info failed, disabling...\n");
	}
	if (!rinfo->pinctrl)
		dev_dbg(dev->dev, "pinctrl is disabled, bus recovery might not work\n");

-- 
With Best Regards,
Andy Shevchenko


