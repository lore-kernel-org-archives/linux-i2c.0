From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 3/4] Device bindings documentation updated
 ACPI-enabled platforms not currently supported
Date: Fri, 14 Oct 2016 18:30:15 +0100
Message-ID: <20161014173014.GA26269@leverpostej>
References: <cover.1476462204.git.lolivei@synopsys.com>
 <36f4b1736e36b039af15b13645df0de492f1b6e1.1476462204.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <36f4b1736e36b039af15b13645df0de492f1b6e1.1476462204.git.lolivei@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis.Oliveira@synopsys.com
Cc: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org, CARLOS.PALMINHA@synopsys.com, Ramiro.Oliveira@synopsys.com
List-Id: linux-i2c@vger.kernel.org

On Fri, Oct 14, 2016 at 05:52:50PM +0100, Luis.Oliveira@synopsys.com wrote:
> -		is_slave = device_property_read_bool(&pdev->dev, "isslave");

Which tree is this based on? I cant see the existing isslave property in
mainline HEAD (commit 29fbff8698fc0ac1).

> +#ifndef CONFIG_ACPI
> +		is_slave = device_property_read_bool(&pdev->dev, "is-slave");
> +#endif

This ifdef is broken. At least for arm64, a single kernel image can be
booted with either ACPI or DT. We need separate accessors for DT and
ACPI to handle these differently, or you need to explicitly check
whether or not you have ACPI or DT at runtime.

Thanks,
Mark.
