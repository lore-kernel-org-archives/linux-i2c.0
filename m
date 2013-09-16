From: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [linuxppc-release] [Patch v2] power/mpc85xx: Add delay after
 enabling I2C master
Date: Mon, 16 Sep 2013 16:40:03 -0700
Message-ID: <523796D3.7040105@freescale.com>
References: <1379369185-14590-1-git-send-email-yorksun@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379369185-14590-1-git-send-email-yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 09/16/2013 03:06 PM, York Sun wrote:
> Erratum A-006037 indicates I2C controller executes the write to I2CCR only
> after it sees SCL idle for 64K cycle of internal I2C controller clocks. If
> during this waiting period, I2C controller is disabled (I2CCR[MEN] set to
> 0), then the controller could end in bad state, and hang the future access
> to I2C register.
> 
> The mpc_i2c_fixup() function tries to recover the bus from a stalled state
> where the 9th clock pulse wasn't generated. However, this workaround
> disables and enables I2C controller without meeting waiting requirement of
> this erratum.
> 
> This erratum applies to some 85xx SoCs. It is safe to apply to all of them
> for mpc_i2c_fixup().
> 
> Signed-off-by: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
> Change log:
>  v2: remote reviewed-by and tested-by lines added by gerrit
>      send to proper mailing list

Pardon my typo. I meant to type "remove", instead of "remote".

York
