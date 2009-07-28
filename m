From: "Lindsey Ings -X (ingsl - Yoh Services LLC at Cisco)"
	<ingsl-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
Subject: RE: Sample DTS entries and sample user space code
Date: Tue, 28 Jul 2009 16:38:24 -0400
Message-ID: <50A8E1F8D9122546A7F67134915EDB7AC2D44D@xmb-rtp-21a.amer.cisco.com>
References: <50A8E1F8D9122546A7F67134915EDB7AB91AB4@xmb-rtp-21a.amer.cisco.com> <20090714095701.0aec363e@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <20090714095701.0aec363e-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


Since I can't use the DTS I'm now trying to instantiate the mux through
other means.  I put the code below in
".../arch/powerpc/platforms/44x/myBoard.c".  Is this the intended
instantiation?  I have 2 i2c busses on my SOC and I have 2 muxes (with 4
ports each) on the second SOC bus.  Therefore, I'd want the first mux to
have busses 2,3,4,5 and the second mux to have 6,7,8,9:

static struct pca954x_platform_mode pca954x_modes_mux0[] = {
	    {
	    	.adap_id        = 2,
	    },
	    {
	    	.adap_id        = 3,
	    },
	    {
	    	.adap_id        = 4,
	    },
	    {
	    	.adap_id        = 5,
	    },
};

static struct pca954x_platform_mode pca954x_modes_mux1[] = {
	    {
	    	.adap_id        = 6,
	    },
	    {
	    	.adap_id        = 7,
	    },
	    {
	    	.adap_id        = 8,
	    },
	    {
	    	.adap_id        = 9,
	    },
};

static struct pca954x_platform_data pca9544_data_mux0 = {
    	.modes          = pca954x_modes_mux0,
        .num_modes      = ARRAY_SIZE(pca954x_modes_mux0),
};

static struct pca954x_platform_data pca9544_data_mux1 = {
    	.modes          = pca954x_modes_mux1,
        .num_modes      = ARRAY_SIZE(pca954x_modes_mux1),
};

static struct i2c_board_info __initdata i2c_bus1_devices[] = {
    {
        /* I2C mux */
        I2C_BOARD_INFO("pca9544", 0x70),
        .platform_data = &pca9544_data_mux0,
    },
    {
        /* I2C mux */
        I2C_BOARD_INFO("pca9544", 0x71),
        .platform_data = &pca9544_data_mux1,
    },
};

static int __init board_i2c_init(void)
{
    /* Register board i2c devices */   
    i2c_register_board_info(0, i2c_bus1_devices,
                ARRAY_SIZE(i2c_bus1_devices));

    return 0;
}
arch_initcall(board_i2c_init);

 
Regards,
 
Lindsey
 
-----Original Message-----
From: Jean Delvare [mailto:khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org] 
Sent: Tuesday, July 14, 2009 3:57 AM
To: Lindsey Ings -X (ingsl - Yoh Services LLC at Cisco)
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org
Subject: Re: Sample DTS entries and sample user space code

On Fri, 10 Jul 2009 17:09:47 -0400, Lindsey Ings -X (ingsl - Yoh
Services LLC at Cisco) wrote:
> 
> 
> Resend of message in plain text form.
> 
> 
> I understand the concepts involved in this project but that doesn't
help me actually make use of it.

For reference for other readers who have no clue what you're talking
about: Lindsey is referring to Rodolfo's I2C multiplexing support
project, described at:
http://i2c.wiki.kernel.org/index.php/I2C_bus_multiplexing

> Is there a sample of how to put the mux and (if feasible) I2C clients
in a DTS?

Not yet. Rodolfo's code is not even in mainline. But once
implementation is complete, then yes it should be possible to declare
I2C multiplexers and other I2C devices in a DTS.

> Also is there a user application sample of how to access the devices
downstream from the mux?

This wouldn't make sense. Multiplexing is handled in the kernel and
user-space does not even know it is happening.

> Are the mux's created as a device so that the devices downstream are
accessed as non-mux'd devices? i.e. is dev D in segment 2 (from the
diagram on the wiki) accessed as so:
> 
> int fd;
> fd = open( "/dev/i2c-2", O_RDWR );
> 
> #define ADDRESS 0x38 // address of dev D
> ioctl( fd, I2C_SLAVE, ADDRESS )
> 
> // Now r/w dev D
> 
> // Write 0xAA to dev D
> i2c_smbus_write_byte( fd, 0xAA );
> // etc.

Yes, this is how the code would look like.

Note that I am still waiting for Rodolfo to update his patch set so
that it applies again on top of Linus' latest kernel.

-- 
Jean Delvare
