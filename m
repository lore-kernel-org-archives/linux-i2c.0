From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: i2c-eg20t: regression since i2c_add_numbered_adapter change
Date: Wed, 22 Aug 2012 15:29:18 +0800
Message-ID: <20120822152918.3e59616e@feng-i7>
References: <4401854.hVfHzgeqjT@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4401854.hVfHzgeqjT@ws-stein>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 22 Aug 2012 08:30:35 +0200
Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org> wrote:

> Hello,
> 
> I just noticed the 3.4 linux kernel fails to sucessfully probe the i2c-eg20t 
> driver. I returns with EBUSY error. It worked on the 3.0 kernel. To my view it 
> is caused the commit 07e8a51ff68353e01d795cceafbac9f54c49132b ( i2c-eg20t: use 
> i2c_add_numbered_adapter to get a fixed bus number).
> The reason it actually fails is that the i2c-isch driver is registered 
> beforehand which gets bus number 0. But this one is the bus number the eg20t 
> driver wants to register.

Make sense.

> A possibility is that if i2c_add_numbered_adapter failed with EBUSY just use 
> i2c_add_adapter to get at least the driver working, but with a non-fixed bus 
> number. Opinions?

Or can we give it a fixed offset, like let the i2c_eg20t controller bus number
start with 4? I don't expect there will be more than 4 other i2c controllers 
on EG20T compatible platforms.

Thanks,
Feng
