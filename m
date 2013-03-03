From: "Peter Korsgaard" <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c-mux-gpio: Check gpio_direction_output return value
Date: Sun, 03 Mar 2013 20:37:29 +0100
Message-ID: <87ehfw46me.fsf@thor.barco.com>
References: <20130303195815.10ba20b1@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Class: urn:content-classes:message
In-Reply-To: <20130303195815.10ba20b1-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org> (Jean Delvare'smessage of "Sun, 3 Mar 2013 19:58:15 +0100")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

>>>>> "JD" == Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> writes:

JD> gpio_direction_output() may fail, check for that and deal with it
JD> appropriately. Also log an error message if gpio_request() fails.

JD> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
JD> Cc: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
JD> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
JD> ---
JD>  drivers/i2c/muxes/i2c-mux-gpio.c |   17 ++++++++++++++---
JD>  1 file changed, 14 insertions(+), 3 deletions(-)

JD> --- linux-3.7.orig/drivers/i2c/muxes/i2c-mux-gpio.c	2012-12-15 14:52:47.368991730 +0100
JD> +++ linux-3.7/drivers/i2c/muxes/i2c-mux-gpio.c	2013-03-03 14:27:21.003905620 +0100
JD> @@ -123,10 +123,21 @@ static int __devinit i2c_mux_gpio_probe(
 
JD>  	for (i = 0; i < pdata->n_gpios; i++) {
JD>  		ret = gpio_request(gpio_base + pdata->gpios[i], "i2c-mux-gpio");
JD> -		if (ret)
JD> +		if (ret) {
JD> +			dev_err(&pdev->dev, "Failed to request GPIO %d\n",
JD> +				pdata->gpios[i]);
JD>  			goto err_request_gpio;
JD> -		gpio_direction_output(gpio_base + pdata->gpios[i],
JD> -				      initial_state & (1 << i));
JD> +		}
JD> +
JD> +		ret = gpio_direction_output(gpio_base + pdata->gpios[i],
JD> +					    initial_state & (1 << i));
JD> +		if (ret) {
JD> +			dev_err(&pdev->dev,
JD> +				"Failed to set direction of GPIO %d to output\n",
JD> +				pdata->gpios[i]);
JD> +			i++;
JD> +			goto err_request_gpio;

The i++ is a bit nonobvious, so a comment would be good. Other than that
it looks fine.

Acked-by: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>

-- 
Sorry about disclaimer - It's out of my control.
Bye, Peter Korsgaard


DISCLAIMER:
Unless indicated otherwise, the information contained in this message is privileged and confidential, and is intended only for the use of the addressee(s) named above and others who have been specifically authorized to receive it. If you are not the intended recipient, you are hereby notified that any dissemination, distribution or copying of this message and/or attachments is strictly prohibited. The company accepts no liability for any damage caused by any virus transmitted by this email. Furthermore, the company does not warrant a proper and complete transmission of this information, nor does it accept liability for any delays. If you have received this message in error, please contact the sender and delete the message. Thank you.
