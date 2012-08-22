From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: i2c-eg20t: regression since i2c_add_numbered_adapter change
Date: Wed, 22 Aug 2012 09:57:07 +0200
Message-ID: <3514180.RWySLZuOJm@ws-stein>
References: <4401854.hVfHzgeqjT@ws-stein> <20120822152918.3e59616e@feng-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120822152918.3e59616e@feng-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Feng Tang <feng.tang@intel.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, Tomoya MORINAGA <tomoya.rohm@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Hello,

On Wednesday 22 August 2012 15:29:18, Feng Tang wrote:
> On Wed, 22 Aug 2012 08:30:35 +0200
> Alexander Stein <alexander.stein@systec-electronic.com> wrote:
> 
> > Hello,
> > 
> > I just noticed the 3.4 linux kernel fails to sucessfully probe the i2c-eg20t 
> > driver. I returns with EBUSY error. It worked on the 3.0 kernel. To my view it 
> > is caused the commit 07e8a51ff68353e01d795cceafbac9f54c49132b ( i2c-eg20t: use 
> > i2c_add_numbered_adapter to get a fixed bus number).
> > The reason it actually fails is that the i2c-isch driver is registered 
> > beforehand which gets bus number 0. But this one is the bus number the eg20t 
> > driver wants to register.
> 
> Make sense.
> 
> > A possibility is that if i2c_add_numbered_adapter failed with EBUSY just use 
> > i2c_add_adapter to get at least the driver working, but with a non-fixed bus 
> > number. Opinions?
> 
> Or can we give it a fixed offset, like let the i2c_eg20t controller bus number
> start with 4? I don't expect there will be more than 4 other i2c controllers 
> on EG20T compatible platforms.

Why use a fixed one? Give the driver (and maybe every i2c bus driver) a parameter which sets the base bus number it should use.
E.g. i2c-eg20t.base-bus-num=2 so it will register the bus numbers starting from 2. If this parameter is unset. It would use the first free one, thus simply using i2c_add_adapter.

Regards,
Alexander
