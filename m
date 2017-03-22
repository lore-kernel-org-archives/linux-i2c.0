From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v7 4/6] i2c: designware: introducing I2C_SLAVE definitions
Date: Wed, 22 Mar 2017 16:39:26 +0200
Message-ID: <34b4eba8-3bfd-85f0-fb20-cbe597075429@linux.intel.com>
References: <cover.1490007620.git.lolivei@synopsys.com>
 <55d2ccf235080a77347ad9e3a34263ca9cc8f80d.1490007620.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55d2ccf235080a77347ad9e3a34263ca9cc8f80d.1490007620.git.lolivei@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis Oliveira <Luis.Oliveira@synopsys.com>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com
List-Id: linux-i2c@vger.kernel.org

On 03/20/17 13:10, Luis Oliveira wrote:
> - Definitions were added to core library
> - A example was added to designware-core.txt Documentation that shows
>   how the slave can be setup using DTS
>
> SLAVE related definitions were added to the core of the controller.
>
> Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> v6-v7
> - no changes
>
>  .../devicetree/bindings/i2c/i2c-designware.txt     | 16 +++++++++++-
>  drivers/i2c/busses/i2c-designware-core.h           | 29 +++++++++++++++++++++-

For the i2c-designware-core.h

Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
