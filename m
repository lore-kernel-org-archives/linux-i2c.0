From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 6/7] iio: srf08: add buffered to device mode
Date: Sat, 12 Aug 2017 13:02:08 +0100
Message-ID: <20170812130208.2ed84b76@archlinux>
References: <20170802232609.GA15406@arbeit>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170802232609.GA15406@arbeit>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Klinger <ak@it-klinger.de>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 3 Aug 2017 01:26:09 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> Add INDIO_BUFFER_TRIGGERED and INDIO_BUFFER_SOFTWARE to device mode
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  drivers/iio/proximity/srf08.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
> index a63c272c3b22..ea238ab1066c 100644
> --- a/drivers/iio/proximity/srf08.c
> +++ b/drivers/iio/proximity/srf08.c
> @@ -437,7 +437,9 @@ static int srf08_probe(struct i2c_client *client,
>  
>  	indio_dev->name = id->name;
>  	indio_dev->dev.parent = &client->dev;
> -	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->modes = INDIO_DIRECT_MODE
> +				| INDIO_BUFFER_TRIGGERED
Huh.?  Firstly I think only one of these is relevant and secondly
should be merged back into the original patch that added the support.

Also the triggered_buffer setup already set it for you...

So all in all, drop this patch.

Jonathan
> +				| INDIO_BUFFER_SOFTWARE;
>  
>  	/* srf02 is not using sensitivity nor max_range */
>  	if (id->driver_data == SRF02)
