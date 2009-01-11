From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] powerpc/83xx: Move mcu_mpc8349emitx driver out of
 drivers/i2c/chips/
Date: Sun, 11 Jan 2009 18:10:55 +0100
Message-ID: <20090111181055.31611474@hyperion.delvare>
References: <20090111165136.GA26096@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090111165136.GA26096-wnGakbxT3iijyJ0x5qLZdcN33GVbZNy3@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Cc: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Anton,

On Sun, 11 Jan 2009 19:51:36 +0300, Anton Vorontsov wrote:
> This patch is used to help Jean Delvare to get rid of drivers/i2c/chips/
> directory. The new location suggested by Kumar Gala: as the driver is
> 83xx specific it's placed into arch/powerpc/platforms/83xx/.
> 
> Signed-off-by: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>

Thanks for doing this. Do you expect me to take this patch in my i2c
tree, or will it go in some powerpc tree?

-- 
Jean Delvare
