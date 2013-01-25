From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 3/3] i2c-i801: SMBus patch for Intel Avoton DeviceIDs
Date: Fri, 25 Jan 2013 21:19:22 +0100
Message-ID: <20130125211922.39bb71ef@endymion.delvare>
References: <1359144661-3528-1-git-send-email-seth.heasley@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1359144661-3528-1-git-send-email-seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 25 Jan 2013 12:11:01 -0800, Seth Heasley wrote:
> This patch adds the PCU SMBus DeviceID for the Intel Avoton SOC.
> 
> Signed-off-by: Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Reviewed-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

> ---
>  Documentation/i2c/busses/i2c-i801 |    1 +
>  drivers/i2c/busses/Kconfig        |    1 +
>  drivers/i2c/busses/i2c-i801.c     |    3 +++
>  3 files changed, 5 insertions(+), 0 deletions(-)

-- 
Jean Delvare
