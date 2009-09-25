From: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Subject: Re: [PATCH] i2c-mpc: Do not generate STOP after read.
Date: Fri, 25 Sep 2009 12:01:17 +0200
Message-ID: <4ABC94ED.6070508@grandegger.com>
References: <1253620242-18461-1-git-send-email-Joakim.Tjernlund@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1253620242-18461-1-git-send-email-Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joakim Tjernlund <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Esben Haabendal <eha-SIcX2qgNSybd/EuGEV170n9LOBIZ5rWg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Joakim Tjernlund wrote:
> The driver always ends a read with a STOP condition which
> breaks subsequent I2C reads/writes in the same transaction as
> these expect to do a repeated START(ReSTART).
> 
> This will also help I2C multimaster as the bus will not be released
> after the first read, but when the whole transaction ends.
> 
> Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Tested-by: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>

on a MPC8548 board with an up-to-date kernel. I did not realize any
problems.

Wolfgang.
