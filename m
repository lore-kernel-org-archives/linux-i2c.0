From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: Get selected speed mode sda-hold-time
 via ACPI
Date: Mon, 13 Feb 2017 12:56:11 +0200
Message-ID: <1486983371.2133.451.camel@linux.intel.com>
References: <1486726118-19447-1-git-send-email-chin.yew.tan@intel.com>
         <1486726118-19447-2-git-send-email-chin.yew.tan@intel.com>
         <1486729916.2133.444.camel@linux.intel.com>
         <1E48613D81AD0745B344B23C7C5E26B0010043FF@PGSMSX103.gar.corp.intel.com>
         <9a3c955b-6252-bc25-4b33-8a95e03eddaf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:49210 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751868AbdBMK4O (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 13 Feb 2017 05:56:14 -0500
In-Reply-To: <9a3c955b-6252-bc25-4b33-8a95e03eddaf@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Tan, Chin Yew" <chin.yew.tan@intel.com>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On Mon, 2017-02-13 at 11:33 +0200, Jarkko Nikula wrote:
> On 13.02.2017 10:41, Tan, Chin Yew wrote:
> > 
> > > On Fri, 2017-02-10 at 19:28 +0800, chin.yew.tan@intel.com wrote:
> > > > From: Tan Chin Yew <chin.yew.tan@intel.com>
> > > > 
> > > > Sda-hold-time is an important parameter for tuning i2c to meet
> > > > the
> > > > electrical specification especially for high speed. I2C with
> > > > incorrect
> > > > sda-hold-time may cause lost arbitration error. Now, the driver
> > > > is
> > > > able to get sda-hold-time for all the speed supported.

> > > > +	case 1000000:
> > > > +		dw_i2c_acpi_params(pdev, "FPCN", &dev->fp_hcnt, 
> > > > &dev-
> > > > > fp_lcnt,
> > > > 
> > > > +			   &dev->sda_hold_time);
> > > > +		break;
> > > > +	case 3400000:
> > > > +		dw_i2c_acpi_params(pdev, "HSCN", &dev->hs_hcnt, 
> > > > &dev-
> > > > > hs_lcnt,
> > > > 
> > > > +			   &dev->sda_hold_time);
> > > > +		break;
> > > 
> > > Can we prepend default with
> > > 
> > > case 400000:
> > > 
> > > here?
> > > 
> > 
> > Yes, you are right, it is best not to load settings for speed mode
> > that is
> > not supported.
> > 
> 
> Andy: I guess you were looking for adding "case 400000:" for
> readability 
> rather than removing the default case?

Correct. To explicitly show that default we rather assume 400000, but if
 it's not, still go that branch.

> 
> I think it's best to keep fall back to 400 kHz speed that has been
> the 
> default in this driver in case we get some not supported speed from
> ACPI.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
