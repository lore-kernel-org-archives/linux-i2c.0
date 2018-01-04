From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [2/2] i2c: ismt: dump registers at the end of transactions
Date: Thu, 4 Jan 2018 08:52:47 -0500
Message-ID: <20180104135247.GC919@hmswarspite.think-freely.org>
References: <20170818160128.21228-3-radu.rendec@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from charlotte.tuxdriver.com ([70.61.120.58]:54272 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752801AbeADNx1 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 4 Jan 2018 08:53:27 -0500
Content-Disposition: inline
In-Reply-To: <20170818160128.21228-3-radu.rendec@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Radu Rendec <radu.rendec@gmail.com>
Cc: linux-i2c@vger.kernel.org

On Fri, Aug 18, 2017 at 05:01:28PM +0100, Radu Rendec wrote:
> This patch dumps general and master registers at the end of transactions
> when debugging is enabled. Previously, registers were only dumped before
> submitting new descriptors (at the beginning of transactions).
> 
> This helps debugging if some registers change as result of a failed
> transaction (e.g. bits are set in the ERRSTS general register).
> 
> Signed-off-by: Radu Rendec <radu.rendec@gmail.com>
> ---
>  drivers/i2c/busses/i2c-ismt.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-ismt.c
> index ccce0ca..003ea53 100644
> --- a/drivers/i2c/busses/i2c-ismt.c
> +++ b/drivers/i2c/busses/i2c-ismt.c
> @@ -324,6 +324,8 @@ static int ismt_process_desc(const struct ismt_desc *desc,
>  
>  	dev_dbg(&priv->pci_dev->dev, "Processing completed descriptor\n");
>  	__ismt_desc_dump(&priv->pci_dev->dev, desc);
> +	ismt_gen_reg_dump(priv);
> +	ismt_mstr_reg_dump(priv);
>  
>  	if (desc->status & ISMT_DESC_SCS) {
>  		if (read_write == I2C_SMBUS_WRITE &&
Acked-by: Neil Horman <nhorman@tuxdriver.com>
