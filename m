From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 7/7] i2c: remove legacy integer scl/sda gpio for
 recovery
Date: Tue, 31 Oct 2017 12:19:48 +0200
Message-ID: <1509445188.10233.110.camel@linux.intel.com>
References: <1509435239-64848-1-git-send-email-preid@electromag.com.au>
         <1509435239-64848-8-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:8247 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932272AbdJaKTw (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 31 Oct 2017 06:19:52 -0400
In-Reply-To: <1509435239-64848-8-git-send-email-preid@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>, nsekhar@ti.com, khilman@kernel.org, wsa@the-dreams.de, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, fntoth@gmail.com

On Tue, 2017-10-31 at 15:33 +0800, Phil Reid wrote:
> Remove all reference to code related to using integer based ids for
> scl/sda gpio for bus recovery. All in tree drivers are now using the
> gpio descriptors to specific the required gpios.

> - * @scl_gpio: gpio number of the SCL line. Only required for GPIO
> recovery.
> - * @sda_gpio: gpio number of the SDA line. Only required for GPIO
> recovery.
> + * @scl_gpiod: gpiod of the SCL line. Only required for GPIO
> recovery.
> + * @sda_gpiod: gpiod of the SDA line. Only required for GPIO
> recovery.

Ah, missed comment here.

0day kbuild bot now warns if we add field w/o kernel doc description.

I would suggest to add the descriptions in the same patch which brings
new fields and here just remove old ones.

>  	/* gpio recovery */
> -	int scl_gpio;
> -	int sda_gpio;

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
