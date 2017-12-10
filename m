From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph@boehmwalder.at>
Subject: Re: [PATCH v3 1/2] eeprom: at24: fix coding style issues
Date: Sun, 10 Dec 2017 02:31:40 +0100
Message-ID: <20171210013140.62bwezb2pnovf2x6@christoph-lap>
References: <20171207133915.29448-1-brgl@bgdev.pl>
 <20171207133915.29448-2-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171207133915.29448-2-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Dec 07, 2017 at 02:39:14PM +0100, Bartosz Golaszewski wrote:
> -#define AT24_DEVICE_MAGIC(_len, _flags) 		\
> -	((1 << AT24_SIZE_FLAGS | (_flags)) 		\
> +#define AT24_DEVICE_MAGIC(_len, _flags)			\
> +	((1 << AT24_SIZE_FLAGS | (_flags))		\
>  	    << AT24_SIZE_BYTELEN | ilog2(_len))

Looks like there's been a whitespace accident on that first added line.
(Backslash has one more tab in front of it than it should have)

--
Regards,
Christoph
