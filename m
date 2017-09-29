From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 1/4] i2c: Switch to using gpiod interface for gpio
 bus recovery
Date: Fri, 29 Sep 2017 14:48:13 +0300
Message-ID: <1506685693.16112.172.camel@linux.intel.com>
References: <1504073857-122449-1-git-send-email-preid@electromag.com.au>
         <1504073857-122449-2-git-send-email-preid@electromag.com.au>
         <1506595483.16112.137.camel@linux.intel.com>
         <2ecc500b-42ec-8f30-b8cf-fd646eaaa198@linux.intel.com>
         <1506596304.16112.155.camel@linux.intel.com>
         <249f3801-d7b0-dd27-a838-6e7ca6967447@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:11720 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751091AbdI2LsQ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 29 Sep 2017 07:48:16 -0400
In-Reply-To: <249f3801-d7b0-dd27-a838-6e7ca6967447@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, mika.westerberg@linux.intel.com, wsa@the-dreams.de, tim@krieglstein.org, linux-i2c@vger.kernel.org

On Fri, 2017-09-29 at 14:59 +0800, Phil Reid wrote:
> On 28/09/2017 18:58, Andy Shevchenko wrote:
> > On Thu, 2017-09-28 at 13:54 +0300, Jarkko Nikula wrote:

> > I didn't check and my memory is clean about users.
> > So, if there are users of those integers outside of I2C core,
> > definitely
> > we need more patches / iterations.
> > 
> 
> There's a couple of drivers using those.
> If my approach looks good then I can try and update those as well.
> 
> Question is does it all need to be in the one patch series?

Depends on your choice.
Either will work (at least for me).

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
