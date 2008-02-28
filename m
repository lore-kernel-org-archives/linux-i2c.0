From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [2.6 patch] i2c-amd756.c: fix off-by-one
Date: Thu, 28 Feb 2008 21:05:42 +0100
Message-ID: <20080228210542.1c774c28@hyperion.delvare>
References: <20080227212108.GR29269@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763850AbYB1UGD@vger.kernel.org>
In-Reply-To: <20080227212108.GR29269@cs181133002.pp.htv.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: i2c@lm-sensors.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Adrian,

On Wed, 27 Feb 2008 23:21:09 +0200, Adrian Bunk wrote:
> This patch fixes an off-by-one error spotted by the Coverity checker.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>
> 
> ---
> f9829dd0d7dad9cbc08da3fceb105478e85c4137 foobar
> diff --git a/drivers/i2c/busses/i2c-amd756.c b/drivers/i2c/busses/i2c-amd756.c
> index 573abe4..2fa4318 100644
> --- a/drivers/i2c/busses/i2c-amd756.c
> +++ b/drivers/i2c/busses/i2c-amd756.c
> @@ -335,7 +335,7 @@ static int __devinit amd756_probe(struct pci_dev *pdev,
>  	u8 temp;
>  	
>  	/* driver_data might come from user-space, so check it */
> -	if (id->driver_data > ARRAY_SIZE(chipname))
> +	if (id->driver_data >= ARRAY_SIZE(chipname))
>  		return -EINVAL;
>  
>  	if (amd756_ioport) {
> 

Good catch, not sure how I managed to mess it up that way. Patch
applied, thank you.

-- 
Jean Delvare
