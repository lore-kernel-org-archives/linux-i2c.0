Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91B0C433EF
	for <linux-i2c@archiver.kernel.org>; Thu, 23 Sep 2021 06:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADE5960F23
	for <linux-i2c@archiver.kernel.org>; Thu, 23 Sep 2021 06:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239398AbhIWGxW (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 23 Sep 2021 02:53:22 -0400
Received: from mga06.intel.com ([134.134.136.31]:16815 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239370AbhIWGxW (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 23 Sep 2021 02:53:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="284789026"
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="284789026"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 23:51:51 -0700
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="474756213"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 23:51:49 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 23 Sep 2021 09:51:46 +0300
Date:   Thu, 23 Sep 2021 09:51:46 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jamie Iles <quic_jiles@quicinc.com>
Cc:     linux-i2c@vger.kernel.org,
        Octavian Purdila <octavian.purdila@intel.com>,
        Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH] i2c / ACPI: fix resource leak in reconfiguration device
 addition
Message-ID: <YUwkAv2MFuNJt7/e@lahna>
References: <20210922165718.179585-1-quic_jiles@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922165718.179585-1-quic_jiles@quicinc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Wed, Sep 22, 2021 at 05:57:18PM +0100, Jamie Iles wrote:
> acpi_i2c_find_adapter_by_handle() calls bus_find_device() which takes a
> reference on the adapter which is never released which will result in a
> reference count leak and render the adapter unremovable.  Make sure to
> put the adapter after creating the client in the same manner that we do
> for OF.
> 
> Fixes: 525e6fabeae2 ("i2c / ACPI: add support for ACPI reconfigure notifications")
> Cc: Octavian Purdila <octavian.purdila@intel.com>
> Cc: Wolfram Sang <wsa@kernel.org>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
