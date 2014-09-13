From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] [REGRESSION] i2c-acpi: Fix NULL Pointer dereference
Date: Sat, 13 Sep 2014 09:34:31 +0300
Message-ID: <20140913063431.GJ10854@lahna.fi.intel.com>
References: <1410548987-3558-1-git-send-email-peterhuewe@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1410548987-3558-1-git-send-email-peterhuewe@gmx.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Peter Huewe <peterhuewe@gmx.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Sep 12, 2014 at 09:09:47PM +0200, Peter Huewe wrote:
> If adapter->dev.parent == NULL there is a NULL pointer dereference in
> acpi_i2c_install_space_handler and acpi_i2c_remove_space_handler.
> 
> This is present since introduction of this code:
> 366047515c6e "i2c: rework kernel config I2C_ACPI" or even
> da3c6647ee08 "I2C/ACPI: Clean up I2C ACPI code and Add CONFIG_I2C_ACPI"
> 
> The adapter->dev.parent == NULL case is valid for the i2c_stub,
> so loading i2c_stub with ACPI_I2C_OPREGION enabled results in an oops.
> This is also valid at least for i2c_tiny_usb and i2c_robotfuzz_osif.
> 
> Fix by checking whether it is null before calling ACPI_HANDLE.
> 
> Signed-off-by: Peter Huewe <peterhuewe@gmx.de>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
