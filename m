From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] Alchemy: SMBus resource fix
Date: Tue, 8 Apr 2008 12:05:47 +0100
Message-ID: <20080408110547.GA424@linux-mips.org>
References: <200804052216.21699.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <200804052216.21699.sshtylyov@ru.mvista.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-mips@linux-mips.org, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Apr 05, 2008 at 10:16:21PM +0400, Sergei Shtylyov wrote:

> The Alchemy platform code registers the SMBus device using the virtual address
> of its registers instead of the physical one -- fix this, taking into account
> that actually the whole megabyte is decoded by any of the programmable serial
> controllers (one of which is SMBus), and that all the Alchemy peripherals are
> directly mappable into KSEG1 kernel space and therefore ioremap() call would
> just boil down to CKSEG1ADDR() invocation.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> I'm not sure thru which tree this should go -- probably thru Linux/MIPS one...

Looks ok, so I'll send it to Linus.

  Ralf
