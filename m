From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: at24: Add address-width property
Date: Wed, 27 Jun 2018 10:59:16 +0300
Message-ID: <20180627075915.dwqo6w55c7xxvjmt@paasikivi.fi.intel.com>
References: <1530078385-1546-1-git-send-email-alanx.chiang@intel.com>
 <1530078385-1546-2-git-send-email-alanx.chiang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1530078385-1546-2-git-send-email-alanx.chiang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alanx.chiang@intel.com
Cc: linux-i2c@vger.kernel.org, andy.yeh@intel.com, andriy.shevchenko@linux.intel.com, andriy.shevchenko@intel.com, rajmohan.mani@intel.com, andy.shevchenko@gmail.com, tfiga@chromium.org, jcliang@chromium.org, brgl@bgdev.pl, robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 27, 2018 at 01:46:24PM +0800, alanx.chiang@intel.com wrote:
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

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
