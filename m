From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] i2c: allow building emev2 without slave mode again
Date: Sat, 12 Dec 2015 22:05:29 +0100
Message-ID: <2157023.1Ftpc9ZciN@wuerfel>
References: <201512102224.cVm7Hcp0%fengguang.wu@intel.com>
 <2592093.cGKEcKVqLU@wuerfel> <20151212162057.GA1530@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151212162057.GA1530@katana>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Niklas =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>, kbuild test robot <lkp@intel.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kbuild-all@01.org
List-Id: linux-i2c@vger.kernel.org

On Saturday 12 December 2015 17:20:57 Wolfram Sang wrote:
> Hi Arnd,
> 
> thanks for looking into this, but I don't get your point yet.
> 
> > The slave_cb callback function is supposed to set the 'value'
> > here,
> 
> Only if a master wants to READ from us.

Right, and can this never fail?

> > but it might return an error not assign the pointer,
> 
> An error is only returned if a WRITE from a master was not accepted by
> the slave backend.
>
> > It might be best to change the callback to return 'void' and not
> > allow it to fail.
> 
> We need that because in case of an errno, the slave should send NACK to
> the master instead of ACK.
> 
> > At least the eeprom slave cannot fail anyway, and it is the only
> > implementation we have at the moment.
> 
> True. But giving a slave the possibility to NACK a write should be
> present IMO.

Ok, fair enough.
 
> > Alternatively, the  inline could return an error, and both bus
> > drivers check for the error before using 'value'.
> 
> Hum, it does return an error?
> 
> 	return client->slave_cb(client, event, val);
> 
> You probably mean something else?

I mean specifically this code in em_i2c_slave_irq():

                        /* Send data */
                        event = status & I2C_BIT_STD0 ?
                                I2C_SLAVE_READ_REQUESTED :
                                I2C_SLAVE_READ_PROCESSED;
                        i2c_slave_event(priv->slave, event, &value);
                        writeb(value, priv->base + I2C_OFS_IIC0);

With my current code to turn i2c_slave_event() into an empty inline function
in case of !CONFIG_I2C_SLAVE, the compiler knows that "value" is uninitialized
at the point where we write it to the register, and warns about it.

The code will of course never run if slave mode is not allowed, but we should
still shut up the warning, either by making the inline i2c_slave_event
set 'value' to zero or 0xff, or by adding an error check:

			ret = i2c_slave_event(priv->slave, event, &value);
			if (!ret)
				 writeb(value, priv->base + I2C_OFS_IIC0);

and making the empty i2c_slave_event() function return -ENOSYS or -ENOTSUPP.


	Arnd
