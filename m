From: vitor <Vitor.Soares@synopsys.com>
Subject: Re: [PATCH v7 01/10] i3c: Add core I3C infrastructure
Date: Tue, 11 Sep 2018 11:04:07 +0100
Message-ID: <aa29faa0-237c-3875-64da-b93a1e87ccff@synopsys.com>
References: <20180905154108.20770-1-boris.brezillon@bootlin.com>
 <20180905154108.20770-2-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905154108.20770-2-boris.brezillon@bootlin.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vitor Soares <Vitor.Soares>
List-Id: linux-i2c@vger.kernel.org


Hi Boris,

On 05-09-2018 16:40, Boris Brezillon wrote:
> +i3c_master_register_new_i3c_devs(struct i3c_master_controller *master)
> +{
> +	struct i3c_dev_desc *desc;
> +	int ret;
> +
> +	if (!master->init_done)
> +		return;
> +
If you have a hot-join and call i3c_master_do_daa this function will 
return without create the i3c_device.

> +	i3c_bus_for_each_i3cdev(master->bus, desc) {
> +		if (desc->dev || !desc->info.dyn_addr || desc == master->this)
> +			continue;
> +
> +		desc->dev = kzalloc(sizeof(*desc->dev), GFP_KERNEL);
> +		if (!desc->dev)
> +			continue;
> +
> +		desc->dev->bus = master->bus;
> +		desc->dev->desc = desc;
> +		desc->dev->dev.parent = &master->bus->dev;
> +		desc->dev->dev.type = &i3c_device_type;
> +		desc->dev->dev.bus = &i3c_bus_type;
> +		desc->dev->dev.release = i3c_device_release;
> +		dev_set_name(&desc->dev->dev, "%d-%llx", master->bus->id,
> +			     desc->info.pid);
> +
> +		if (desc->boardinfo)
> +			desc->dev->dev.of_node = desc->boardinfo->of_node;
> +
> +		ret = device_register(&desc->dev->dev);
> +		if (ret)
> +			dev_err(master->parent,
> +				"Failed to add I3C device (err = %d)\n", ret);
> +	}
> +}
>

Best regards,
Vitor Soares
