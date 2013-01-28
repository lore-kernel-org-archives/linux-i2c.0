From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2] i2c-isch: Add module parameter for backbone clock
 rate if divider is unset
Date: Mon, 28 Jan 2013 14:17:07 +0100
Message-ID: <20130128141707.11eb02da@endymion.delvare>
References: <1359366252-22250-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1359366252-22250-1-git-send-email-alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 28 Jan 2013 10:44:12 +0100, Alexander Stein wrote:
> It was observed the Host Clock Divider was not written by the driver. It
> was still set to (default) 0, if not already set by BIOS, which caused
> garbage on SMBus.
> This driver adds a parameters which is used to calculate the divider
> appropriately for a default bitrate of 100 KHz. This new divider is only
> applied if the clock divider is still default 0.
> 
> Signed-off-by: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
> ---
> Changes in v2:
> * Removed useless debug output
> * Added description comment about calculation into code
> * Some code organization changes
> 
>  drivers/i2c/busses/i2c-isch.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> (...)

Reviewed-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

-- 
Jean Delvare
