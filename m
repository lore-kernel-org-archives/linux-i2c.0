From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c_intel_mid: Improve error reporting
Date: Thu, 27 Jan 2011 00:44:23 +0000
Message-ID: <20110127004422.GI15795@trinity.fluff.org>
References: <20110125142040.9472.88734.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110125142040.9472.88734.stgit-Z/y2cZnRghHXmaaqVzeoHQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Jan 25, 2011 at 02:20:48PM +0000, Alan Cox wrote:
> From: Catalin Popescu <catalinx.popescu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> The error messages printed from mrst_i2c_abort() didn't give slave address info.
> 
> But I2C device driver developers always need this to check which slave device
> has the problem.

Erm, surely the driver itself should know what i2c device it is communicating
with? Secondly, does this swamp the kernel dmesg buffer when run with the
i2c-detect tool?
 
> This patch enhances the error message format by adding slave address info to
> each error message.

Why not use dev_err() on the i2c device's device state?
 
-- 
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
