From: Federico Vaga <federico.vaga@cern.ch>
Subject: Re: [PATCH v4 1/5] i2c:ocores: stop transfer on timeout
Date: Mon, 11 Feb 2019 14:02:12 +0100
Message-ID: <7790979.IuqCBRmgNN@pcbe13614>
References: <20190211083122.32485-1-federico.vaga@cern.ch> <20190211083122.32485-2-federico.vaga@cern.ch> <d406a2ea-9d37-3eca-d975-818a22ca2458@axentia.se>
Reply-To: <federico.vaga@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d406a2ea-9d37-3eca-d975-818a22ca2458@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Monday, February 11, 2019 11:44:46 AM CET Peter Rosin wrote:
> On 2019-02-11 09:31, Federico Vaga wrote:
> 
> > Detecting a timeout is ok, but we also need to assert a STOP command on
> > the bus in order to prevent it from generating interrupts when there are
> > no on going transfers.
> > 
> > Example: very long transmission.
> > 
> > 1. ocores_xfer: START a transfer
> > 2. ocores_isr : handle byte by byte the transfer
> > 3. ocores_xfer: goes in timeout [[bugfix here]]
> > 4. ocores_xfer: return to I2C subsystem and to the I2C driver
> > 5. I2C driver : it may clean up the i2c_msg memory
> > 6. ocores_isr : receives another interrupt (pending bytes to be
> > 
> >                 transferred) but the i2c_msg memory is invalid now
> > 
> > 
> > So, since the transfer was too long, we have to detect the timeout and
> > STOP the transfer.
> > 
> > Another point is that we have a critical region here. When handling the
> > timeout condition we may have a running IRQ handler. For this reason I
> > introduce a spinlock.
> > 
> > In order to make easier to understan locking I have:
> > - added a new function to handle timeout
> > - modified the current ocores_process() function in order to be protected
> > 
> >   by the new spinlock
> > 
> > Like this it is obvious at first sight that this locking serializes
> > the execution of ocores_process() and ocores_process_timeout()
> > 
> 
> 
> *snip*
> 
> 
> > @@ -184,14 +197,14 @@ static void ocores_process(struct ocores_i2c *i2c)
> > 
> >  
> >  
> >  				oc_setreg(i2c, OCI2C_DATA, addr);
> >  				oc_setreg(i2c, OCI2C_CMD,  OCI2C_CMD_START);
> 
> 
> Didn't checkpatch complain about the double space? Fixing it fits in
> patch 5...

Apparently not, I will add the fix the checkpatch PATCH

> Cheers,
> Peter
