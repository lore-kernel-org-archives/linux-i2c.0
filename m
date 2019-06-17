From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 21/28] drivers: Introduce
 bus_find_device_by_acpi_dev() helper
Date: Mon, 17 Jun 2019 12:39:44 +0300
Message-ID: <20190617093944.GP2640@lahna.fi.intel.com>
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
 <1560534863-15115-22-git-send-email-suzuki.poulose@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1560534863-15115-22-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Jun 14, 2019 at 06:54:16PM +0100, Suzuki K Poulose wrote:
> Add a wrapper to bus_find_device() to search for a device
> by the ACPI COMPANION device, reusing the generic match function.
> Also convert the existing users to make use of the new helper.
> 
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
