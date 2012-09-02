From: Tabi Timur-B04825 <B04825-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH] i2c-mpc: Wait for STOP to hit the bus
Date: Sun, 2 Sep 2012 02:48:01 +0000
Message-ID: <6AE080B68D46FC4BA2D2769E68D765B708019E97@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1346323204-19210-1-git-send-email-Joakim.Tjernlund@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1346323204-19210-1-git-send-email-Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Content-Language: en-US
Content-ID: <C47CCF21CF3B164CA6845A481A87A847-725oAoX4OcF2GV6JINhBVAC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joakim Tjernlund <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Aug 30, 2012 at 5:40 AM, Joakim Tjernlund
<Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org> wrote:

> -       mpc_i2c_stop(i2c);
> +       mpc_i2c_stop(i2c); /* Initiate STOP */
> +       orig_jiffies = jiffies;
> +       /* Wait until STOP is seen, allow up to 1 s */
> +       while (readb(i2c->base + MPC_I2C_SR) & CSR_MBB) {
> +               if (time_after(jiffies, orig_jiffies + HZ)) {
> +                       u8 status = readb(i2c->base + MPC_I2C_SR);
> +
> +                       dev_dbg(i2c->dev, "timeout\n");
> +                       if ((status & (CSR_MCF | CSR_MBB | CSR_RXAK)) != 0) {
> +                               writeb(status & ~CSR_MAL,
> +                                      i2c->base + MPC_I2C_SR);
> +                               mpc_i2c_fixup(i2c);
> +                       }
> +                       return -EIO;
> +               }
> +               cond_resched();
> +       }

Shouldn't the while-loop be inside mpc_i2c_stop() itself?

-- 
Timur Tabi
Linux kernel developer at Freescale
