From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 0/1] misc: Add Tunnel creek In-Vehicle I2C loader driver
Date: Fri, 15 Oct 2010 13:10:43 +0100
Message-ID: <20101015121042.GA27369@sirena.org.uk>
References: <1283956897.4593.12.camel@debian> <4CA2FB10.2020605@pelagicore.com> <20101015104902.1047c978@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20101015104902.1047c978-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Richard R?jfors <richard.rojfors-gfIc91nka+FZroRs9YW3xA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Oct 15, 2010 at 10:49:02AM +0200, Jean Delvare wrote:

> As a matter of fact, I have been discussing this with Intel people
> recently:
>   http://marc.info/?t=128683908500001&r=1&w=2
> It is pretty clear that Intel have added board config support to x86
> already, even though that change may not be public yet. So I can only
> encourage you to discuss this with Jacob Pan, Feng Tang and Alan Cox.

That stuff is very specific to the Moorestown CPUs and a new BIOS type
they have, the board_info part was posted on lkml about two weeks ago if
you search through the archives.
