From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RESEND PATCH 00/12] eeprom: at24: remove platform_data
Date: Tue, 22 Jan 2019 13:22:28 +0100
Message-ID: <20190122122228.GA2736@kroah.com>
References: <20190108091539.16674-1-brgl@bgdev.pl>
 <8c190cf3-b4f3-90d0-07ce-4bb7927160df@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8c190cf3-b4f3-90d0-07ce-4bb7927160df@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Kevin Hilman <khilman@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

On Thu, Jan 10, 2019 at 07:43:47PM +0530, Sekhar Nori wrote:
> Hi Bartosz,
> 
> On 08/01/19 2:45 PM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > 
> > Hi Sekhar,
> > 
> > now that all dependencies are in and v5.0-rc1 is tagged, please consider
> > picking up the second batch of davinci-specific changes into your tree.
> > Once that's done, please provide me with an immutable branch for me to
> > apply the last patch to my at24 tree.
> 
> You can use branch v5.1/eeprom-for-bartosz in my tree for this (commit
> e430685f4969).
> 
> > 
> > This is the second part of the effort to modernize the at24 driver and
> > remove the legacy platform data structure in favor of device properties.
> > It required getting rid of the at24 setup callback in favor of nvmem
> > lookups.
> > 
> > Re-tested with da850-evm and dm365-evm.
> 
> Applied patches 1-11 for v5.1

Feel free to take patch 12 as well :)

thanks,

greg k-h
