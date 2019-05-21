From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/5] i2c: acpi: Factor out getting the IRQ from ACPI
Date: Tue, 21 May 2019 14:17:10 +0300
Message-ID: <20190521111710.GW2781@lahna.fi.intel.com>
References: <20190520084936.10590-1-ckeepax@opensource.cirrus.com>
 <20190520084936.10590-2-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190520084936.10590-2-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com, jbroadus@gmail.com, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org

On Mon, May 20, 2019 at 09:49:32AM +0100, Charles Keepax wrote:
> In preparation for future refactoring factor out the fetch of the IRQ
> into its own helper function.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/i2c/i2c-core-acpi.c | 40 +++++++++++++++++++++++++---------------
>  1 file changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
> index 2728006920888..c3ac3ea184317 100644
> --- a/drivers/i2c/i2c-core-acpi.c
> +++ b/drivers/i2c/i2c-core-acpi.c
> @@ -137,13 +137,35 @@ static int i2c_acpi_do_lookup(struct acpi_device *adev,
>  	return 0;
>  }
>  
> +static int i2c_acpi_get_irq(struct acpi_device *adev, int *irq)

I think here the function should return irq instead, and negative errno
in case of failure.
