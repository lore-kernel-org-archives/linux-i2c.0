From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 2/4] i2c: add support for Diolan DLN-2 USB-I2C adapter
Date: Tue, 7 Oct 2014 18:46:36 +0200
Message-ID: <20141007164636.GG5362@localhost>
References: <1411661254-5204-1-git-send-email-octavian.purdila@intel.com>
 <1411661254-5204-3-git-send-email-octavian.purdila@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1411661254-5204-3-git-send-email-octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Sep 25, 2014 at 07:07:32PM +0300, Octavian Purdila wrote:
> From: Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> This patch adds support for the Diolan DLN-2 I2C master module. Due
> to hardware limitations it does not support SMBUS quick commands.
> 
> Information about the USB protocol interface can be found in the
> Programmer's Reference Manual [1], see section 6.2.2 for the I2C
> master module commands and responses.
> 
> [1] https://www.diolan.com/downloads/dln-api-manual.pdf
> 
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---

[...]

> +#define DLN2_I2C_MAX_XFER_SIZE		256
> +#define DLN2_I2C_BUF_SIZE		(DLN2_I2C_MAX_XFER_SIZE + 16)
> +
> +struct dln2_i2c {
> +	struct platform_device *pdev;
> +	struct i2c_adapter adapter;
> +	u32 freq;
> +	u32 min_freq;
> +	u32 max_freq;
> +	u8 port;
> +	/*
> +	 * Buffer to hold the packet for read or write transfers. One
> +	 * is enough since we can't have multiple transfers in
> +	 * parallel on the i2c adapter.
> +	 */
> +	void *buf;
> +};
> +
> +static int dln2_i2c_enable(struct dln2_i2c *dln2, bool enable)
> +{
> +	int ret;
> +	u16 cmd;
> +
> +	if (enable)
> +		cmd = DLN2_I2C_ENABLE;
> +	else
> +		cmd = DLN2_I2C_DISABLE;
> +
> +	ret = dln2_transfer(dln2->pdev, cmd, &dln2->port, sizeof(dln2->port),
> +			    NULL, NULL);

Don't use the port member of dln2 directly here. Encode the protocol in
the function as you already do for most other messages (and did in
previous versions). You could even declare a
	
	struct {
		u8 port;
	} tx;

for consistency.

> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int dln2_i2c_set_frequency(struct dln2_i2c *dln2, u32 freq)
> +{
> +	int ret;
> +	struct tx_data {
> +		u8 port;
> +		__le32 freq;
> +	} __packed tx;
> +
> +	tx.port = dln2->port;
> +	tx.freq = cpu_to_le32(freq);
> +
> +	ret = dln2_transfer(dln2->pdev, DLN2_I2C_SET_FREQUENCY, &tx, sizeof(tx),
> +			    NULL, NULL);
> +	if (ret < 0)
> +		return ret;
> +
> +	dln2->freq = freq;
> +
> +	return 0;
> +}
> +
> +static int dln2_i2c_get_freq(struct dln2_i2c *dln2, u16 cmd, u32 *res)
> +{
> +	int ret;
> +	__le32 freq;
> +	unsigned len = sizeof(freq);
> +
> +	ret = dln2_transfer(dln2->pdev, cmd, &dln2->port, sizeof(dln2->port),
> +			    &freq, &len);

Same here.

> +	if (ret < 0)
> +		return ret;
> +	if (len < sizeof(freq))
> +		return -EPROTO;
> +
> +	*res = le32_to_cpu(freq);
> +
> +	return 0;
> +}
> +

[...]

> +static ssize_t dln2_i2c_freq_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct dln2_i2c *dln2 = dev_get_drvdata(dev);
> +
> +	return snprintf(buf, PAGE_SIZE, "%d\n", dln2->freq);
> +}
> +
> +static ssize_t dln2_i2c_freq_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t count)
> +{
> +	struct dln2_i2c *dln2 = dev_get_drvdata(dev);
> +	unsigned long freq;
> +	int ret;
> +
> +	if (kstrtoul(buf, 0, &freq) || freq < dln2->min_freq ||
> +	    freq > dln2->max_freq)
> +		return -EINVAL;
> +
> +	ret = dln2_i2c_enable(dln2, false);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = dln2_i2c_set_frequency(dln2, freq);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = dln2_i2c_enable(dln2, true);
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(dln2_i2c_freq);

You forgot to add the required documentation of the attribute to
Documentation/ABI as requested.

Johan
