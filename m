From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-piix4: support multiple PIIX4 SMBus hosts
Date: Mon, 4 Jun 2012 09:16:43 +0200
Message-ID: <20120604091643.208956fe@endymion.delvare>
References: <1338574572-10668-1-git-send-email-andrew@asquaredlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1338574572-10668-1-git-send-email-andrew-Lwj1yN59in/Ib2jZbfQ/kQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Armenia <andrew-Lwj1yN59in/Ib2jZbfQ/kQ@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Andrew,

On Fri,  1 Jun 2012 14:16:12 -0400, Andrew Armenia wrote:
> Some AMD chipsets have a second PIIX4-compatible host adapter accessible
> through a second set of registers (e.g. SP5100). Moved the global base
> address variable to an extension of struct i2c_adapter; added logic
> to detect chipset known to have this feature. Tested on ASUS KCMA-D8 board.

This would be much easier to review if you would split this change into
two patches, one moving the per-adapter settings out of the global
scope, and one adding support for the second base address.

Furthermore, the use of container_of seems inappropriate here, as there
is a proper interface for per-adapter attributes: i2c_set_adapdata() and
i2c_get_adapdata().

-- 
Jean Delvare
