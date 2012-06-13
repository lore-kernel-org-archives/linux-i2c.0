From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c-piix4: eliminate piix4_smba global variable
Date: Wed, 13 Jun 2012 21:37:36 +0200
Message-ID: <20120613213736.7b5bc18d@endymion.delvare>
References: <20120613094739.360967aa@endymion.delvare>
	<1339606749-4578-1-git-send-email-andrew@asquaredlabs.com>
	<1339606749-4578-2-git-send-email-andrew@asquaredlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1339606749-4578-2-git-send-email-andrew-Lwj1yN59in/Ib2jZbfQ/kQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Armenia <andrew-Lwj1yN59in/Ib2jZbfQ/kQ@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 13 Jun 2012 12:59:07 -0400, Andrew Armenia wrote:
> Some chipsets have multiple sets of piix4-compatible SMBus registers.
> Eliminating the global variable will allow these chipsets to be fully
> supported.
> 
> Return value from piix4_setup and piix4_sb800_setup now returns the smba
> value detected. This is stored in a struct i2c_piix4_adapdata. Thus
> the global variable is eliminated.
> 
> Signed-off-by: Andrew Armenia <andrew-Lwj1yN59in/Ib2jZbfQ/kQ@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-piix4.c |   54 ++++++++++++++++++++++++++++------------
>  1 file changed, 38 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
> index c14d48d..61a85c9 100644
> --- a/drivers/i2c/busses/i2c-piix4.c
> +++ b/drivers/i2c/busses/i2c-piix4.c
> (...)
> -static void __devexit piix4_remove(struct pci_dev *dev)
> +static void __devinit piix4_adap_remove(struct i2c_adapter *adap)

You mean __devexit here.

Other than this, looks good, applied, thanks.

-- 
Jean Delvare
