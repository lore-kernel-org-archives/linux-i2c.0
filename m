From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v9 1/4] mfd: add support for Diolan DLN-2 devices
Date: Mon, 27 Oct 2014 09:57:49 -0700
Message-ID: <1414429069.8884.10.camel@perches.com>
References: <1414427472-4100-1-git-send-email-octavian.purdila@intel.com>
	 <1414427472-4100-2-git-send-email-octavian.purdila@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1414427472-4100-2-git-send-email-octavian.purdila@intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Octavian Purdila <octavian.purdila@intel.com>
Cc: gregkh@linuxfoundation.org, linus.walleij@linaro.org, gnurou@gmail.com, wsa@the-dreams.de, sameo@linux.intel.com, lee.jones@linaro.org, arnd@arndb.de, johan@kernel.org, daniel.baluta@intel.com, laurentiu.palcu@intel.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 2014-10-27 at 18:31 +0200, Octavian Purdila wrote:
> This patch implements the USB part of the Diolan USB-I2C/SPI/GPIO
> Master Adapter DLN-2. Details about the device can be found here:

trivia:

> diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
[]
> +static int _dln2_transfer(struct dln2_dev *dln2, u16 handle, u16 cmd,
> +			  const void *obuf, unsigned obuf_len,
> +			  void *ibuf, unsigned *ibuf_len)
> +{
> +	int ret = 0;
> +	int rx_slot;
> +	struct dln2_response *rsp;
> +	struct dln2_rx_context *rxc;
> +	struct device *dev = &dln2->interface->dev;
> +	const int timeout = DLN2_USB_TIMEOUT * HZ / 1000;

unsigned long timeout?

[]

> +	ret = wait_for_completion_interruptible_timeout(&rxc->done, timeout);
> +	if (ret <= 0) {
> +		if (!ret)
> +			ret = -ETIMEDOUT;
> +		goto out_free_rx_slot;
> +	}

[]

> +static int dln2_print_serialno(struct dln2_dev *dln2)
> +{
> +	int ret;
> +	__le32 serial_no;
> +	int len = sizeof(serial_no);
> +	struct device *dev = &dln2->interface->dev;
> +
> +	ret = _dln2_transfer(dln2, DLN2_HANDLE_CTRL, CMD_GET_DEVICE_SN, NULL, 0,
> +			     &serial_no, &len);
> +	if (ret < 0)
> +		return ret;
> +	if (len < sizeof(serial_no))
> +		return -EREMOTEIO;
> +
> +	dev_info(dev, "Diolan DLN2 serial 0x%x\n", le32_to_cpu(serial_no));

why a hex serial #?


