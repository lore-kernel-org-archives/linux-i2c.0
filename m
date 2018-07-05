From: Rob Herring <robh@kernel.org>
Subject: Re: [RESEND PATCH v4 1/2] dt-bindings: at24: Add address-width
 property
Date: Thu, 5 Jul 2018 15:22:04 -0600
Message-ID: <20180705212204.GA10449@rob-hp-laptop>
References: <1530522740-2798-1-git-send-email-alanx.chiang@intel.com>
 <1530522740-2798-2-git-send-email-alanx.chiang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1530522740-2798-2-git-send-email-alanx.chiang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alanx.chiang@intel.com
Cc: linux-i2c@vger.kernel.org, andy.yeh@intel.com, sakari.ailus@linux.intel.com, andriy.shevchenko@linux.intel.com, andriy.shevchenko@intel.com, rajmohan.mani@intel.com, andy.shevchenko@gmail.com, tfiga@chromium.org, jcliang@chromium.org, brgl@bgdev.pl, mark.rutland@arm.com, arnd@arndb.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Jul 02, 2018 at 05:12:19PM +0800, alanx.chiang@intel.com wrote:
> From: Alan Chiang <alanx.chiang@intel.com>
> 
> The AT24 series chips use 8-bit address by default. If some
> chips would like to support more than 8 bits, the at24 driver
> should be added the compatible field for specfic chips.
> 
> Provide a flexible way to determine the addressing bits through
> address-width in this patch.
> 
> Signed-off-by: Alan Chiang <alanx.chiang@intel.com>
> Signed-off-by: Andy Yeh <andy.yeh@intel.com>
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> 
> ---
> since v1:
> -- Remove the address-width field in the example.
> since v2:
> -- Remove redundant space.
> since v3:
> -- Add Acked-by.
> 
> ---
>  Documentation/devicetree/bindings/eeprom/at24.txt | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
