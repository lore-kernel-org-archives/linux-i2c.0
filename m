From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v4 07/10] i3c: master: Add driver for Cadence IP
Date: Mon, 4 Jun 2018 13:26:15 +0200
Message-ID: <20180604132615.415db91a@bbrezillon>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
        <20180330074751.25987-8-boris.brezillon@bootlin.com>
        <9613475C-ECAE-4AD6-9C02-55C9214A6489@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9613475C-ECAE-4AD6-9C02-55C9214A6489@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Przemyslaw Gaj <pgaj@cadence.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark
List-Id: linux-i2c@vger.kernel.org

Hi Przemek,

On Mon, 4 Jun 2018 09:24:51 +0000
Przemyslaw Gaj <pgaj@cadence.com> wrote:

> Hi Boris,
> 
> Few things regarding Cadence IP driver:
> 
> ﻿On 6/4/18, 9:31 AM, "Boris Brezillon" <boris.brezillon@bootlin.com> wrote:
> 
>     +static void cdns_i3c_master_handle_ibi(struct cdns_i3c_master *master,
>     +				       u32 ibir)
>     +{
>     +	struct cdns_i3c_i2c_dev_data *data;
>     +	bool data_consumed = false;
>     +	struct i3c_ibi_slot *slot;
>     +	u32 id = IBIR_SLVID(ibir);
>     +	struct i3c_device *dev;
>     +	int len, i, j;
>     +	u8 *buf;
>     +
>     +	/*
>     +	 * FIXME: maybe we should report the FIFO OVF errors to the upper
>     +	 * layer.
>     +	 */
>     +	if (id >= master->ibi.num_slots || (ibir & IBIR_ERROR))
>     +		goto out;
>     +
>     +	dev = master->ibi.slots[id];
>     +	spin_lock(&master->ibi.lock);
>     +
>     +	data = i3c_device_get_master_data(dev);
>     +	slot = i3c_generic_ibi_get_free_slot(data->ibi_pool);
>     +	if (!slot)
>     +		goto out_unlock;
>     +
>     +	buf = slot->data;
>     +
>     +	len = IBIR_XFER_BYTES(ibir);
>     +	for (i = 0; i < IBIR_XFER_BYTES(ibir); i += 4) {
>     +		u32 tmp = readl(master->regs + IBI_DATA_FIFO);
>     +
>     +		for (j = 0; j < 4 && i + j < dev->ibi->max_payload_len; j++)
>     +			buf[i + j] = tmp >> (j * 8);
>     +
>     +	}
>     +	slot->len = min_t(unsigned int, IBIR_XFER_BYTES(ibir),
>     +			  dev->ibi->max_payload_len);
>     +	i3c_master_queue_ibi(dev, slot);
>     +	data_consumed = true;
>     +
>     +out_unlock:
>     +	spin_unlock(&master->ibi.lock);
>     +
>     +out:
>     +	/* Consume data from the FIFO if it's not been done already. */
>     +	if (!data_consumed) {
>     +		for (i = 0; i < IBIR_XFER_BYTES(ibir); i += 4)
>     +			readl(master->regs + IBI_DATA_FIFO);
>     +	}
>     +}
>     
> len variable is unneeded.

Will get rid of len.

>     +
>     +	/* Device ID0 is reserved to describe this master. */
>     +	master->maxdevs = CONF_STATUS0_DEVS_NUM(val);
>     +	master->free_rr_slots = GENMASK(master->maxdevs, 1);
>     +
>     +	val = readl(master->regs + CONF_STATUS1);
>     +	master->caps.cmdfifodepth = CONF_STATUS1_CMD_DEPTH(val);
>     +	master->caps.rxfifodepth = CONF_STATUS1_RX_DEPTH(val);
>     +	master->caps.txfifodepth = CONF_STATUS1_TX_DEPTH(val);
>     +	master->caps.ibirfifodepth = 16;
> 
> IBI fifo depth is hardcoded. You can read this value from CONF_STATUS0 register.
> 
>     +	master->caps.cmdrfifodepth = 16;
> 
> CMDR fifo depth is hardcoded. You can read this value from CONF_STATUS0 register also.

Sure, I'll use the FIFO depth exposed in CONF_STATUS0.

Thanks,

Boris
