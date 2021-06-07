Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5FEC47094
	for <linux-i2c@archiver.kernel.org>; Mon,  7 Jun 2021 19:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E91F0611C0
	for <linux-i2c@archiver.kernel.org>; Mon,  7 Jun 2021 19:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhFGTLx (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 7 Jun 2021 15:11:53 -0400
Received: from smtprelay0022.hostedemail.com ([216.40.44.22]:38712 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230282AbhFGTLx (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 7 Jun 2021 15:11:53 -0400
Received: from omf13.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id CA628182CF66C;
        Mon,  7 Jun 2021 19:10:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf13.hostedemail.com (Postfix) with ESMTPA id B71321124F3;
        Mon,  7 Jun 2021 19:09:59 +0000 (UTC)
Message-ID: <ae919bae6c21e23b0a1ed0c9327738e59dd90aa0.camel@perches.com>
Subject: Re: [PATCH v2 1/3] units: Add SI metric prefix definitions
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        wsa@kernel.org
Date:   Mon, 07 Jun 2021 12:09:58 -0700
In-Reply-To: <20210607152344.57458-1-andriy.shevchenko@linux.intel.com>
References: <20210607152344.57458-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Stat-Signature: 8wbx163o9au6somidwb8kb4psryybbse
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: B71321124F3
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19gfuYGN0sZkfT6xaxuUJ3RaO+6FpeJDuo=
X-HE-Tag: 1623092999-824842
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Mon, 2021-06-07 at 18:23 +0300, Andy Shevchenko wrote:
> Sometimes it's useful to have well-defined SI metric prefix to be used
> to self-describe the formulas or equations.
> 
> List most popular ones in the units.h.

trivia:

> diff --git a/include/linux/units.h b/include/linux/units.h
[]
> @@ -4,6 +4,22 @@
>  
> 
>  #include <linux/math.h>
>  
> +/* Metric prefixes in accordance with Système international (d'unités) */
> +#define PETA	1000000000000000LL
> +#define TERA	1000000000000LL
> +#define GIGA	1000000000L
> +#define MEGA	1000000L
> +#define KILO	1000L

It's perhaps more legible to avoid the long sequences of zeros by
using preprocessor mechanisms.

#define KILO (1000UL)
#define MEGA (KILO * 1000)
#define GIGA (MEGA * 1000)
#define TERA (GIGA * 1000ULL)
#define PETA (TERA * 1000)

or maybe:

#define KILO (1000UL)
#define MEGA (1000UL * 1000UL)
#define GIGA (1000UL * 1000UL * 1000UL)
#define TERA (1000ULL * 1000ULL * 1000ULL * 1000ULL)
#define PETA (1000ULL * 1000ULL * 1000ULL * 1000ULL * 1000ULL)

etc...

> +#define HECTO 100L
> +#define DECA 10L

Should it be DECA or DEKA or both?

https://www.nist.gov/pml/weights-and-measures/metric-si-prefixes
deka Example: dekameter da 	10**1 	Ten

> +#define DECI	10L
> +#define CENTI	100L
> +#define MILLI	1000L
> +#define MICRO	1000000L
> +#define NANO	1000000000L
> +#define PICO	1000000000000LL
> +#define FEMTO	1000000000000000LL

IMO: Might as well include all the prefixes up to 10**24

EXA ZETTA YOTTA, ATTA ZEPTO YOCTO

And how do people avoid using MILLI for KILO, MEGA for MICRO, etc...
The compiler won't care but usage could look odd.


