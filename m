From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: Re: [PATCH] i2c: designware: Add support for AMD Seattle I2C
Date: Tue, 15 Dec 2015 20:14:34 -0600
Message-ID: <5670C90A.5020305@amd.com>
References: <1450216553-5641-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450216553-5641-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mika.westerberg@linux.intel.com, wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Mika,

On 12/15/15 15:55, Suravee Suthikulpanit wrote:
> Add device HID AMDI0510 to match the I2C controlers on AMD Seattle platform
>
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> ---
>   drivers/i2c/busses/i2c-designware-platdrv.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 57f623b..a027154 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -117,6 +117,7 @@ static const struct acpi_device_id dw_i2c_acpi_match[] = {
>   	{ "80860F41", 0 },
>   	{ "808622C1", 0 },
>   	{ "AMD0010", 0 },
> +	{ "AMDI0510", 0 },
>   	{ }

Since this driver seems to be used by several SOCs, and we have been 
adding the HID from various SOC vendors. Do you think it would be better 
to assign a CID so that each SOC vendor can specify in their ACPI DSDT 
and we can match them here?

Then, we can also associate the FMCN and SSCN along with the CID, and 
guarantee compatibility.

Thanks,
Suravee

>   };
>   MODULE_DEVICE_TABLE(acpi, dw_i2c_acpi_match);
>
