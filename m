From: atull <atull@opensource.altera.com>
Subject: Re: [PATCH] i2c designware add support of I2C standard mode
Date: Thu, 18 Sep 2014 10:52:24 -0500
Message-ID: <alpine.DEB.2.02.1409181050190.29539@atx-linux-37>
References: <20140820124231.GD21734@leverpostej> <1408544948-22339-1-git-send-email-romainba@abilis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1408544948-22339-1-git-send-email-romainba@abilis.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Romain Baeriswyl <Romain.Baeriswyl@abilis.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Christian Ruppert <christian.ruppert@abilis.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, baruch@tkos.co.il, grant.likely@linaro.org, robh+dt@kernel.org, skuribay@pobox.com, alan@linux.intel.com, devicetree@vger.kernel.org, delicious.quinoa@gmail.com, dinguyen@opensource.altera.com, yvanderv@opensource.altera.com, Romain Baeriswyl <romainba@abilis.com>
List-Id: linux-i2c@vger.kernel.org

On Wed, 20 Aug 2014, Romain Baeriswyl wrote:

> From: Romain Baeriswyl <Romain.Baeriswyl@abilis.com>
> 
> Some legacy devices support ony I2C standard mode at 100kHz.
> This patch allows to select the standard mode through the DTS
> with the use of the existing clock-frequency parameter.
> 
> When clock-frequency parameter is not set, the fast mode is selected.
> Only when the parameter is set at 100000, the standard mode is selected.
> 
> Signed-off-by: Romain Baeriswyl <romainba@abilis.com>
> Reviewed-by: Christian Ruppert <christian.ruppert@abilis.com>
> ---
>  drivers/i2c/busses/i2c-designware-platdrv.c |   23 +++++++++++++++++++++--
>  1 files changed, 21 insertions(+), 2 deletions(-)
> 

Hi Wolfram,

This patch is really useful for us.  Is it going to be picked up?

Alan
