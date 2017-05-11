From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v9 5/6] i2c: designware: add SLAVE mode functions
Date: Thu, 11 May 2017 16:32:24 +0300
Message-ID: <1494509544.6967.6.camel@linux.intel.com>
References: <cover.1493893241.git.lolivei@synopsys.com>
         <b2accd73182d19927dfb0cd1a57cadf469ae5e9d.1493893241.git.lolivei@synopsys.com>
         <1494262399.30052.69.camel@linux.intel.com>
         <f2c268ba-2f08-e6a6-2af7-b9b9b8afc49a@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:57470 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755478AbdEKNca (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 11 May 2017 09:32:30 -0400
In-Reply-To: <f2c268ba-2f08-e6a6-2af7-b9b9b8afc49a@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Luis Oliveira <Luis.Oliveira@synopsys.com>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com

On Thu, 2017-05-11 at 16:20 +0300, Jarkko Nikula wrote:
> On 05/08/2017 07:53 PM, Andy Shevchenko wrote:
> > > +	} else if (reg == (DW_IC_COMP_TYPE_VALUE & 0x0000ffff)) {
> > 
> > GENMASK(15, 0)
> > 
> 
> I don't think this increase readability compared to 0x0000ffff here.

If it's a defined constant it might do, otherwise I'm fine with explicit
value.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
