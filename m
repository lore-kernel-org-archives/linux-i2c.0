From: "Sudhakar Rajashekhara" <sudhakar.raj-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 1/6] i2c: davinci: Fix smbus Oops with AIC33 usage
Date: Wed, 27 Jan 2010 18:54:45 +0530
Message-ID: <11563.4708818563$1264598932@news.gmane.org>
References: <1264549293-25556-1-git-send-email-khilman@deeprootsystems.com>
	<1264549293-25556-2-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1264549293-25556-2-git-send-email-khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Content-Language: en-us
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: 'Kevin Hilman' <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, 'Ben Dooks' <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Dirk Behme' <dirk.behme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, 'Alexander Vasiliev' <alexvasiljev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

On Wed, Jan 27, 2010 at 05:11:28, Kevin Hilman wrote:
> From: Dirk Behme <dirk.behme-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
> 
> This fixes Oops at kernel startup while "scanning" for TLV320AIC23IDx
> addresses.
> 
> Signed-off-by: Alexander Vasiliev <alexvasiljev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Brad Griffis <bgriffis-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Dirk Behme <dirk.behme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Acked-by: Kevin Hilman <khilman-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-davinci.c |   29 +++++++++++++++++++++++++----
>  1 files changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
> index c89687a..444a9f2 100644
> --- a/drivers/i2c/busses/i2c-davinci.c
> +++ b/drivers/i2c/busses/i2c-davinci.c

[...]

> @@ -290,6 +293,16 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
>  	davinci_i2c_write_reg(dev, DAVINCI_I2C_IMR_REG, w);
>  
>  	dev->terminate = 0;
> +
> +	/* First byte should be set here, not after interrupt,
> +	 * because transmit-data-ready interrupt can come before
> +	 * NACK-interrupt during sending of previous message and
> +	 * ICDXR may have wrong data */
> +	if ((!(msg->flags & I2C_M_RD)) && dev->buf_len) {
> +		davinci_i2c_write_reg(dev, DAVINCI_I2C_DXR_REG, *dev->buf++);
> +		dev->buf_len--;
> +	}
> +

I found an issue on DA850 while using this patch. I think the above code should come after the
below lines because an I2C transaction is being carried out before configuring the I2C mode
register (which has bits to configure Master, Start condition etc), which causes undefined
behavior.


>  	/* write the data into mode register */
>  	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
>  

Regards,
Sudhakar
