From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] i2c: core: helper function to detect slave mode
Date: Wed, 18 Jan 2017 12:59:36 +0200
Message-ID: <1484737176.2133.191.camel@linux.intel.com>
References: <f4ec62119145bc70c938800c91eb396d30457304.1483636071.git.lolivei@synopsys.com>
         <73246c4a-504c-52d7-dde4-970a45dca0bd@mleia.com>
         <CAHp75Ve87TE3y6hg1bMxSFAPVcY3wPifGuvtpXNhBw5-eOnPrg@mail.gmail.com>
         <b5788d1d-c951-0fc3-eed8-88457df1f27e@mleia.com>
         <CAHp75Ve7zNN3m1ngLGi-81mFehKzZG07mh5H2T5+_k-=jJqqNA@mail.gmail.com>
         <3748130b-5321-12eb-ec75-e2637dd9fc54@mleia.com>
         <1484240482.2133.92.camel@linux.intel.com>
         <7fdf5d3c-d0ea-ec45-6b18-4573fff6dd11@synopsys.com>
         <f751ffbe-f9f8-c5bd-3b1a-2edd91152a78@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:24772 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754224AbdARLDJ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 18 Jan 2017 06:03:09 -0500
In-Reply-To: <f751ffbe-f9f8-c5bd-3b1a-2edd91152a78@mleia.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>, Luis Oliveira <Luis.Oliveira@synopsys.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ramiro.Oliveira@synopsys.com, Joao Pinto <Joao.Pinto@synopsys.com>, CARLOS.PALMINHA@synopsys.com

On Tue, 2017-01-17 at 01:14 +0200, Vladimir Zapolskiy wrote:


> review comments then, for example it is not obvious that on a platform
> with both CONFIG_ACPI and CONFIG_OF enabled there should be an
> exclusive
> selection of only one of two possible branches as in your code etc.

ACPI and DT approach differently to this property. Like I already said
to you check GPIO library where we have similarities.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
