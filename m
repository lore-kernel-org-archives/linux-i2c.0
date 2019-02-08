From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v3 1/5] i2c:ocores: stop transfer on timeout
Date: Fri, 8 Feb 2019 17:58:43 +0100
Message-ID: <20190208165843.GA1853@lunn.ch>
References: <20190208161201.7860-1-federico.vaga@cern.ch>
 <20190208161201.7860-2-federico.vaga@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190208161201.7860-2-federico.vaga@cern.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Federico Vaga <federico.vaga@cern.ch>
Cc: Peter Korsgaard <peter@korsgaard.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Feb 08, 2019 at 05:11:57PM +0100, Federico Vaga wrote:
> Detecting a timeout is ok, but we also need to assert a STOP command on
> the bus in order to prevent it from generating interrupts when there are
> no on going transfers.
> 
> Example: very long transmission.
> 
> 1. ocores_xfer: START a transfer
> 2. ocores_isr : handle byte by byte the transfer
> 3. ocores_xfer: goes in timeout [[bugfix here]]
> 4. ocores_xfer: return to I2C subsystem and to the I2C driver
> 5. I2C driver : it may clean up the i2c_msg memory
> 6. ocores_isr : receives another interrupt (pending bytes to be
>                 transferred) but the i2c_msg memory is invalid now
> 
> So, since the transfer was too long, we have to detect the timeout and
> STOP the transfer.
> 
> Another point is that we have a critical region here. When handling the
> timeout condition we may have a running IRQ handler. For this reason I
> introduce a spinlock.
> 
> In order to make easier to understan locking I have:
> - added a new function to handle timeout
> - modified the current ocores_process() function in order to be protected
>   by the new spinlock
> Like this it is obvious at first sight that this locking serializes
> the execution of ocores_process() and ocores_process_timeout()
> 
> Signed-off-by: Federico Vaga <federico.vaga@cern.ch>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
