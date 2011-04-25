From: Jesse Barnes <jbarnes-Y1mF5jBUw70BENJcbMCuUQ@public.gmane.org>
Subject: Re: [PATCH] i2c-i801: Move device ID definitions to driver
Date: Mon, 25 Apr 2011 11:45:20 -0700
Message-ID: <20110425114520.741ff0ff@jbarnes-desktop>
References: <20110423095808.6f6ee01d@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110423095808.6f6ee01d-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, 23 Apr 2011 09:58:08 +0200
Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:

> Move the SMBus device ID definitions of recent devices from pci_ids.h
> to the i2c-i801.c driver file. They don't have to be shared, as they
> are clearly identified and only used in this driver. In the future,
> such IDs will go to i2c-i801 directly. This will make adding support
> for new devices much faster and easier, as it will avoid cross-
> subsystem patch sets and merge conflicts.
> 
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Jesse Barnes <jbarnes-Y1mF5jBUw70BENJcbMCuUQ@public.gmane.org>
> ---

Acked-by: Jesse Barnes <jbarnes-Y1mF5jBUw70BENJcbMCuUQ@public.gmane.org>

You can just push this through your tree.  Thanks Jean.

-- 
Jesse Barnes, Intel Open Source Technology Center
