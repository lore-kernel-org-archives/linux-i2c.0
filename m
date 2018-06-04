From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v4 01/10] i3c: Add core I3C infrastructure
Date: Mon, 4 Jun 2018 13:24:27 +0200
Message-ID: <20180604132427.14193577@bbrezillon>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
        <20180330074751.25987-2-boris.brezillon@bootlin.com>
        <EFF070CA-9C6C-4E9C-9CEF-45AAD02745BB@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <EFF070CA-9C6C-4E9C-9CEF-45AAD02745BB@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Przemyslaw Gaj <pgaj@cadence.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark
List-Id: linux-i2c@vger.kernel.org

On Mon, 4 Jun 2018 09:11:25 +0000
Przemyslaw Gaj <pgaj@cadence.com> wrote:

> Hi Boris
> 
> It looks great, just one comment to DEFSLVS command:
> 
> ﻿On 6/4/18, 9:32 AM, "Boris Brezillon" <boris.brezillon@bootlin.com> wrote:
> 
>     +int i3c_master_defslvs_locked(struct i3c_master_controller *master)
>     +{
>     +	struct i3c_ccc_cmd_dest dest = {
>     +		.addr = I3C_BROADCAST_ADDR,
>     +	};
>     +	struct i3c_ccc_cmd cmd = {
>     +		.id = I3C_CCC_DEFSLVS,
>     +		.dests = &dest,
>     +		.ndests = 1,
>     +	};
>     +	struct i3c_ccc_defslvs *defslvs;
>     +	struct i3c_ccc_dev_desc *desc;
>     +	struct i3c_device *i3cdev;
>     +	struct i2c_device *i2cdev;
>     +	struct i3c_bus *bus;
>     +	bool send = false;
>     +	int ndevs = 0, ret;
>     +
>     +	if (!master)
>     +		return -EINVAL;
>     +
>     +	bus = i3c_master_get_bus(master);
>     +	i3c_bus_for_each_i3cdev(bus, i3cdev) {
>     +		ndevs++;
>     +		if (I3C_BCR_DEVICE_ROLE(i3cdev->info.bcr) == I3C_BCR_I3C_MASTER)
>     +			send = true;
>     +	}
>     +
>     +	/* No other master on the bus, skip DEFSLVS. */
>     +	if (!send)
>     +		return 0;
>     +
>     +	i3c_bus_for_each_i2cdev(bus, i2cdev)
>     +		ndevs++;
>     +
>     +	dest.payload.len = sizeof(*defslvs) +
>     +			   ((ndevs - 1) * sizeof(struct i3c_ccc_dev_desc));
>     +	defslvs = kzalloc(dest.payload.len, GFP_KERNEL);
>     +	if (!defslvs)
>     +		return -ENOMEM;
>     +
>     +	dest.payload.data = defslvs;
>     +
>     +	defslvs->count = ndevs;
>     +	defslvs->master.bcr = master->this->info.bcr;
>     +	defslvs->master.dcr = master->this->info.dcr;
>     +	defslvs->master.dyn_addr = master->this->info.dyn_addr;
>     +	defslvs->master.static_addr = I3C_BROADCAST_ADDR;
>     +
>     +	desc = defslvs->slaves;
>     +	i3c_bus_for_each_i2cdev(bus, i2cdev) {
>     +		desc->lvr = i2cdev->lvr;
>     +		desc->static_addr = i2cdev->info.addr;
>     +		desc++;
>     +	}
>     +
>     +	i3c_bus_for_each_i3cdev(bus, i3cdev) {
>     +		/* Skip the I3C dev representing this master. */
>     +		if (i3cdev == master->this)
>     +			continue;
>     +
>     +		desc->bcr = i3cdev->info.bcr;
>     +		desc->dcr = i3cdev->info.dcr;
>     +		desc->dyn_addr = i3cdev->info.dyn_addr;
>     +		desc->static_addr = i3cdev->info.static_addr;
>     +		desc++;
>     +	}
>     +
>     +	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
>     +	kfree(defslvs);
>     +
>     +	return ret;
>     +}
> 
> You should shift all the addresses (dynamic and static) one bit left. 
> Addresses are stored on bits [7:1], this is described in MIPI spec, 
> section 5.1.9.3.7 Define List of Slaves (DEFSLVS)

Oops, indeed. I will fix that.

Thanks,

Boris
