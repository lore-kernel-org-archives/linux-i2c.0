From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3] i2c: enable runtime PM for I2C adapter devices
 enumerated from ACPI
Date: Tue, 1 Oct 2013 12:52:09 +0300
Message-ID: <20131001095209.GX28875@intel.com>
References: <1380552228-23329-1-git-send-email-mika.westerberg@linux.intel.com>
 <1380552228-23329-2-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1380552228-23329-2-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, rjw@rjwysocki.net, Aaron Lu <aaron.lu@intel.com>, Lv Zheng <lv.zheng@intel.com>, Mark Brown <broonie@kernel.org>, Kevin Hilman <khilman@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Sep 30, 2013 at 05:43:48PM +0300, Mika Westerberg wrote:
> +static void acpi_i2c_device_pm_get(struct i2c_client *client)
> +{
> +	struct i2c_adapter *adap = client->adapter;
> +
> +	/* Make sure the adapter is active */
> +	if (ACPI_HANDLE(adap->dev.parent))
> +		pm_runtime_get_sync(&adap->dev);
> +	if (ACPI_HANDLE(&client->dev))
> +		acpi_dev_pm_attach(&client->dev, true);

There's a bug here as we call acpi_dev_pm_attach() several times. It
doesn't do any harm because acpi_dev_pm_attach() checks if the device is
already attached to the ACPI domain or not.

I'll fix this in the next revision as well.

> +}
