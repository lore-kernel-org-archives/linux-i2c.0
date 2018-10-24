From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v9 6/9] i3c: master: Add driver for Cadence IP
Date: Wed, 24 Oct 2018 15:25:17 -0500
Message-ID: <99a506e3-d9d5-0d3e-26e1-031447c14857@ti.com>
References: <20181022133404.2061-1-boris.brezillon@bootlin.com>
 <20181022133404.2061-7-boris.brezillon@bootlin.com>
 <20181024202048.7e3534f7@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181024202048.7e3534f7@bbrezillon>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vitor Soares <Vitor.Soares@synopsys.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Li
List-Id: linux-i2c@vger.kernel.org



On 10/24/18 1:20 PM, Boris Brezillon wrote:
> Hi Arnd,
> 
> On Mon, 22 Oct 2018 15:34:01 +0200
> Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> 
> 
>> +
>> +static void cdns_i3c_master_rd_from_rx_fifo(struct cdns_i3c_master *master,
>> +					    u8 *bytes, int nbytes)
>> +{
>> +	readsl(master->regs + RX_FIFO, bytes, nbytes / 4);
> 
> Vitor reported a problem with readsl(): this function expects the 2nd
> argument to be aligned on 32-bit, which is not guaranteed here. Unless
> you see a better solution, I'll switch back to a loop doing:
> 
> 	for (i = 0; i < nbytes; i += 4) {
> 		u32 tmp = __raw_readl(...);

Pls, do not use __raw io.

> 		memcpy(bytes + i, &tmp,
> 		       nbytes - i  > 4 ? 4 : nbytes - i);
> 	}
> 
>> +	if (nbytes & 3) {
>> +		u32 tmp;
>> +
>> +		readsl(master->regs + RX_FIFO, &tmp, 1);
>> +		memcpy(bytes + (nbytes & ~3), &tmp, nbytes & 3);
>> +	}
>> +}
> 
> Regards,
> 
> Boris
> 

-- 
regards,
-grygorii
