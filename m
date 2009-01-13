From: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH] powerpc/83xx: Move mcu_mpc8349emitx driver out of drivers/i2c/chips/
Date: Tue, 13 Jan 2009 08:39:37 -0600
Message-ID: <D5E479F3-2208-4803-BE83-F22F50247F21@kernel.crashing.org>
References: <20090111165136.GA26096@oksana.dev.rtsoft.ru> <20090111165539.GA27223@oksana.dev.rtsoft.ru>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090111165539.GA27223-wnGakbxT3iijyJ0x5qLZdcN33GVbZNy3@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


On Jan 11, 2009, at 10:55 AM, Anton Vorontsov wrote:

> This patch is used to help Jean Delvare to get rid of drivers/i2c/ 
> chips/
> directory. The new location suggested by Kumar Gala: as the driver is
> 83xx specific it's placed into arch/powerpc/platforms/83xx/.
>
> Signed-off-by: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
> ---
>
> The same patch but suitable for patch(1).
>
> arch/powerpc/platforms/83xx/Makefile           |    1 +
> arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c |  209 +++++++++++++++ 
> +++++++++
> arch/powerpc/platforms/Kconfig                 |   11 ++
> drivers/i2c/chips/Kconfig                      |   11 --
> drivers/i2c/chips/Makefile                     |    1 -
> drivers/i2c/chips/mcu_mpc8349emitx.c           |  209  
> ------------------------
> 6 files changed, 221 insertions(+), 221 deletions(-)
> create mode 100644 arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
> delete mode 100644 drivers/i2c/chips/mcu_mpc8349emitx.c

applied

- k
