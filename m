From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-xiic.c must always write 16-bit words to TX_FIFO
Date: Tue, 23 Apr 2013 18:42:52 +0200
Message-ID: <20130423164252.GC3228@the-dreams.de>
References: <517590CF.10609@harris.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <517590CF.10609-7/gz0mrWfc7QT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Steven A. Falco" <sfalco-7/gz0mrWfc7QT0dZR+AlfA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Apr 22, 2013 at 03:34:39PM -0400, Steven A. Falco wrote:
> The TX_FIFO register is 10 bits wide.  The lower 8 bits are the data to be
> written, while the upper two bits are flags to indicate stop/start.
> 
> The driver apparently attempted to optimize write access, by only writing a
> byte in those cases where the stop/start bits are zero.  However, we have
> seen cases where the lower byte is duplicated onto the upper byte by the
> hardware, which causes inadvertent stop/starts.
> 
> This patch changes the write access to the transmit FIFO to always be 16 bits
> wide.
> 
> Signed off by: Steven A. Falco <sfalco-7/gz0mrWfc7QT0dZR+AlfA@public.gmane.org>

Applied to for-next, and added stable, thanks!
