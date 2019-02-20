From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH v4 3/3] i2c: at91: added slave mode support
Date: Wed, 20 Feb 2019 07:32:14 +0100
Message-ID: <20190220063214.7edblwnh3ih354kp@M43218.corp.atmel.com>
References: <20181227151311.20107-4-ludovic.desroches@microchip.com>
 <201901050345.JaEWLmjh%fengguang.wu@intel.com>
 <20190115224351.rtbqaqro5pl3dvov@ninjato>
 <20190215091847.pkagndsndjzumzwd@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190215091847.pkagndsndjzumzwd@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: kbuild test robot <lkp@intel.com>, alexandre.belloni@bootlin.com, me@jue.yt, linux-kernel@vger.kernel.org, kbuild-all@01.org, andriy.shevchenko@linux.intel.com, Juergen Fitschen <jfi@ssv-embedded.de>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On Fri, Feb 15, 2019 at 10:18:47AM +0100, Wolfram Sang wrote:
> On Tue, Jan 15, 2019 at 11:43:51PM +0100, Wolfram Sang wrote:
> > 
> > > All errors (new ones prefixed by >>):
> > > 
> > > >> ERROR: "at91_init_twi_bus_slave" [drivers/i2c/busses/i2c-at91.ko] undefined!
> > > >> ERROR: "at91_twi_probe_slave" [drivers/i2c/busses/i2c-at91.ko] undefined!
> > 
> > That needs to be fixed. Rest looks good to me!
> 
> Ludovic, do you have time to fix it? I would really like to apply this
> series for the next merge window.
> 

Sorry it's in my todo list but I didn't have time to handle it. I'll try
to fix it beginning of next week.

Regards

Ludovic



> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
