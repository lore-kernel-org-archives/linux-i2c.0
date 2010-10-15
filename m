From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 0/1] misc: Add Tunnel creek In-Vehicle I2C loader driver
Date: Fri, 15 Oct 2010 13:30:17 +0100
Message-ID: <20101015123017.GL14782@rakim.wolfsonmicro.main>
References: <1283956897.4593.12.camel@debian>
 <4CA2FB10.2020605@pelagicore.com>
 <20101015104902.1047c978@endymion.delvare>
 <20101015121042.GA27369@sirena.org.uk>
 <20101015142130.1cf14629@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20101015142130.1cf14629-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Richard Rojfors <richard.rojfors-gfIc91nka+FZroRs9YW3xA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Oct 15, 2010 at 02:21:30PM +0200, Jean Delvare wrote:

> My point still holds, regardless of what exactly Intel has in the
> works: if board config is now needed on some x86 systems, then support
> for it should be added in the same way other architectures did before.
> I can't see any reason why x86 would be different.

Oh, absolutely - I'm just saying that the existing Intel work isn't
useful for this as it's tied to Moorestown and SFI.
