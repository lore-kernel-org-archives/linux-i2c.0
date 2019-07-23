From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: busses: Use dev_get_drvdata where possible
Date: Tue, 23 Jul 2019 20:34:52 +0200
Message-ID: <20190723203452.5714f142@endymion>
References: <20190723111110.11121-1-hslester96@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190723111110.11121-1-hslester96@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chuhong Yuan <hslester96@gmail.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 23 Jul 2019 19:11:10 +0800, Chuhong Yuan wrote:
> Instead of using to_pci_dev + pci_get_drvdata,
> use dev_get_drvdata to make code simpler.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  drivers/i2c/busses/i2c-designware-pcidrv.c | 6 ++----
>  drivers/i2c/busses/i2c-i801.c              | 3 +--
>  2 files changed, 3 insertions(+), 6 deletions(-)
> (...)

Looks good to me, thanks.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
