From: Jesse Barnes <jesse.barnes-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] PCI: Unhide the SMBus on the Compaq Evo D510 USDT
Date: Tue, 28 Jul 2009 09:56:10 -0700
Message-ID: <20090728095610.6fbd0483@jbarnes-g45>
References: <20090728114919.211f48a3@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090728114919.211f48a3-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Nuzhna Pomoshch <nuzhna_pomoshch-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 28 Jul 2009 11:49:19 +0200
Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:

> Subject: PCI: Unhide the SMBus on the Compaq Evo D510 USDT
> 
> One more form factor for Compaq Evo D510, which needs the same quirk
> as the other form factors. Apparently there's no hardware monitoring
> chip on that one, but SPD EEPROMs, so it's still worth unhiding the
> SMBus.
> 
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Jesse Barnes <jbarnes-Y1mF5jBUw70BENJcbMCuUQ@public.gmane.org>
> Tested-by: Nuzhna Pomoshch <nuzhna_pomoshch-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
> ---

Applied to my linux-next branch, thanks.

-- 
Jesse Barnes, Intel Open Source Technology Center
