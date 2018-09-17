From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: Re: [PATCH v3 0/3] i2c: designware: select gpio/default pin when
 prepare/unprepare recovery
Date: Mon, 17 Sep 2018 11:31:34 +0800
Message-ID: <20180917113121.3a885957@xhacker.debian>
References: <20180917112633.252c591c@xhacker.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180917112633.252c591c@xhacker.debian>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

+ DT maintainers

On Mon, 17 Sep 2018 11:26:33 +0800
Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:

> On some platforms, the sda/scl pins are muxed with gpio functions, so
> they could be used for recovery. Select the gpio/default pin function
> when prepare/unprepare recovery.
> 
> patch1 adds the missing scl-gpios, sda-gpios properties binding doc.
> patch2 adds the pintrl property for i2c bus recovery.
> patch3 selects gpio/default pin when prepare/unprepare recovery.
> 
> Since v2:
>  - add missing property dt-binding
> 
> Since v1:
>  - use IS_ERR_OR_NULL
> 
> Jisheng Zhang (3):
>   dt-bindings: i2c: designware: add optional gpio recovery properties
>   dt-bindings: i2c: designware: add optional pinctrl for bus recovery
>   i2c: designware: select gpio/default pin when prepare/unprepare
>     recovery
> 
>  .../bindings/i2c/i2c-designware.txt           | 12 ++++++++++
>  drivers/i2c/busses/i2c-designware-core.h      |  3 +++
>  drivers/i2c/busses/i2c-designware-master.c    | 22 +++++++++++++++++++
>  3 files changed, 37 insertions(+)
> 
