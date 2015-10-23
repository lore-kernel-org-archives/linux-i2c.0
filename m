From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/1] i2c: designware: reverts "i2c: designware: Add
 support for AMD I2C controller"
Date: Fri, 23 Oct 2015 11:32:18 +0300
Message-ID: <20151023083218.GQ1526@lahna.fi.intel.com>
References: <1445578127.2977.23.camel@kxue-X58A-UD3R>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445578127.2977.23.camel@kxue-X58A-UD3R>
Sender: linux-kernel-owner@vger.kernel.org
To: Ken Xue <Ken.Xue@amd.com>
Cc: baruch@tkos.co.il, SPG_Linux_Kernel@amd.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Oct 23, 2015 at 01:28:47PM +0800, Ken Xue wrote:
> The patch reverts commit a445900c9060 (i2c: designware: Add support for
> AMD I2C controller)
> 
> Since kernel starts to support APD(drivers/acpi/acpi_apd.c), there is
> no need to get freq from id->driver_data for AMD0010. clkdev is supposed
> to be already registered in APD.
> 
> So, revert old design and make AMD0010 looks like other ones.
> 
> Signed-off-by: Ken Xue <Ken.Xue@amd.com>
> Signed-off-by: Xiangliang Yu <Xiangliang.Yu@amd.com>

You could also mention that the commit never even worked.

Anyway, I'm happy that this is removed so

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
