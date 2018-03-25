From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v3 01/11] i2c: Export of_i2c_get_board_info()
Date: Sun, 25 Mar 2018 12:19:32 +0200
Message-ID: <20180325121932.6b0e5e5f@bbrezillon>
References: <20180323110020.19080-1-boris.brezillon@bootlin.com>
        <20180323110020.19080-2-boris.brezillon@bootlin.com>
        <20180324223518.g5jsi5zvoxa75psy@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180324223518.g5jsi5zvoxa75psy@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Sat, 24 Mar 2018 23:35:18 +0100
Wolfram Sang <wsa@the-dreams.de> wrote:

> Hi Boris,
> 
> > - rebase on v4.15-rc1  
> 
> This code has changed a little meanwhile. Please check my for-next
> branch. Some changes are identical, some similar.

Actually it was rebased on top of v4.16-rc1, but I'll check if this
patch applies correctly on top of your for-next branch.

> 
> > -	info.archdata = &dev_ad;  
> 
> Why did you drop this?

Well, this line could have been moved in of_i2c_register_device(), but
I realized dev_ad was zero initialized without any further
modification, and leaving info->archdata to NULL has the exact same
effect (see [1]).

Regards,

Boris

[1]https://elixir.bootlin.com/linux/v4.16-rc6/source/drivers/i2c/i2c-core-base.c#L711

-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
