From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 16/16] i2c: SMBus: remove __dev* attributes
Date: Wed, 28 Nov 2012 14:32:02 +0100
Message-ID: <20121128143202.23405196@endymion.delvare>
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

Oh, BTW...

On Tue, 27 Nov 2012 15:59:53 -0500, Bill Pemberton wrote:
> diff --git a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
> index 392303b..fbea3cf 100644
> --- a/drivers/i2c/busses/i2c-nforce2.c
> +++ b/drivers/i2c/busses/i2c-nforce2.c
> @@ -117,7 +117,7 @@ struct nforce2_smbus {
>  #define MAX_TIMEOUT	100
>  
>  /* We disable the second SMBus channel on these boards */
> -static struct dmi_system_id __devinitdata nforce2_dmi_blacklist2[] = {
> +static struct dmi_system_id nforce2_dmi_blacklist2[] = {
>  	{
>  		.ident = "DFI Lanparty NF4 Expert",
>  		.matches = {
> @@ -330,7 +330,7 @@ static DEFINE_PCI_DEVICE_TABLE(nforce2_ids) = {
>  MODULE_DEVICE_TABLE (pci, nforce2_ids);
>  
>  
> -static int __devinit nforce2_probe_smb (struct pci_dev *dev, int bar,
> +static int nforce2_probe_smb (struct pci_dev *dev, int bar,
>  	int alt_reg, struct nforce2_smbus *smbus, const char *name)
>  {
>  	int error;

There is a checkpatch warning reported here:

WARNING: space prohibited between function name and open parenthesis '('
#390: FILE: drivers/i2c/busses/i2c-nforce2.c:333:
+static int nforce2_probe_smb (struct pci_dev *dev, int bar,

Please fix while you're here.

Thanks,
-- 
Jean Delvare
