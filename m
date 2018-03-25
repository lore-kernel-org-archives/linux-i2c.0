From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v3 01/11] i2c: Export of_i2c_get_board_info()
Date: Sun, 25 Mar 2018 12:21:09 +0200
Message-ID: <20180325122109.31c8e904@bbrezillon>
References: <20180323110020.19080-1-boris.brezillon@bootlin.com>
        <20180323110020.19080-2-boris.brezillon@bootlin.com>
        <20180324223518.g5jsi5zvoxa75psy@ninjato>
        <20180324223832.7wvhghw77ech4orn@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180324223832.7wvhghw77ech4orn@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar
List-Id: linux-i2c@vger.kernel.org

On Sat, 24 Mar 2018 23:38:32 +0100
Wolfram Sang <wsa@the-dreams.de> wrote:

> > > -	info.archdata = &dev_ad;  
> > 
> > Why did you drop this?  
> 
> If the removal is safe, it should be a seperate patch, I mean.
> 

Sure, I'll move that in a separate patch. Actually, I had a closer look
and it seems the only user of info->archdata is i2c-core-of.c, so we
can even remove the info->archdata field.

-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
