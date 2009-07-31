From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Sample DTS entries and sample user space code
Date: Fri, 31 Jul 2009 09:27:10 +0200
Message-ID: <20090731092710.678f7b38@hyperion.delvare>
References: <50A8E1F8D9122546A7F67134915EDB7AB91AB4@xmb-rtp-21a.amer.cisco.com>
	<20090714095701.0aec363e@hyperion.delvare>
	<50A8E1F8D9122546A7F67134915EDB7AC2D44D@xmb-rtp-21a.amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50A8E1F8D9122546A7F67134915EDB7AC2D44D-1urkduz2x36J+CMdqUBC+pT4Y6eR2OpR0E9HWUfgJXw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Lindsey Ings -X (ingsl - Yoh Services LLC at Cisco)" <ingsl-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Lindsey,

On Tue, 28 Jul 2009 16:38:24 -0400, Lindsey Ings -X (ingsl - Yoh Services LLC at Cisco) wrote:
> 
> Since I can't use the DTS I'm now trying to instantiate the mux through
> other means.  I put the code below in
> ".../arch/powerpc/platforms/44x/myBoard.c".  Is this the intended
> instantiation?  I have 2 i2c busses on my SOC and I have 2 muxes (with 4
> ports each) on the second SOC bus.  Therefore, I'd want the first mux to
> have busses 2,3,4,5 and the second mux to have 6,7,8,9:
> 
> static struct pca954x_platform_mode pca954x_modes_mux0[] = {
> 	    {
> 	    	.adap_id        = 2,
> 	    },
> 	    {
> 	    	.adap_id        = 3,
> 	    },
> 	    {
> 	    	.adap_id        = 4,
> 	    },
> 	    {
> 	    	.adap_id        = 5,
> 	    },
> };
> 
> static struct pca954x_platform_mode pca954x_modes_mux1[] = {
> 	    {
> 	    	.adap_id        = 6,
> 	    },
> 	    {
> 	    	.adap_id        = 7,
> 	    },
> 	    {
> 	    	.adap_id        = 8,
> 	    },
> 	    {
> 	    	.adap_id        = 9,
> 	    },
> };
> 
> static struct pca954x_platform_data pca9544_data_mux0 = {
>     	.modes          = pca954x_modes_mux0,
>         .num_modes      = ARRAY_SIZE(pca954x_modes_mux0),
> };
> 
> static struct pca954x_platform_data pca9544_data_mux1 = {
>     	.modes          = pca954x_modes_mux1,
>         .num_modes      = ARRAY_SIZE(pca954x_modes_mux1),
> };
> 
> static struct i2c_board_info __initdata i2c_bus1_devices[] = {
>     {
>         /* I2C mux */
>         I2C_BOARD_INFO("pca9544", 0x70),
>         .platform_data = &pca9544_data_mux0,
>     },
>     {
>         /* I2C mux */
>         I2C_BOARD_INFO("pca9544", 0x71),
>         .platform_data = &pca9544_data_mux1,
>     },
> };

I don't know the pca954x driver (not yet in mainline), Rodolfo would be
a better reviewer, but the above at least looks reasonable to me. I am
a little surprised that you are able to force the adapters IDs for the
segments behind the muxes though, if you do not declare any device on
them, i2c-core will not reserve the IDs for static numbering.

> static int __init board_i2c_init(void)
> {
>     /* Register board i2c devices */   
>     i2c_register_board_info(0, i2c_bus1_devices,

This, OTOH, looks wrong. If the muxes are on your second SOC I2C bus,
the bus number would be 1, not 0.

>                 ARRAY_SIZE(i2c_bus1_devices));
> 
>     return 0;
> }
> arch_initcall(board_i2c_init);

-- 
Jean Delvare
