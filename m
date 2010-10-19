From: Guenter Roeck <guenter.roeck@ericsson.com>
Subject: Re: [PATCH v2] i2c/mux: Driver for PCA9541 I2C Master Selector
Date: Tue, 19 Oct 2010 13:50:53 -0700
Message-ID: <1287521453.9690.299.camel@groeck-laptop>
References: <1286932516-20689-1-git-send-email-guenter.roeck@ericsson.com>
	 <20101019190647.314302e7@endymion.delvare>
Reply-To: guenter.roeck@ericsson.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101019190647.314302e7@endymion.delvare>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Ben Dooks <ben-linux@fluff.org>, Rodolfo Giometti <giometti@linux.it>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

On Tue, 2010-10-19 at 13:06 -0400, Jean Delvare wrote:
[ ... ]
> > +
> > +/*
> > + * I2C init/probing/exit functions
> > + */
> > +static int __devinit pca9541_probe(struct i2c_client *client,
> > +                                const struct i2c_device_id *id)
> 
> The use of __devinit and __devexit isn't recommended for i2c drivers.
> If your driver is built into the kernel but the underlying i2c bus
> driver is build as a module, you're in trouble.
> 
I don't mind changing this, but ... the code is copied from pca954x.c,
which also uses __devinit and __devexit for the same functions. Wouldn't
that be a problem there as well ? Or am I missing something ?

Thanks,
Guenter

 
