From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] i2c: designware: Cleaning and comment style fixes.
Date: Thu, 15 Dec 2016 16:56:45 +0200
Message-ID: <1481813805.9552.31.camel@linux.intel.com>
References: <d7b5a22ce09539c2af343c21ca69675bef6a0a10.1481812563.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:2617 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755599AbcLOO4v (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 15 Dec 2016 09:56:51 -0500
In-Reply-To: <d7b5a22ce09539c2af343c21ca69675bef6a0a10.1481812563.git.lolivei@synopsys.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Luis Oliveira <Luis.Oliveira@synopsys.com>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com

On Thu, 2016-12-15 at 14:38 +0000, Luis Oliveira wrote:
> The purpose of this commit is to fix some comments and styling issues
> in the
> existing code due to the need of reuse this code. What is being made
> here is:
> 
> - Sorted the headers files
> - Corrected some comments style
> - Reverse tree in the variables declaration
> - Add/remove empty lines and tabs where needed
> - Fix of a misspelled word
> 

So, I'm okay with the change as long as no-one objecting it. As I
mentioned earlier it might rise concerns and better if you put the
answers to the commit message.

Also, comment below.

> @@ -113,10 +113,10 @@
>  #define TIMEOUT			20 /* ms */
>  
>  /*
> - * hardware abort codes from the DW_IC_TX_ABRT_SOURCE register
> + * Hardware abort codes from the DW_IC_TX_ABRT_SOURCE register
>   *

> - * only expected abort codes are listed here
> - * refer to the datasheet for the full list
> + * Only expected abort codes are listed here
> + * refer to the datasheet for the full list.

Feels either comma is missing, or they are two different sentences.

>   */
>  #define ABRT_7B_ADDR_NOACK	0
>  #define ABRT_10ADDR1_NOACK	1

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
