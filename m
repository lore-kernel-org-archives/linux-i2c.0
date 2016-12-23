From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v2] i2c: designware: add reset interface
Date: Fri, 23 Dec 2016 11:26:32 +0100
Message-ID: <1482488792.2394.21.camel@pengutronix.de>
References: <1479789700-19532-1-git-send-email-zhangfei.gao@linaro.org>
         <1481792388-13781-1-git-send-email-zhangfei.gao@linaro.org>
         <1481805227.9552.15.camel@linux.intel.com>
         <fda7e3ef-5bc1-9837-b421-4293baa3de34@synopsys.com>
         <fd0afd5f-6ee4-a06f-2d03-444f71662c1b@linaro.org>
         <49a5d8a4-864e-e80e-eee0-57c876d25aaf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:60157 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966126AbcLWK1J (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 23 Dec 2016 05:27:09 -0500
In-Reply-To: <49a5d8a4-864e-e80e-eee0-57c876d25aaf@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: zhangfei <zhangfei.gao@linaro.org>
Cc: Ramiro Oliveira <Ramiro.Oliveira@synopsys.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "jarkko.nikula@linux.intel.com" <jarkko.nikula@linux.intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Hi Zhangfei,

Am Freitag, den 16.12.2016, 11:01 +0800 schrieb zhangfei:
> Hi, Philipp
> 
> On 2016年12月16日 10:45, zhangfei wrote:
[...]
> Sorry, a bit confused.
> Is that mean we should not use devm_reset_control_get_optional()
> While driver should decide whether use 
> devm_reset_control_get_optional_exclusive() or
> devm_reset_control_get_optional_shared()
> What if different platform has different requirement?
> 
> Looks the difference between _exclusive and _shared is refcount,
> How about handle this inside, and not decided by interface?

Because there is a significant difference in how the actual reset line
behaves. The shared resets are clock-like, and should only be used if
the device needs them to be deasserted to be enabled, but is fine if
they have been deasserted earlier or if they are not immediately
asserted after the device is disabled, but some time later.
For the shared / non-exclusive resets calling reset_control_assert and
then reset_control_deassert is not guaranteed to do anything at all,
because another user of the reset line could keep it deasserted.

If the device needs a reset to be issued at a certain point in time on
the other hand, for example to reset its state machine or registers to a
known good state, calling assert must guarantee to actually assert the
reset. This can only be done if the reset is exclusive.

Whether guaranteed asserts (exclusive reset lines) are necessary depends
on the device, so this decision has to be made in the driver.

regards
Philipp
