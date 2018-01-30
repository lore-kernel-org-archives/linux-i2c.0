From: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Subject: Re: [PATCH v2 0/5] R-Car D3 (r8a77995) I2C integration
Date: Tue, 30 Jan 2018 10:26:56 +0100
Message-ID: <20180130092656.7zetd2w5nmi6moc4@verge.net.au>
References: <1517240748-14780-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1517240748-14780-1-git-send-email-ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulrich Hecht <ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, kieran.bingham-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Jan 29, 2018 at 04:45:43PM +0100, Ulrich Hecht wrote:
> Hi!
> 
> This adds I2C controllers to the D3 device tree and enables I2C busses 0
> and 1 on the Draak board. (I2C2 is not connected on that board.)
> 
> This revision addresses Geert's review comments and adds Reviewed-Bys.
> See below for details.
> 
> CU
> Uli
> 
> 
> Changes since v1:
> - pinctrl: patch dropped, has been picked up
> - i2c-rcar: patch dropped, redundant
> - dtsi: added dmac2 for i2c0-2
> - dtsi: fixed internal SCL delays
> - dts: fixed EEPROM compatible string
> - bindings: added Rohm EEPROM
> - bindings: fixed typo in i2c-rcar bindings
> 
> 
> Ulrich Hecht (5):
>   arm64: renesas: r8a77995: add I2C support
>   arm64: renesas: draak: enable I2C controller 0 and EEPROM
>   arm64: renesas: draak: enable I2C controller 1

Thanks, I have applied the arm64 patches after updating their prefix to
"arm64: dts: renesas:".

>   i2c: rcar: document R8A77995 bindings
>   dt-bindings: at24: add bindings for Rohm BR24T01
> 
>  Documentation/devicetree/bindings/eeprom/at24.txt  |  2 +
>  Documentation/devicetree/bindings/i2c/i2c-rcar.txt |  1 +
>  arch/arm64/boot/dts/renesas/r8a77995-draak.dts     | 28 +++++++++
>  arch/arm64/boot/dts/renesas/r8a77995.dtsi          | 67 ++++++++++++++++++++++
>  4 files changed, 98 insertions(+)
> 
> -- 
> 2.7.4
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
