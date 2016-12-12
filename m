From: Luis de Oliveira <Luis.Oliveira@synopsys.com>
Subject: RE: [PATCH v4 3/5] i2c: designware: Add slave definitions
Date: Mon, 12 Dec 2016 18:35:47 +0000
Message-ID: <BCF0D4927F9C694C9AEA8827D4A9C7C897CE12@de02wembxa.internal.synopsys.com>
References: <cover.1481131072.git.lolivei@synopsys.com>
 <5173a9456c423025d8f15baafa2499440cbe1b51.1481131072.git.lolivei@synopsys.com>
 <20161212170214.4cydp256jsp7srar@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:57829 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752111AbcLLSfw (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 12 Dec 2016 13:35:52 -0500
In-Reply-To: <20161212170214.4cydp256jsp7srar@rob-hp-laptop>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Luis Oliveira <Luis.Oliveira@synopsys.com>
Cc: "wsa@the-dreams.de" <wsa@the-dreams.de>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "jarkko.nikula@linux.intel.com" <jarkko.nikula@linux.intel.com>, "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Ramiro.Oliveira@synopsys.com" <Ramiro.Oliveira@synopsys.com>, "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>, "CARLOS.PALMINHA@synopsys.com" <CARLOS.PALMINHA@synopsys.com>

Hi all,

The slave address could be set by the I2C slave backend so I can't use it to setup the controller. 
A boolean property was my initial approach then Andy and Wolfram Sang suggested the use of compatible strings and later It was suggested to use a property to select mode but I can do it again if it's the best way. 
Can you please tell me where should it be documented? 

Luis

-----Original Message-----
From: Rob Herring [mailto:robh@kernel.org] 
Sent: Monday, December 12, 2016 17:02
To: Luis Oliveira <Luis.Oliveira@synopsys.com>
Cc: wsa@the-dreams.de; mark.rutland@arm.com; jarkko.nikula@linux.intel.com; andriy.shevchenko@linux.intel.com; mika.westerberg@linux.intel.com; linux-i2c@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Ramiro.Oliveira@synopsys.com; Joao.Pinto@synopsys.com; CARLOS.PALMINHA@synopsys.com
Subject: Re: [PATCH v4 3/5] i2c: designware: Add slave definitions

On Wed, Dec 07, 2016 at 05:55:50PM +0000, Luis Oliveira wrote:
> - Add slave definitions to i2c-designware-core
> - Changes in Kconfig to auto-enable I2C_SLAVE when compiling the 
> modules
> - Add mode property to designware-core.txt that enable the "slave" selection:
>   - "mode" is an optional property that could be "slave" or "master"
>   - if "mode" is not set the block is considered master by default
> 
> Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
> ---
> Changes V3->V4: (Andy Shevchenko)
> - created a common property for modes
> - placed the generic dependency first
> 
>  .../devicetree/bindings/i2c/i2c-designware.txt     |  4 ++++
>  drivers/i2c/busses/Kconfig                         |  1 +
>  drivers/i2c/busses/i2c-designware-common.c         |  6 +++++
>  drivers/i2c/busses/i2c-designware-core.h           | 26 ++++++++++++++++++++++
>  4 files changed, 37 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-designware.txt 
> b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> index fee26dc3e858..8ed2b532cd54 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> @@ -20,6 +20,9 @@ Optional properties :
>   - i2c-sda-falling-time-ns : should contain the SDA falling time in nanoseconds.
>     This value which is by default 300ns is used to compute the tHIGH period.
>  
> + - mode : should be either:
> +           - "master" to setup the hardware block as a I2C master
> +           - "slave" to setup the hardware block as a I2C slave

This should be documented in a common location. Can't it be a boolean to enable slave mode? Or don't you need to set the slave address? That could be enough to enable slave mode and there's already one example doing that.

Rob
