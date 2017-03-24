From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] i2c: mux: pca954x: Add missing pca9546 definition to
 chip_desc
Date: Fri, 24 Mar 2017 12:21:58 +0100
Message-ID: <6ad1df75-ceef-9b94-6c66-e6ba569221b4@axentia.se>
References: <1490259636-16859-1-git-send-email-mike.looijmans@topic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1490259636-16859-1-git-send-email-mike.looijmans@topic.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Looijmans <mike.looijmans@topic.nl>, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, wsa@the-dreams.de
List-Id: linux-i2c@vger.kernel.org

On 2017-03-23 10:00, Mike Looijmans wrote:
> The spec for the pca9546 was missing. This chip is the same as the pca9545
> except that it lacks interrupt lines. While the i2c_device_id table mapped
> the pca9546 to the pca9545 definition the compatible table did not.

Ouch, good catch, I have committed this to my i2c-mux for-current branch.

Cheers,
peda

> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
>  drivers/i2c/muxes/i2c-mux-pca954x.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
> index dfc1c0e..69c2f5a 100644
> --- a/drivers/i2c/muxes/i2c-mux-pca954x.c
> +++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
> @@ -117,6 +117,10 @@ struct pca954x {
>  		.has_irq = 1,
>  		.muxtype = pca954x_isswi,
>  	},
> +	[pca_9546] = {
> +		.nchans = 4,
> +		.muxtype = pca954x_isswi,
> +	},
>  	[pca_9547] = {
>  		.nchans = 8,
>  		.enable = 0x8,
> @@ -134,7 +138,7 @@ struct pca954x {
>  	{ "pca9543", pca_9543 },
>  	{ "pca9544", pca_9544 },
>  	{ "pca9545", pca_9545 },
> -	{ "pca9546", pca_9545 },
> +	{ "pca9546", pca_9546 },
>  	{ "pca9547", pca_9547 },
>  	{ "pca9548", pca_9548 },
>  	{ }
> 
