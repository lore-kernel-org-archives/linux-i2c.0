From: vitor <Vitor.Soares@synopsys.com>
Subject: Re: [PATCH v5 01/10] i3c: Add core I3C infrastructure
Date: Thu, 28 Jun 2018 16:38:56 +0100
Message-ID: <088dc947-da66-cec9-44a8-0f1097690bfd@synopsys.com>
References: <20180622104930.32050-1-boris.brezillon@bootlin.com>
 <20180622104930.32050-2-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180622104930.32050-2-boris.brezillon@bootlin.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vitor Soares <Vitor.Soares@synopsys.com>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-i2c@vger.kernel.org

Hi Boris,


On 22-06-2018 11:49, Boris Brezillon wrote:
> +static int of_i3c_master_add_i3c_dev(struct i3c_master_controller *master,
> +				     struct device_node *node, u32 *reg)
> +{
> +	struct i3c_device_info info = { };
> +	enum i3c_addr_slot_status addrstatus;
> +	struct i3c_device *i3cdev;
> +	u32 init_dyn_addr = 0;
> +
> +	if (reg[0]) {
> +		if (reg[0] > I3C_MAX_ADDR)
> +			return -EINVAL;
> +
> +		addrstatus = i3c_bus_get_addr_slot_status(master->bus, reg[0]);
> +		if (addrstatus != I3C_ADDR_SLOT_FREE)
> +			return -EINVAL;
> +	}
> +
> +	info.static_addr = reg[0];
> +
> +	if (!of_property_read_u32(node, "assigned-address", &init_dyn_addr)) {
> +		if (init_dyn_addr > I3C_MAX_ADDR)
> +			return -EINVAL;
> +
> +		addrstatus = i3c_bus_get_addr_slot_status(master->bus,
> +							  init_dyn_addr);
> +		if (addrstatus != I3C_ADDR_SLOT_FREE)
> +			return -EINVAL;
> +	}
> +
> +	info.pid = ((u64)reg[1] << 32) | reg[2];
> +
> +	if ((info.pid & GENMASK_ULL(63, 48)) ||
> +	    I3C_PID_RND_LOWER_32BITS(info.pid))
> +		return -EINVAL;
> +
> +	i3cdev = i3c_master_alloc_i3c_dev(master, &info, &i3c_device_type);
> +	if (IS_ERR(i3cdev))
> +		return PTR_ERR(i3cdev);
> +
> +	i3cdev->init_dyn_addr = init_dyn_addr;
> +	i3cdev->dev.of_node = node;
> +	list_add_tail(&i3cdev->common.node, &master->bus->devs.i3c);
> +
> +	return 0;
> +}
> +

I'm writing the driver for the Synopsys master and but now I getting an 
issue.

I use the "slot" of the device to do all transfers, something like you 
use in DAA. I using the master_priv to save the "slot" per device but 
the problem is when I call the i3c_master_add_i3c_dev_locked() to 
retrieve the info I don't have it yet.

 From my analysis this can be solve with:
     - send PID, BCR and DCR when I call i3c_master_add_i3c_dev_locked() 
or similar function.
     - Pre-allocate an i3c_device -> attach it (slot data goes to 
master_priv) -> retrieve info -> if there is already an i3c_device with 
same PID destroy the pre-allocated one.
     - Replace the info.dyn_address with a structure with dyn_address 
and slot and use it in CCC structure.

This is something that will need to be supported for I3C HCI spec too. 
Do you have any suggestion?

Best regards,
Vitor Soares
