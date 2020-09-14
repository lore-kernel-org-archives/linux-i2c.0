Return-Path: <SRS0=ekoI=CX=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764CEC433E2
	for <linux-i2c@archiver.kernel.org>; Mon, 14 Sep 2020 16:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46066206E9
	for <linux-i2c@archiver.kernel.org>; Mon, 14 Sep 2020 16:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgINQzr (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 14 Sep 2020 12:55:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:22551 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbgINQrT (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 14 Sep 2020 12:47:19 -0400
IronPort-SDR: sGrPlqj8D1/n/V/WdyaOgUcVuEDzmG2GWNDZKcuzoaoq6nv0ZaPKRXko+Ys7FYm0BNW6F1t9Dw
 Ftmnqxvn61iA==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="220665542"
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; 
   d="scan'208";a="220665542"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 09:47:14 -0700
IronPort-SDR: dA/J2j61vwW3YzS4d0QdoAx8R16fQfp47W3oJSXy65ijhFw4ZDsAExvZbu+Qgzp6x7gxPMRcDG
 DzquvQ8DeLSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; 
   d="scan'208";a="507206724"
Received: from unknown (HELO localhost.localdomain) ([10.23.185.145])
  by fmsmga005.fm.intel.com with ESMTP; 14 Sep 2020 09:47:13 -0700
Message-ID: <b11640ffc0956412c1cab112d881f569f5e7dd9a.camel@linux.intel.com>
Subject: Re: [PATCH v1] i2c: ismt: Add support for Intel Emmitsburg PCH
From:   "Seth Heasley (Linux)" <seth.heasley@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Seth Heasley <seth.heasley@intel.com>,
        Neil Horman <nhorman@tuxdriver.com>, linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa@kernel.org>
Date:   Mon, 14 Sep 2020 02:43:56 -0700
In-Reply-To: <20200615161001.12817-1-andriy.shevchenko@linux.intel.com>
References: <20200615161001.12817-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-8.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Hi Andy,

Sorry for the slow response.

> Add PCI ID for the Intel Emmitsburg PCH iSMT SMBus controller.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Signed-off-by: Seth Heasley <seth.heasley@linux.intel.com>
> ---
>  drivers/i2c/busses/i2c-ismt.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-
> ismt.c
> index 2f95e25a10f7..cdba77f9ecb1 100644
> --- a/drivers/i2c/busses/i2c-ismt.c
> +++ b/drivers/i2c/busses/i2c-ismt.c
> @@ -77,6 +77,7 @@
>  #define PCI_DEVICE_ID_INTEL_S1200_SMT1	0x0c5a
>  #define PCI_DEVICE_ID_INTEL_CDF_SMT	0x18ac
>  #define PCI_DEVICE_ID_INTEL_DNV_SMT	0x19ac
> +#define PCI_DEVICE_ID_INTEL_EBG_SMT	0x1bff
>  #define PCI_DEVICE_ID_INTEL_AVOTON_SMT	0x1f15
>  
>  #define ISMT_DESC_ENTRIES	2	/* number of descriptor entries */
> @@ -184,6 +185,7 @@ static const struct pci_device_id ismt_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL,
> PCI_DEVICE_ID_INTEL_S1200_SMT1) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CDF_SMT)
> },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_DNV_SMT)
> },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_EBG_SMT)
> },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL,
> PCI_DEVICE_ID_INTEL_AVOTON_SMT) },
>  	{ 0, }
>  };

-Seth


