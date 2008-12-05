From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 1/2] i2c: misannotation in i2c-pmcmsp.c
Date: Fri, 5 Dec 2008 14:44:08 +0100
Message-ID: <20081205144408.74de2806@hyperion.delvare>
References: <200812012217.mB1MHccm011065@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200812012217.mB1MHccm011065-AB4EexQrvXRQetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Marc St-Jean <Marc_St-Jean-4W7cOCfLBmzY0TyS/+Ba5Q@public.gmane.org>
Cc: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 01 Dec 2008 14:17:38 -0800, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org wrote:
> From: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> tmp is used as host-endian and is loaded from a be64, fix the cast and the
> endian accessor used.
> 
> Signed-off-by: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
> ---
> 
>  drivers/i2c/busses/i2c-pmcmsp.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN drivers/i2c/busses/i2c-pmcmsp.c~i2c-misannotation-in-i2c-pmcmspc drivers/i2c/busses/i2c-pmcmsp.c
> --- a/drivers/i2c/busses/i2c-pmcmsp.c~i2c-misannotation-in-i2c-pmcmspc
> +++ a/drivers/i2c/busses/i2c-pmcmsp.c
> @@ -486,7 +486,7 @@ static enum pmcmsptwi_xfer_result pmcmsp
>  
>  	if (cmd->type == MSP_TWI_CMD_WRITE ||
>  	    cmd->type == MSP_TWI_CMD_WRITE_READ) {
> -		__be64 tmp = cpu_to_be64p((u64 *)cmd->write_data);
> +		u64 tmp = be64_to_cpup((__be64 *)cmd->write_data);
>  		tmp >>= (MSP_MAX_BYTES_PER_RW - cmd->write_len) * 8;
>  		dev_dbg(&pmcmsptwi_adapter.dev, "Writing 0x%016llx\n", tmp);
>  		pmcmsptwi_writel(tmp & 0x00000000ffffffffLL,

Ben, Marc, any comment on this?

-- 
Jean Delvare
