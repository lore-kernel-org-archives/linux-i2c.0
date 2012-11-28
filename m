From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 16/16] i2c: SMBus: remove __dev* attributes
Date: Wed, 28 Nov 2012 14:23:49 +0100
Message-ID: <20121128142349.629db0c0@endymion.delvare>
References: <1354049993-12718-1-git-send-email-wfp5p@virginia.edu>
	<1354049993-12718-17-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1354049993-12718-17-git-send-email-wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Bill,

On Tue, 27 Nov 2012 15:59:53 -0500, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option.  As result the __dev*
> markings will be going away.
> 
> Remove use of __devinit, __devexit_p, __devinitdata, __devinitconst,
> and __devexit.
> 
> Signed-off-by: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-ali1535.c |  8 ++++----
>  drivers/i2c/busses/i2c-ali15x3.c |  8 ++++----
>  drivers/i2c/busses/i2c-amd756.c  |  6 +++---
>  drivers/i2c/busses/i2c-amd8111.c |  6 +++---
>  drivers/i2c/busses/i2c-i801.c    | 24 ++++++++++++------------
>  drivers/i2c/busses/i2c-isch.c    |  6 +++---
>  drivers/i2c/busses/i2c-nforce2.c | 10 +++++-----
>  drivers/i2c/busses/i2c-piix4.c   | 20 ++++++++++----------
>  drivers/i2c/busses/i2c-sis5595.c |  4 ++--
>  drivers/i2c/busses/i2c-sis630.c  |  8 ++++----
>  drivers/i2c/busses/i2c-via.c     |  6 +++---
>  drivers/i2c/busses/i2c-viapro.c  |  2 +-
>  12 files changed, 54 insertions(+), 54 deletions(-)

Looks mostly OK, just two suggestions:

> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index 1e73638..6c5a732 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -841,13 +841,13 @@ struct dmi_onboard_device_info {
>  	const char *i2c_type;
>  };
>  
> -static struct dmi_onboard_device_info __devinitdata dmi_devices[] = {
> +static struct dmi_onboard_device_info dmi_devices[] = {
>  	{ "Syleus", DMI_DEV_TYPE_OTHER, 0x73, "fscsyl" },
>  	{ "Hermes", DMI_DEV_TYPE_OTHER, 0x73, "fscher" },
>  	{ "Hades",  DMI_DEV_TYPE_OTHER, 0x73, "fschds" },
>  };

If I remember correctly, the only reason why this wasn't declared const
was because this was not compatible with __devinitdata. Now that
__devinitdata is gone, the leading "static" should become "static
const". Same goes for the 4 other occurrences in this patch, and I
suppose, many other cases in other subsystems.

> diff --git a/drivers/i2c/busses/i2c-viapro.c b/drivers/i2c/busses/i2c-viapro.c
> index 271c9a2..3426196 100644
> --- a/drivers/i2c/busses/i2c-viapro.c
> +++ b/drivers/i2c/busses/i2c-viapro.c
> @@ -320,7 +320,7 @@ static struct i2c_adapter vt596_adapter = {
>  	.algo		= &smbus_algorithm,
>  };
>  
> -static int __devinit vt596_probe(struct pci_dev *pdev,
> +static int vt596_probe(struct pci_dev *pdev,
>  				 const struct pci_device_id *id)
>  {
>  	unsigned char temp;

Now this would fit on a single line. There are many other occurrences
of this. I know this can't be easily automated, but it would be great
if your patches could put the code back on the previous line when this
is possible.

-- 
Jean Delvare
